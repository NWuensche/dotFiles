#!/usr/bin/env python3
# /// script
# requires-python = ">=3.10"
# dependencies = ["mistune>=3.0"]
# ///
"""confluence — copy markdown to the clipboard as Confluence-ready rich text.

Reads GitHub-flavored markdown (from stdin, or from the system clipboard with
--clipboard), renders it to HTML, and puts it on the clipboard as text/html so
pasting into the Confluence editor keeps headings / lists / tables / code
(a markdown "# Title" becomes a Confluence Heading 1).

Platform clipboard backends:
    macOS   -> osascript (rich public.html pasteboard)
    Wayland -> wl-copy --type text/html
    X11     -> xclip -selection clipboard -t text/html

Usage:
    echo '# Title' | uv run confluence_uv.py          # copy Confluence text
    uv run confluence_uv.py --clipboard               # convert current clipboard
    echo '# Title' | uv run confluence_uv.py --print  # print the HTML
"""
import argparse
import os
import platform
import shutil
import subprocess
import sys

FRAG_OPEN = "<!--StartFragment-->"
FRAG_CLOSE = "<!--EndFragment-->"


def render(md: str) -> str:
    """Render GitHub-flavored markdown to an HTML fragment (mistune)."""
    import mistune

    markdown = mistune.create_markdown(
        plugins=["table", "strikethrough", "task_lists", "url"]
    )
    return markdown(md).strip()


def wrap(html: str) -> str:
    return "\n".join([FRAG_OPEN, html, FRAG_CLOSE])


def read_clipboard_plain() -> str:
    """Read plain text from the system clipboard (for --clipboard mode)."""
    if platform.system() == "Darwin":
        return subprocess.run(["pbpaste"], capture_output=True, text=True).stdout
    if os.environ.get("WAYLAND_DISPLAY") and shutil.which("wl-paste"):
        return subprocess.run(["wl-paste"], capture_output=True, text=True).stdout
    if shutil.which("xclip"):
        return subprocess.run(
            ["xclip", "-selection", "clipboard", "-o"],
            capture_output=True,
            text=True,
        ).stdout
    sys.stderr.write("confluence: no clipboard reader back-end\n")
    sys.exit(3)


def copy_html(html: str) -> None:
    """Put `html` on the clipboard as rich text/html.

    Clipboard setters fork a long-lived serving daemon, so their stdout/stderr
    go to /dev/null (otherwise the daemon holds our pipes and we block forever).
    """
    data = html.encode("utf-8")
    if platform.system() == "Darwin":
        hex_data = html.encode("utf-8").hex()
        expr = "set the clipboard to \u00abdata HTML%s\u00bb" % hex_data
        subprocess.run(
            ["osascript", "-e", expr],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return
    if os.environ.get("WAYLAND_DISPLAY") and shutil.which("wl-copy"):
        subprocess.run(
            ["wl-copy", "--type", "text/html"],
            input=data,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return
    if shutil.which("xclip"):
        subprocess.run(
            ["xclip", "-selection", "clipboard", "-t", "text/html"],
            input=data,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return
    sys.stderr.write("confluence: no clipboard back-end available\n")
    sys.exit(4)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--clipboard", action="store_true",
                    help="read markdown from the clipboard instead of stdin")
    ap.add_argument("--print", action="store_true",
                    help="print HTML to stdout instead of copying")
    ap.add_argument("--no-fragment", action="store_true",
                    help="omit Start/EndFragment markers")
    args = ap.parse_args()

    text = read_clipboard_plain() if args.clipboard else sys.stdin.read()
    text = text.rstrip("\n")
    if not text.strip():
        sys.stderr.write("confluence: empty input\n")
        sys.exit(1)

    html = render(text)
    if not args.no_fragment:
        html = wrap(html)

    if args.print:
        sys.stdout.write(html + "\n")
        return

    copy_html(html)
    # Success is silent so callers can close over stdout.


if __name__ == "__main__":
    main()

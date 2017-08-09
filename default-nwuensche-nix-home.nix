with import <nixpkgs> {};
with import <nixhome> { inherit stdenv; inherit pkgs; };
mkHome {
  user = "nwuensche";
  files = {
	 ".vimrc" = "/etc/nixos/.vimrc";
  };
}

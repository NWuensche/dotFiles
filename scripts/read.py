import requests
import sys
from readability import Document

for line in sys.stdin:
    response = requests.get(line)
    doc = Document(response.text)
    print(doc.summary())

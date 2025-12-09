#!/bin/bash
set -e

PDF_FILE="docs/answer.pdf"

if [ ! -f "$PDF_FILE" ]; then
  echo "❌ PDF file $PDF_FILE missing"
  exit 1
fi

if [ ! -s "$PDF_FILE" ]; then
  echo "❌ PDF file $PDF_FILE is empty"
  exit 1
fi

echo "✅ PDF file found and not empty"
#!/bin/bash

echo "build GUIDE manual"
rm -r build/GUIDE
mkdir -p build/GUIDE/pdf
mkdir -p build/GUIDE/html
npx honkit pdf manuals/GUIDE/base build/GUIDE/pdf/GUIDE.pdf
npx honkit build manuals/GUIDE/base ../../../build/GUIDE/html/

#!/bin/bash

echo "build user manual"
rm -r build/user
mkdir -p build/user/pdf
mkdir -p build/user/html
npx honkit pdf manuals/USER/base build/user/pdf/user.pdf
npx honkit build manuals/USER/base ../../../build/user/html/

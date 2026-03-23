#!/bin/bash

echo "build admin manual"
rm -r build/admin
mkdir -p build/admin/pdf
mkdir -p build/admin/html
npx honkit pdf manuals/ADMIN/base build/admin/pdf/admin.pdf
npx honkit build manuals/ADMIN/base ../../../build/admin/html
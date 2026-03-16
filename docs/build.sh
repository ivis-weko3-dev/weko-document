#!/bin/bash

rm -r build/user
mkdir -p build/user/pdf
mkdir -p build/user/html
npx honkit pdf manuals/USER/base build/user/pdf/user.pdf
npx honkit build manuals/USER/base build/user/html/

rm -r build/admin
mkdir -p build/admin/pdf
mkdir -p build/admin/html
npx honkit pdf manuals/ADMIN/base build/admin/pdf/admin.pdf
npx honkit build manuals/ADMIN/base build/admin/html

rm -r build/spec
mkdir -p build/spec/pdf
mkdir -p build/spec/html
npx honkit pdf spec/base build/spec/pdf/spec.pdf
npx honkit build spec/base build/spec/html

rm -r build/未病User
mkdir -p build/未病User/pdf
mkdir -p build/未病User/html
npx honkit pdf manuals/未病User/base build/未病User/pdf/未病User.pdf
npx honkit build manuals/未病User/base build/未病User/html

rm -r build/GUIDE
mkdir -p build/GUIDE/pdf
mkdir -p build/GUIDE/html
npx honkit pdf manuals/GUIDE/base build/GUIDE/pdf/GUIDE.pdf
npx honkit build manuals/GUIDE/base build/GUIDE/html

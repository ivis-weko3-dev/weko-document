#!/bin/bash

rm -rvf build/spec
rm -rvf build/user
rm -rvf build/admin
mkdir -p build/spec
mkdir -p build/user
mkdir -p build/admin
npx honkit build spec/base/ ../../build/spec/
npx honkit build manuals/USER/base ../../build/user
npx honkit build manuals/ADMIN/base ../../build/admin


#!/bin/bash

sudo dnf install -y \
  @development-tools pkgconfig autoconf bison clang rustc pipx \
  openssl-devel readline-devel zlib-devel libyaml-devel ncurses-devel libffi-devel gdbm-devel jemalloc-devel \
  vips-devel ImageMagick ImageMagick-devel mupdf mupdf-devel \
  redis sqlite sqlite-devel community-mysql-devel libpq-devel postgresql

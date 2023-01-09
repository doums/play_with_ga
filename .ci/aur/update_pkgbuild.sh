#! /bin/bash

set -e

green="\e[38;5;2m"
bold="\e[1m"
reset="\e[0m"

pkgver="${RELEASE_TAG#v}"
pkgbuild=.ci/aur/PKGBUILD

# bump the package version
sed -i "s/pkgver=.*/pkgver=$pkgver/" $pkgbuild
printf "%b%b✓%b bump version to $RELEASE_TAG\n" "$green" "$bold" "$reset"

# generate the new checksum
sum=$(sha256sum "$PKG_NAME-v$pkgver".tar.gz | awk '{print $1}')
sed -i "s/sha256sums=('.*')/sha256sums=('$sum')/" $pkgbuild
printf "%b%b✓%b generated checksum $sum\n" "$green" "$bold" "$reset"

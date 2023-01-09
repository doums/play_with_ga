#! /bin/bash

set -e

ls -la

pkgver="${RELEASE_TAG#v}"
pkgbuild=.ci/aur/PKGBUILD

# bump the package version
sed -i "s/pkgver=.*/pkgver=$pkgver/" $pkgbuild

# generate the new checksum
sum=$(sha256sum "$PKG_NAME-v$pkgver".tar.gz | awk '{print $1}')
echo "$sum"
sed -i "s/sha256sums=('.*')/sha256sums=('.$sum')/" $pkgbuild

cat $pkgbuild

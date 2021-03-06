#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Assert licenses are available
cargo-bundle-licenses --format yaml --output CI.THIRDPARTY.yml --previous THIRDPARTY.yml --check-previous

# build statically linked binary with Rust
cargo install --locked --root "$PREFIX" --path .

# strip debug symbols
"$STRIP" "$PREFIX/bin/crabz"

# remove extra build file
rm -f "${PREFIX}/.crates.toml"

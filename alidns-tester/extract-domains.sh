#!/usr/bin/env bash
set -e

curl -s https://raw.githubusercontent.com/carrnot/china-domain-list/release/domain.txt \
  -o domains.txt &&
  sed -i '1201,$d' domains.txt

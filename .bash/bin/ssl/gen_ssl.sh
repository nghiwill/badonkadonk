#!/bin/bash

set -e

function section {
  echo
  echo "--------------------------------------------------------------"
  echo "$@"
  echo "--------------------------------------------------------------"
}

for a in "$@"; do
	[[ -f _$a.crt ]] || {
    section create a wildcard server certificate signed by the intermediate
    openssl req -new -newkey rsa:4096 -nodes -out _.$a.csr -keyout _.$a.key -subj "/C=US/ST=California/L=Berkeley/O=Destructuring/CN=*.$a"
    openssl x509 -req -days 365 -in _.$a.csr -CA destructuring_ca.crt -CAkey destructuring_ca.key -CAcreateserial -CAserial destructuring_ca.srl -out _.$a.crt
    openssl verify -CAfile destructuring_ca.crt _.$a.crt
  }

	[[ -f $a.crt ]] || {
    section create a wildcard server certificate signed by the intermediate
    openssl req -new -newkey rsa:4096 -nodes -out $a.csr -keyout $a.key -subj "/C=US/ST=California/L=Berkeley/O=Destructuring/CN=$a"
    openssl x509 -req -days 365 -in $a.csr -CA destructuring_ca.crt -CAkey destructuring_ca.key -CAcreateserial -CAserial destructuring_ca.srl -out $a.crt
    openssl verify -CAfile destructuring_ca.crt $a.crt
  }
done

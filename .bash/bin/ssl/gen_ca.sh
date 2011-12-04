#!/bin/bash

function section {
  echo
  echo "--------------------------------------------------------------"
  echo "$@"
  echo "--------------------------------------------------------------"
}

section generating CA key
openssl genrsa -des3 -out destructuring_ca.key 4096

section create your CA
openssl req -new -x509 -days 1825 -key destructuring_ca.key -out destructuring_ca.crt -subj "/C=US/ST=California/L=Berkeley/O=Destructuring/CN=Destructuring CA"

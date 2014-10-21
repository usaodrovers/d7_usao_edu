#!/bin/bash -v
 
# Fetch the CI GitHub user's encrypted private key
curl -L -o travisci_rsa.enc "$TRAVIS-KEY-URL"
 
# Decrypt the CI GitHub user's private key and add it to SSH key list
openssl aes-256-cbc -k "$TRAVIS-KEY-SECRET" -in travisci_rsa.enc -d -a -out id_rsa
ssh-add -D
chmod 600 id_rsa
ssh-add ./id_rsa
 
# Init all submodules now that CI GitHub user's private key is added
git submodule update --init --recursive

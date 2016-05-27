#!/usr/bin/env bash
# Create a set if SSH keys
# Run this in the hduser account
mkdir -p ~/.ssh
ssh-keygen -t rsa -P ""
cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
# eof

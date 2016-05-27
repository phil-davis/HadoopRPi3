#!/usr/bin/env bash
# Create a group called hadoop
sudo addgroup hadoop
# Create a user called hduser and put it in the hadoop group
sudo adduser --ingroup hadoop hduser
# Also add hduser to sudo
sudo adduser hduser sudo
# eof

#!/usr/bin/env bash
# Assumes that user hduser and group hadoop already exist.
# They can be created by:
#   sudo addgroup hadoop
#   sudo adduser --ingroup hadoop hduser
#   (enter password for user and default info as asked)
#   sudo adduser hduser sudo

# Get a copy of Hadoop 2.7.2 
wget http://apache.mirrors.spacedump.net/hadoop/core/stable/hadoop-2.7.2.tar.gz
sudo mkdir -p /opt
# Unpack it under /opt
sudo tar -xvzf hadoop-2.7.2.tar.gz -C /opt/
sudo mv /opt/hadoop-2.7.2 /opt/hadoop
# And make it owned by hduser
sudo chown -R hduser:hadoop /opt/hadoop
# eof

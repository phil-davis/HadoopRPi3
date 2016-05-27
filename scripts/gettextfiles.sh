#!/usr/bin/env bash
# Make a textfiles sub-directory if it does not exist
mkdir -p textfiles
cd ./textfiles

# Get and unpack smallfile.txt (about 1.2MB) and mediumfile.txt (about 35MB) (thanks to widriksson site)
# These are handy for demonstrating wordcount
# Note: See http://www.widriksson.com/raspberry-pi-2-hadoop-2-cluster/ for a good tutorial of setting up an RPi Hadoop cluster
wget http://www.widriksson.com/wp-content/uploads/2014/10/hadoop_sample_txtfiles.tar.gz
tar -xf hadoop_sample_txtfiles.tar.gz

# Get and unpack the text of some other famous books available from the Gutenberg project
# Ulysses by James Joyce
wget http://www.gutenberg.org/files/4300/4300.zip
unzip 4300.zip

# Adventures of Huckleberry Finn by Mark Twain
wget http://www.gutenberg.org/files/76/76.zip
unzip 76.zip

# War and Peace by Leo Tolstoy
wget http://www.gutenberg.org/files/2600/2600.zip
unzip 2600.zip

# eof

#!/bin/bash

mkdir blobs

abootimg -x "$1" /dev/null /dev/null blobs/initrd.img

#!/bin/sh

# Note that enum.pl should be in PATH for this script to work and
# JHBUILD_PREFIX should be defined to contain the path to the prefix (install)
# directory of jhbuild.

if [ -z "$JHBUILD_PREFIX" -o ! -x "`which enum.pl`" ]; then
  echo "JHBUILD_PREFIX must contain path to jhbuild prefix and enum.pl needs to be executable and in PATH."
  exit 1;
fi

PREFIX=$JHBUILD_PREFIX

enum.pl $PREFIX/include/gstreamer-0.10/gst/{audio,cdda,fft,floatcast,interfaces,netbuffer,riff,rtp,rtsp,sdp,tag,pbutils,video}/*.h > gstbase_enums.defs


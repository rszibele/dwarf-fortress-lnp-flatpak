#!/usr/bin/env bash

if [ ! -d "/var/data/lnp/" ]; then
  notify-send "Dwarf Fortress LNP is being extracted. Please wait..."
  mkdir -p /var/data/
  cd /var/data/
  cp /app/share/lnp/LinuxLNP-0.47.03-rc1.tar.gz .
  tar -xvf LinuxLNP-0.47.03-rc1.tar.gz
  mv LinuxLNP-0.47.03-rc1/ lnp/
  rm LinuxLNP-0.47.03-rc1.tar.gz
  
  # set up symlinks for dwarf fortress.
  # it looks like it loads it manually so LD_PRELOAD doesn't seem to work...
  cd /var/data/lnp/df_linux/
  ln -s /app/lib/libSDL-1.2.so.0 libSDL-1.2.so.0
  ln -s /app/lib/libgtk-x11-2.0.so.0 libgtk-x11-2.0.so.0
  ln -s /app/lib/libSDL_image-1.2.so.0 libSDL_image-1.2.so.0
  ln -s /app/lib/libGLU.so.1 libGLU.so.1
  ln -s /app/lib/libSDL_ttf-2.0.so.0 libSDL_ttf-2.0.so.0
  # extract dwarf therapist, so that we don't need fuse
  cd /var/data/lnp/LNP/utilities/dwarf_therapist/
  ./dwarftherapist --appimage-extract
  rm dwarftherapist
  ln -s squashfs-root/usr/bin/dwarftherapist .
  # replace legendsbrowser.sh with our own launcher
  cd /var/data/lnp/LNP/utilities/legends_browser/
  mv legendsbrowser.sh legendsbrowser-original.sh
  cp /app/share/custom/legendsbrowser-launcher.sh legendsbrowser.sh
  # copy user config
  cp /app/share/lnp/PyLNP.user /var/data/lnp/
fi

cd /var/data/lnp/
./startlnp

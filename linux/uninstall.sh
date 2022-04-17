#!/usr/bin/env bash

INSTALL_PATH=/usr/share/X11/xkb

for FILE in ${INSTALL_PATH}/rules/base.lst ${INSTALL_PATH}/rules/evdev.lst ${INSTALL_PATH}/rules/base.xml ${INSTALL_PATH}/rules/evdev.xml ${INSTALL_PATH}/symbols/fr; do
  if [ -f "${FILE}.iook.bck" ]; then
    mv ${FILE}.iook.bck ${FILE}
  fi
done

echo "Uninstall done."

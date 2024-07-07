#!/usr/bin/env bash

# uninstall script
if [[ $1 == "uninstall" ]]; then
  defaults write -g ApplePressAndHoldEnabled -bool true
  rm -f ~/Library/KeyBindings/DefaultKeyBinding.Dict

  echo "Uninstall done."
  exit 0
fi

# install script
defaults write -g ApplePressAndHoldEnabled -bool false
cp DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.Dict

echo "Install done."

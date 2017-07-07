#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then
	OSNAME='Mac'
	OSDISTRO='Mac'
elif [ "$(uname -o)" == 'Cygwin' ]; then
	OSNAME='Windows'
	OSDISTRO='Cygwin'
elif [ "$(uname -o)" == 'Msys' ]; then
	OSNAME='Windows'
	OSDISTRO='Msys'
elif [ -e "/etc/debian_version" ]; then
	OSNAME='Linux'
	OSDISTRO='Debian'
elif [ -e "/etc/redhat-release" ]; then
	OSNAME='Linux'
	OSDISTRO='Redhat'
else
	OSNAME='Linux'
	OSDISTRO='unknown'
fi

if [ $OSNAME = 'Mac' ]; then
	if [ -e ~/Library/Application\ Support/Code/User ];then
		VSCODE_DIR=~/Library/Application\ Support/Code/User
	fi
fi
echo $VSCODE_DIR
if [ -e "$VSCODE_DIR" ]; then

	if [ -e "$VSCODE_DIR/keybindings.json" ]; then
		rm "$VSCODE_DIR/keybindings.json"
	fi
	ln -s "$(pwd)/vscode/keybindings.json" "$VSCODE_DIR"

	if [ -e "$VSCODE_DIR/settings.json" ]; then
		rm "$VSCODE_DIR/settings.json"
	fi
	ln -s "$(pwd)/vscode/settings.json" "$VSCODE_DIR/settings.json"

	if [ -e "$VSCODE_DIR/snippets" ]; then
		rm -rf "$VSCODE_DIR/snippets"
	fi
	ln -s "$(pwd)/vscode/snippets" "$VSCODE_DIR"

fi

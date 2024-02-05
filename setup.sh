#!/bin/bash

set -o errexit
set -o pipefail

PATH_TO_DELETE='.ssh'
if [ -d "${PATH_TO_DELETE}" ]; then
	echo -n "'${PATH_TO_DELETE}' directory already exists, remove it to start over this process ? [y/N] "
	read -r yn
	if [ "${yn}" = 'y' ]; then
		rm -Rf "${PATH_TO_DELETE}" || exit 1
	else
		exit 0
	fi
fi
mkdir .ssh

if [[ ! -f ".vscode/settings.json" ]]; then
	echo "Copying .vscode/settings.json from template"
	cp -v .vscode/settings.template.json .vscode/settings.json
fi

echo "Generating ssh private key for jenkins agent"
ssh-keygen -t rsa -N "" -q -f .ssh/id_rsa
chmod 600 .ssh/id_rsa

echo "Generating ssh public key for jenkins agent"
ssh-keygen -y -f .ssh/id_rsa >/dev/null
chmod 755 .ssh/id_rsa.pub

echo "Generating .env file"
cp -v .env.template .env

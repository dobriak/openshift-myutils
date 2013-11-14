#!/bin/bash
echo "Spinning up a devenv"
pushd /root/development/li
build/devenv launch ineytchev-dev --verifier --ssh-config-verifier --express-server --verbose
echo "Syncing local with devenev"
build/devenv sync verifier
#echo "Syncing openshift-extras"
#rsync -av /root/development/openshift-extras verifier:/root

popd

#!/bin/bash
exercise_devenv(){
  echo "Testing devenv"
  ssh-keygen -R test01-tester.dev.rhcloud.com
  ssh-keygen -R test02-tester.dev.rhcloud.com
  rhc create-app test01 php-5.3 -s --no-git -p admin
  rhc create-app test02 php-5.3 -s --no-git -e /root/development/openshift-myutils/myenvs.txt -p admin
  rhc delete-app --confirm test01 -p admin
  rhc delete-app --confirm test02 -p admin
  echo "Done testing."
}

echo "Spinning up a devenv"
pushd /root/development/li
build/devenv launch ineytchev-dev --verifier --ssh-config-verifier --express-server --verbose

echo "Uploading key and creating a domain in devenv"
rhc create-domain tester -p admin
rhc sshkey add default /root/.ssh/id_rsa.pub -p admin

exercise_devenv

echo "Syncing local with devenev"
build/devenv sync verifier

exercise_devenv

echo "Done."
popd

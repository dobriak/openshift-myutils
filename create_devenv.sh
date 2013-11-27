#!/bin/bash
set -e
exercise_devenv(){
  echo "Testing devenv"
  ssh-keygen -R test01-tester.dev.rhcloud.com
  ssh-keygen -R test02-tester.dev.rhcloud.com
  scl enable ruby193 "rhc create-app test01 php-5.3 -s --no-git -p admin"
  echo "---rhc create-app test01 returned $?"
  scl enable ruby193 "rhc create-app test02 php-5.3 -s --no-git -e /root/development/openshift-myutils/env_vars_txt/f5_single_tenant_front.txt -p admin"
  echo "---rhc create-app test02 returned $?"
  scl enable ruby193 "rhc delete-app --confirm test01 -p admin"
  echo "---rhc delete app test01 returned $?"
  scl enable ruby193 "rhc delete-app --confirm test02 -p admin"
  echo "---rhc delete app test02 returned $?"
  echo "Done testing."
}
#check ruby version
#if [[ `ruby -v` != *1.9.3* ]]
#then
#  echo "Need ruby version 1.9.3"
#  exit 1
#fi

echo "Spinning up a devenv"
pushd /root/development/li
scl enable ruby193 "build/devenv launch ineytchev-dev --verifier --ssh-config-verifier --express-server --verbose"
echo "---devenv launch returned $?"

echo "Uploading key and creating a domain in devenv"
scl enable ruby193 "rhc create-domain tester -p admin"
echo "---rhc create-domain returned $?"
scl enable ruby193 "rhc sshkey add default /root/.ssh/id_rsa.pub -p admin"
echo "---rhc sshkey returned $?"

exercise_devenv

echo "Syncing local with devenev"
scl enable ruby193 "build/devenv sync verifier"
echo "---devenv sync returned $?"
exercise_devenv

echo "Done."
popd

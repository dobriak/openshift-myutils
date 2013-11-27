#!/bin/bash
ssh-keygen -R test01-tester.dev.rhcloud.com
ssh-keygen -R test02-tester.dev.rhcloud.com
ssh-keygen -R test03-tester.dev.rhcloud.com
scl enable ruby193 "rhc create-app test01 php-5.3 -s --no-git"
scl enable ruby193 "rhc create-app test02 php-5.3 -s --no-git -e /root/development/openshift-myutils/env_vars_txt/f5_single_tenant_front.txt"
scl enable ruby193 "rhc create-app test03 php-5.3 -s --no-git -e /root/development/openshift-myutils/env_vars_txt/f5_multi_tenant_front.txt"
scl enable ruby193 "rhc delete-app --confirm test01" 
scl enable ruby193 "rhc delete-app --confirm test02"
scl enable ruby193 "rhc delete-app --confirm test03"

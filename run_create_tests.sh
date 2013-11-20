#!/bin/bash
ssh-keygen -R test01-tester.dev.rhcloud.com
ssh-keygen -R test02-tester.dev.rhcloud.com
scl enable ruby193 "rhc create-app test01 php-5.3 -s --no-git"
scl enable ruby193 "rhc create-app test02 php-5.3 -s --no-git -e /root/development/openshift-myutils/single_tenant_front.txt"
scl enable ruby193 "rhc delete-app --confirm test01" 
scl enable ruby193 "rhc delete-app --confirm test02"
       

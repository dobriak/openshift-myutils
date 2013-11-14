#!/bin/bash
ssh-keygen -R test01-tester.dev.rhcloud.com
ssh-keygen -R test02-tester.dev.rhcloud.com
rhc create-app test01 php-5.3 -s --no-git
rhc create-app test02 php-5.3 -s --no-git -e ~/osedevelopment/myenvs.txt
rhc delete-app --confirm test01 
rhc delete-app --confirm test02
       

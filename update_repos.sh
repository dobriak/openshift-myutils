#~/bin/bash
echo "Updating git repos"
for dir in li origin-dev-tools rhc
do
  echo "Updating ${dir}"
  pushd ${dir}
  git fetch upstream
  git checkout master
  git merge upstream/master
  #git push origin --tags
  popd
done
echo "Done."

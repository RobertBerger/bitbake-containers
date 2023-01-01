1) create a new repo on github

bitbake-containers

2) add my-scripts dir

git clone git@github.com:RobertBerger/bitbake-containers.git

cd bitbake-containers/

echo "# hashsrv, prsrv containers" >> README.md

copy over a my-scripts from somewhere else

git add .

git commit -m "first commit"

git push -u origin master

3) add upstream

cd bitbake-containers

git remote add official-upstream git://git.openembedded.org/bitbake

git fetch official-upstream

git branch -a

4) use specific upstream branch/commit and make own branch

# syntax: git fetch url-to-repo branchname:refs/remotes/origin/branchname

git fetch git://git.openembedded.org/bitbake master:refs/remotes/official-upsteam/master

5) Update from upstream:
git co master
>> git remote -v

official-upstream       git://git.openembedded.org/bitbake (fetch)
official-upstream       git://git.openembedded.org/bitbake (push)
origin  git@github.com:RobertBerger/bitbake-containers.git (fetch)
origin  git@github.com:RobertBerger/bitbake-containers.git (push)

>> git fetch official-upstream

6) My own branch:
git co master
git co official-upstream/master
git checkout -b 2023-01-01-hashsrv

7.1) hack it

7.2) add/commit

git add .

git commit

8.3) push upstream

git co master
cd my-scripts
./push-all-to-github.sh

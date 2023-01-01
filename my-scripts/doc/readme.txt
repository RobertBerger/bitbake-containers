1) create a new repo on github

zephyr-build-container

2) add my-scripts dir

cd zephyr-build-container

echo "# github.com/zephyrproject-rtos/docker-image.git fork" >> README.md

git init

git add .

git commit -m "first commit"

git remote add origin git@github.com:RobertBerger/zephyr-build-container.git

git push -u origin master

3) use my repo

mv zephyr-build-container zephyr-build-container.ori
git clone git@github.com:RobertBerger/zephyr-build-container.git

4) add upstream

cd zephyr-build-container

git remote add official-upstream git://github.com/zephyrproject-rtos/docker-image

git fetch official-upstream

warning: no common commits
remote: Enumerating objects: 201, done.
remote: Counting objects: 100% (70/70), done.
remote: Compressing objects: 100% (52/52), done.
remote: Total 201 (delta 31), reused 33 (delta 16), pack-reused 131
Receiving objects: 100% (201/201), 39.40 KiB | 3.03 MiB/s, done.
Resolving deltas: 100% (97/97), done.
From git://github.com/zephyrproject-rtos/docker-image
 * [new branch]      master       -> official-upstream/master
 * [new branch]      v0.13-branch -> official-upstream/v0.13-branch
 * [new tag]         v0.13.1      -> v0.13.1
 * [new tag]         v0.17.3      -> v0.17.3
 * [new tag]         v0.10        -> v0.10
 * [new tag]         v0.11        -> v0.11
 * [new tag]         v0.13        -> v0.13
 * [new tag]         v0.14        -> v0.14
 * [new tag]         v0.15        -> v0.15
 * [new tag]         v0.16        -> v0.16
 * [new tag]         v0.17.0      -> v0.17.0
 * [new tag]         v0.17.0-rc1  -> v0.17.0-rc1
 * [new tag]         v0.17.1      -> v0.17.1
 * [new tag]         v0.17.2      -> v0.17.2
 * [new tag]         v0.8         -> v0.8
 * [new tag]         v0.9         -> v0.9


git branch -a

#5) use specific upstream branch/commit and make own branch
#
#syntax: git fetch url-to-repo branchname:refs/remotes/origin/branchname
#
#git fetch git://git.openembedded.org/meta-openembedded warrior:refs/remotes/origin/warrior

6) Update from upstream:
git co master
>> git remote -v

official-upstream       git://github.com/zephyrproject-rtos/docker-image (fetch)
official-upstream       git://github.com/zephyrproject-rtos/docker-image (push)
origin  git@github.com:RobertBerger/zephyr-build-container.git (fetch)
origin  git@github.com:RobertBerger/zephyr-build-container.git (push)

>> git fetch official-upstream
---

7) My own branch:
git co master
git co official-upstream/master
git checkout -b 2021-06-14-ub20-v2.6.0

$ git branch -a
* 2021-06-14-ub20-v2.6.0
  master
  remotes/official-upstream/master
  remotes/official-upstream/v0.13-branch
  remotes/origin/HEAD -> origin/master
  remotes/origin/master

8.1) hack it

8.2) add/commit

git add .

git commit

8.3) push upstream

git co master
cd my-scripts
./push-all-to-github.sh

#8) apply patches
#
#cd meta-virtualization
#
#git co 2019-09-09-warrior-2.7+
#
#stg init
#
#stg series
#
#stg import --mail ../meta-virtualization-patches/2019-09-09-warrior-2.7+/0001-use-systemd-as-cgroup-manager-for-docker-While-it-s-.patch
#
#import all patches
#
#...
#
#stg series
#
#stg commit --all
#
#git log
#
#git co master

9) push to my upstream

my-scripts/push-all-to-github.sh


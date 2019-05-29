# How to change origin to work with a new branch repository
#############################################################
# show the currently being used origin
git remote -v
origin  https://github.com/Rishon73/AOS_TruClient_buy_headphones_with_transactions.git (fetch)
origin  https://github.com/Rishon73/AOS_TruClient_buy_headphones_with_transactions.git (push)

# Remove the current origin
git remote remove origin
# set new origin
git remote add origin https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git
# show the currently being used origin
git remote -v
origin  https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git (fetch)
origin  https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git (push)

# made some changes to the code and now it's time to commit and push
git diff --name-only
ScriptUploadMetadata.xml
default.xml
mdrv_cmd.txt
git commit -m "removed my credentials" .\ScriptUploadMetadata.xml .\default.cfg .\mdrv_cmd.txt
[master e65950b] removed my credentials
 2 files changed, 4 insertions(+), 5 deletions(-)
 rewrite mdrv_cmd.txt (100%)
git push
fatal: The current branch master has no upstream branch.
To push the current branch and set the remote as upstream, use

    git push --set-upstream origin master

git push --set-upstream origin master
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 458 bytes | 458.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
remote: error: GH006: Protected branch update failed for refs/heads/master.
remote: error: At least 1 approving review is required by reviewers with write access.
To https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git
 ! [remote rejected] master -> master (protected branch hook declined)
error: failed to push some refs to 'https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git'
# create new branch named 'shiff'
git branch shiff
# Show who's the active branch
git branch -a
* master
  shiff
# set shiff as the active branch
git checkout shiff
Switched to branch 'shiff'
M       default.xml
git branch -a
  master
* shiff

# push changes to shiff branch under the origin (https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git)
git push -u origin shiff
Counting objects: 4, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 458 bytes | 458.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
remote:
remote: Create a pull request for 'shiff' on GitHub by visiting:
remote:      https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions/pull/new/shiff
remote:
To https://github.com/admpresales/AOS_TruClient_buy_headphones_with_transactions.git
 * [new branch]      shiff -> shiff
Branch 'shiff' set up to track remote branch 'shiff' from 'origin'.

---
title: Git CheatSheet
---

# Git Cheat Sheet

### Set user details:
```
>  git config --local user.name "Martin" 
>  git config --local user.email "martin@test.com" 
```
### Store Credentials Locally
```
> git config --global credential.helper 'store --file ~/.my-credentials'
```
### Remove Local Credentials
```
> git config credential.helper store
```
### Initialise (local) repo, add a file and commit:
```
>  git init 
>  git add my-file 
>  git commit -m "Created the file" 
```
To add all files in current directory:
```
>  git add -A
```

### Connect to remote GitHub and push the local Git repo up in GitHub:
```
>  git remote add origin https://github.com/mjnurse/git-test.git 
>  git push origin master 
```
### Pull remote GitHub to local Git:
```
>  git pull origin master
```
### Create a local Git repo as a clone of a GitHub repo:
```
>  git clone https://github.com/mjnurse/git-test.git . 
```
### Create a development branch and switch to (checkout) the development branch code to current directory:
```
>  git branch feature-x 
>  git checkout feature-x 
```
### Confirm we are now working on the branch feature-x:
```
>  git branch 
```
### Refresh local Git (master branch) from GitHub:
```
>  git checkout master 
>  git pull origin master 
```
### Merge Master into development branch:
```
>  git checkout feature-x 
>  git merge master 
```
### Push development branch up into GitHub (also creating branch in GitHub):
```
>  git push --set-upstream origin feature-x 
```

<hr>

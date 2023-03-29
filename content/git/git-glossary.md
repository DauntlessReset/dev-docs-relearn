---
title: Git Glossary
description: A glossary of commonly used Git Terminology
---


## Branches

Branches allow you to work on multiple tasks at the same time. In Git you are always working on a branch. In a typical workflow, some branches are treated as "integration" branches to collect the work done in other branches. In contrast, day-to-day work is done in "feature" branches.

## Commits

When you make a commit, Git creates a copy of the files in the index and stores them in the object database. It also creates a commit object that records metadata regarding the commit, including a pointer to the files that were just stored, the author name and email, time the commit was made, and the commit message. 

Each commit is identified by a unique string referred to as the commit ID. 

Except for the initial commit, each commit stored contains the ID of the commit that appeared before it, creating a string of commits referred to as the commit history. 

## HEAD

HEAD is essentially a pointer that keeps track of which commit is currently checked out. Usually, HEAD points to the currently checked out branches latest commit. However, in detached HEAD state, the HEAD does not point to any branch but rather a specific commit.

You can see what HEAD points to with:

```cat .git/HEAD```

### HEAD references

HEAD\~1 (also written as HEAD\~) references the direct parent, HEAD\~2 references the grandparent and so on. In instances of multiple direct parents, HEAD^1 references the first parent and HEAD^2 references the second. This notation can be combined: HEAD^1\~2 references the grandparents of the first parent of HEAD (the current commit).
### detached HEAD state

This occurs when you check out a specific commit. A commit made in this state will be lost unless you create a new branch, as it is not associated with a specific branch. Command ```git switch -c /<new-branch-name>```.

You can continue to make edits and commits, but switching away from that commit history means you will abandon your commits (since they are not referenced by a branch).
## Hunk

Hunks are bite-sized sections of text or code displayed when viewing **diff** output. Each hunk has lines prefixed with a minus or a plus (indicating the changes came from file "a" or "b").

## Git LFS

Git LFS (Large File Storage) is a git extension that reduces the impact of large files in your repository by downloading the relevant versions of them *lazily*. That is, large files are downloaded during the checkout process rather than during cloning or fetching. 

Git LFS does this by replacing large files in your repository with pointers. 

This is because large files stored alongside every commit in a commit history would quickly eat up huge amounts of storage. 

## Local Tracking Branches 

Local tracking branches are a local representation of the state of the remote branches, based on the last time remote was contacted. They are like the local repository's mental image of the state of the remote branches. ```git fetch``` updates your tracking branches. 

## Pull (Github)

Essentially a merge conducted on GitHub. Distinct from the git command **pull**. Requires oversight and approval from the team to finalise the merge. 


---



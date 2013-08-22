---
layout: post
title: "A simple git workflow"
---
This is the git workflow I developed for a team I lead that had not used git before, but had been using subversion at the time. In fact originally this was using git-svn and working with a subversion repo. The idea was not to try anything fancy, but rather to get the maximum benefit from the minimum effort in using version control. This assumes you've already got set up with a git repo.

## Working
Branches are tiny and fast and they work, so every new feature or bug fix could go in it's own branch. I tend to just have one working branch where I do everything, and then switch branches if I need to do something that would conflict.

Biggest thing to remember, is **don't work in master!**

### Setup

But you're in master now, so how do you make a new branch based on master? First let's see what branches there are:

`git branch -a`

To switch to a branch:

`git checkout <branch-name>`

To create a new branch based on the current branch, and then switch to it:

`git checkout -b <new-branch-name>`

So now you are in a new branch, and ready to work.

### Daily workflow

I tend to use a graphical app for commits, because I think a visual tool is much better suited to staging sections of files together into a logical commit. On the Mac I often use [GitX](http://rowanj.github.com/gitx), but there are plenty to choose from.

**But don't commit everything**, just select the files and lines that go together to make a logical change. No generated files, no temporary or local project settings, and remember to include new files. If you have files that you think should not be in the repo, but will keep appearing, you can make git ignore them, but first try looking in [https://github.com/github/gitignore](https://github.com/github/gitignore) to see if this is already well known.

Now you have a working branch full of changes. How do we get that back to the team? First, let's pull down everyone else's changes into the master branch:

`git checkout master`

`git pull`

Great, now we have everyone's work, so let's add all those commits underneath our work:

`git rebase master <new-branch-name>`

If you get conflicts here, then we sort that out together, and in this workflow, this is the only place you can get conflicts. We'll handle these as they come up, but they usually are quick to fix, and only happen when multiple people change the same parts of a single file at the same time. Also, the first to commit to the server doesn't have to deal with the conflict, so this is good incentive to keep updated with the server.

If the rebase went ok, or once we've dealt with issues, let's merge your changes onto the master branch:

`git checkout master`

`git merge <new-branch-name>`

Now your changes are ready to send to the server:

`git push`

Now let's go back to our working branch so we don't accidentally start working in master:

`git rebase master <new-brach-name>`

And we're done. Just FYI, the only time you need access to the server, is when doing the `git pull` and `git push` commands, everything else is completely local to your machine. So now you can work without access to the server, and also check your commits before saving, as well as easily change the last commit when you make a mistake.

### Handle a conflict

If you get a conflict, which should only happen when you are rebasing your local branch on top of the updated master branch, here's how to handle that. Git will tell you what file has a conflict, so you need to open that file (perhaps copy the path from the git warning, and `edit <path>`), and search for `===` to find the problem areas. This editing has to be done by hand, probably with the assistance of whoever changed the same part of the file as you. Once that's done, save. Then go back to the Terminal, and `git add <path>`. Then you can carry on with `git rebase --continue` as the instructions say.

## Helpful scripts
I also created two simple scripts that handle the main push and pull workflow of getting changes from upstream and sending changes to the rest of the team, available as [git-refresh](https://github.com/mbaltaks/vomitorium/blob/master/git-refresh) and [git-publish](https://github.com/mbaltaks/vomitorium/blob/master/git-publish).

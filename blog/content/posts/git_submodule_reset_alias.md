---
title: "Git Submodule Reset Alias"
description: "Easy Reset for git submodule"
draft: false
date: 2023-06-27T19:39:03-04:00
tags: ["software engineering", "git"]
---

If you have ever worked with git submodules, you know that they have the tendency to get into bad states. Especially if changing branches with differing submodule pointers and or changing the name of the submodule between branches. I would like to introduce a [git alias](https://git-scm.com/book/en/v2/Git-Basics-Git-Aliases) that I used as a get out of jail free card when submodules inevitably get in a bad state.

```
git config --global alias.smr "!git submodule deinit -f . && git submodule update –init --recursive"
``` 
This can be run by `git gmr` and stands for submodule reset but you can rename it to suit your needs. Hope this helps 🙂.

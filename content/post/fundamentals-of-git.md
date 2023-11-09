+++
title = "Fundamentals of Git"
lastmod = 2023-11-08T17:51:20-07:00
draft = false
author = "Jeffery@slc"
tags = ["git", "github"]
categories = ["Tech/技术"]
+++

Explore some essential aspects of the version control tool Git.

## Concept {#concept}

Initially, as a newcomer, I confused Git with GitHub (a platform), not realizing Git is fundamentally a local tool. Some refer to it as a version control tool, a file system, or even a database with key-value pairs.

To harness its capabilities, it's crucial to understand the primary command:

```text
git init
```

This command creates a .git folder in your working directory, housing all information of your local repository. If deleted, your directory loses its Git repository status.

Diving into the .git folder, let's explore its contents, focusing mainly on the objects folder that stores commit objects, tree objects (directories), and blob objects (file contents).

```text

// all the files and sub folders under .git directory
-rw-r--r--@  1 tacodaddy  staff   35 Nov  8 10:58 COMMIT_EDITMSG
-rw-r--r--@  1 tacodaddy  staff   21 Nov  8 11:19 HEAD
-rw-r--r--   1 tacodaddy  staff   41 Feb 22  2023 ORIG_HEAD
-rw-r--r--   1 tacodaddy  staff  307 Feb 22  2023 config
-rw-r--r--   1 tacodaddy  staff   73 Feb 22  2023 description
drwxr-xr-x  15 tacodaddy  staff  480 Feb 22  2023 hooks
-rw-r--r--@  1 tacodaddy  staff  449 Nov  8 11:19 index
drwxr-xr-x   3 tacodaddy  staff   96 Feb 22  2023 info
drwxr-xr-x   4 tacodaddy  staff  128 Feb 22  2023 logs
drwxr-xr-x  31 tacodaddy  staff  992 Nov  8 10:58 objects
-rw-r--r--   1 tacodaddy  staff  112 Feb 22  2023 packed-refs
drwxr-xr-x   5 tacodaddy  staff  160 Feb 22  2023 refs

// part of the sub folders under .git/objects/
drwxr-xr-x@ 3 tacodaddy  staff   96 Nov  8 10:58 02
drwxr-xr-x  3 tacodaddy  staff   96 Feb 22  2023 06
drwxr-xr-x@ 3 tacodaddy  staff   96 Nov  8 10:58 07
drwxr-xr-x  3 tacodaddy  staff   96 Feb 22  2023 09
drwxr-xr-x  3 tacodaddy  staff   96 Feb 22  2023 19
```

Folders in objects are named using the first two characters of the 40-character SHA-1 hash of a Git object.
All Git objects, including blobs, trees, and commits, are uniquely identified by a 40-character hexadecimal string.

For instance, under folder 02, there's a file:

```text
// file under folder 02. filename is 38 character string with no extension
56b3b6f9d60a265d66a32bd3f238cd9f21d517

// combine 02 with the value above -> get new value with the length of 40 
0256b3b6f9d60a265d66a32bd3f238cd9f21d517

// and then decompress the file
❯ git cat-file -p 0256b3b6f9d60a265d66a32bd3f238cd9f21d517
tree 07fa58c37c411f8d9ffe9838af2b03735c845b31
parent 73ea321851ff2390c520a0cb8b2552efcae7852f
author Jeffery18-hub <ljzmcs@gmail.com> 1699466287 -0700
committer Jeffery18-hub <ljzmcs@gmail.com> 1699466287 -0700

modify test.text file, add Jeffery
```

This file is a commit object representing a snapshot of your project. 'Tree' refers to the project structure, which can be viewed by decompressing:
```text
❯ git cat-file -p 07fa58c37
100644 blob 259148fa18f9fb7ef58563f4ff15fc7b172339fb	.gitignore
100644 blob 066204b8085bbb3cc45baca943dcc6f31d9b3f91	README.md
100644 blob 09436c0302a7aca747cbe85936b74ed8aa760f60	helloFromMain.cpp
100644 blob 681c281095180933698877e8b3ee11bf42be546d	output.txt
100644 blob f4d7ea5e7bba9c9d92711770e0064ade060f9949	test.txt
```

The 'parent' tag indicates the preceding commit.
A common query: How can I determine if a document is a blob, tree, or commit?

```text
git cat-file -t <sha1>
```

So \`git cat-file\` is a really useful command if you want to dig the rabbit hole of your project version history. Flag \`-p\` means pretty print and \`-t\` shows object type.


## Fours Areas {#fours-areas}

Understanding the four key areas - working directory, staging area, local repository, and remote repository- is crucial.

\`git add\` moves changes to the staging area. \`git commit\` then commits these changes from staging to the local repository (located in the .git folder).

Committing creates a snapshot of your project, encompassing file contents, directory trees, and metadata like time and committer. It yields a commit object linking to your latest commit.

Each commit acts like a node pointing to its predecessor.


## Branches and Head {#branches-and-head}

Different branches in Git means different pointers to versions. The image below shows a project with two branches(main and sub).
![branches.png](/images/gitBasics/branches.png)

Creating a new branch is akin to creating a new pointer. When committing across multiple branches, how does Git know which branch to commit to? Here, the HEAD pointer comes into play.

HEAD typically points to the latest commit on the current branch but can be redirected to earlier commits if needed.
![head.png](/images/gitBasics/head.png)


## Conclusion {#conclusion}

While many tutorials offer Git commands, truly understanding Git requires diving beneath the surface.
A deeper comprehension of its inner workings can be invaluable in navigating complex scenarios.

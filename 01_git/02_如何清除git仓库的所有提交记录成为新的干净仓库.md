# 如何清除git仓库的所有提交记录，成为一个新的干净仓库

[TOC]

## 一、引言

　　小明算Github的忠实用户，经常会把一些练手的项目传到Github上面进行备份。其中有一个名为[ColaFramework](https://github.com/XINCGer/ColaFrameWork)的Unity框架项目，开发了一年多，期间提交代码的时候在Log中上传了一些比较敏感的信息，这些信息都可以在Github上面搜索到，想把这些Log信息清除掉，使其变成一个没有提交记录的“新仓库”。于是我在网上一搜，步骤还挺简单的，直接按照下面一步步操作就可以了。

## 二、操作步骤

　　1.切换到新的分支

```
git checkout --orphan latest_branch
```

　　2.缓存所有文件（除了.gitignore中声明排除的）

```
 git add -A
```

　　3.提交跟踪过的文件（Commit the changes）

```
 git commit -am "commit message"
```

　　4.删除master分支（Delete the branch）

```
git branch -D master
```

　　5.重命名当前分支为master（Rename the current branch to master）

```
 git branch -m master
```

　　6.提交到远程master分支 （Finally, force update your repository）

```
 git push -f origin master
```

　　通过以上几步就可以简单地把一个Git仓库的历史提交记录清除掉了，不过最好还是在平时的开发中严格要求一下提交日志的规范，尽量避免在里面输入一些敏感信息进来。

# END
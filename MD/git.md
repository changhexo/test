##### 初始化：

	$ git init
##### 查看仓库历史记录：

	$ git log
	$ git show 显示每个提交的详细信息和文本diff
##### 查看缩短的项目历史：

	$ git log --oneline	显示ID、分支、标签、描述信息

##### 列出本地分支:

	$ git branch --list
##### 列出所有分支：

	$ git branch --all

	* master	当前分支
	remotes/origin/master	不在本地/默认约定(克隆分支)/分支名
	remotes/origin/sandbox
	remotes/origin/video-lessons
##### 列出远程分支：

	$ git branch --remotes

	origin/master	默认约定/分支名
	origin/sandbox
	origin/video-lessons
##### 更新远程分支：

	$ git fetch
	远程分支列表不会自动更新
##### 切换分支：

	$ git checkout --track origin/video-lessons

	Branch video-lessons set up to track remote branch video-lessons from origin.
	Switched to a new branch 'video-lessons'
	旧版本切换分支：	(远程分支在本地创建,但会显示两个分支)
	$ git checkout --track -b video-lessons origin/video-lessons
	
	$ git branch -a

	  master
	* video-lessons
	  remotes/origin/master
	  remotes/origin/sandbox
	  remotes/origin/video-lessons

##### 新建分支：

	首先需要签出想要创建分支的分支：
	$ git checkout master
	然后再执行创建分支命令：
	$ git branch 1-process_notes
	签出新分支：
	$ git checkout 1-process_notes
	
	或者：	（可以从任意位置创建分支）
	$ git checkout -b 1-process_notes master

##### 添加更改到暂存区：

	$ git add <文件名>
	$ git add <目录名>/*
	$ git add <*.文件后缀>
	$ git add --update
	
	$ git status	查看有哪些更改
	$ git add --all	添加所有更改

	$ git add --path <文件名>    交互添加更改到暂存区

	y 添加修改到暂存区
	n 不改变这个片断(hunk)
	修改过的行将会以 - (删除)、 + (新增的行)开头


##### 提交更改到仓库：

	$ git commit	提交全部更改到仓库

##### 设置全局邮箱和用户名：

	$ git config --global user.email "root@test.com"
	$ git config --global user.name "root"

##### 从暂存区中移除文件：

	$ git reset --patch	交互修改暂存区的文件
	
 	Unstage this hunk [y,n,q,a,d,e,?]? 
	y - unstage this hunk
	n - do not unstage this hunk
	q - quit; do not unstage this hunk or any of the remaining ones
	a - unstage this hunk and all later hunks in the file
	d - do not unstage this hunk or any of the later hunks in the file
	e - manually edit the current hunk
	? - print help

##### 编写扩展提交消息：

	$ git add --all
	$ git commit -m "描述信息"

	$ git commit --amend
	进入vim编辑器，编辑描述信息

##### 文件忽略：	(必要性：忽略开发工具所产生的临时文件)

	首先定义"忽略"文件的列表存放在什么位置(全局)：
	$ git config --global core.excludesfile ~/.gitignore
	更新文件内容，每行一个文件名
	可以用确切文件名，通配符(*.bak)
	使用文档：https://www.gitignore.io

##### 为特定仓库创建"忽略"文件列表：

	为仓库添加额外文件.gitignore
	使用add和commit将.gitignore文件添加到你的仓库

##### 使用标签：

	$ git log --oneline
	
	fa04c30 Initial import

	$ git log fa04c30 --max-depth=1    显示单个提交的详细日志

	$ ggit show fa04c30	显示单个提交的详细日志和文本diff

##### 为某个提交对象添加新的标签：

	$ git tag import fa04c30
	$ git tag <标签名> <ID>
	列出所有标签：
	$ git tag
	$ git show import （使用标签代替了ID）

##### 连接远程仓库：

	github、gitlab
	创建新项目，步骤和本地一样
	
	在本地仓库中添加远程连接：
	$ git remote add my_gitlab git@gitlab.com:emmajane/my-git-for-teames.git
	
##### 列出连接至当前仓库的远程仓库：

	$ git remote --verbose

##### SSH密钥：	(免去输密码的麻烦)

	生成密钥对：
	$ ssh-key -t rsa -b 4096 -C "your_email@example.com"
	启动SSH代理应用并重定向使用Bourne:
	$ eval "$(ssh-agent -s)"
	使用代理注册SSH密钥：
	$ ssh-add ~/.ssh/id_rsa

	windows上操作需要用PuTTYgen软件，生成（SSH-2 RSA）密钥，分别保存私钥(private key)和公钥(public key)

	最后将公钥复制粘贴到代码托管系统的设置页面中。

##### 上传分支：

	$ git push	直接执行会报错，但会提示怎么操作
	
	在上传本地分支时设置上游分支：
	$ git push --set-upstream my_gitlab 1-process_notes

##### 分支维护：

	将工单分支并入主分支：
	$ git checkout master
	$ git merge 1-process_notes
	然后将主分支推送至远程仓库：
	$ git push --set-upstream my_gitlab master

	删除已经并入主分支的工单分支：
	$ git branch --delete 1-process_notes
	最后删除那些修改已经并入主分支的远程分支：
	$ git push --delete my_gitlab 1_process_notes

##### 基本git命令汇总：

	git clone URL	下载一分远程仓库的副本
	git init	将当前目录转换成一个新的git仓库
	git status	获取仓库状态报告
	git add --all	将所有修改过的文件和新文件添加至仓库的暂存区
	git commit -m "message"	将所有暂存的文件提交至仓库
	git log		 查看项目历史
	git log --oneline	查看压缩过的项目历史
	git branch --list	列出所有本地分支
	git branch --all	列出本地和远程分支
	git branch --remotes	列出所有远程分支
	git checkout --track remote_name/branch	创建远程的分支副本，在本地使用
	git checkout branch	切换到另一个本地分支
	git checkout -b branch branch_parent	从指定分支创建一个新的分支
	git add filename(s)	仅暂存并准备提交指定文件
	git add --patch filename	仅暂存并准备提交部分文件
	git reset HEAD filename	从暂存区移除提出的文件修改
	git commit --amend	使用当前暂存的修改更新之前的提交，并提供一个新提交消息
	git tag		列出所有标签
	git show tag 	输出所有带标签提交的详细信息
	git remote add remote_name URL	创建一个指向远程仓库的引用
	git push	将当前分支上的修改上传至远程仓库
	git remote --verbose 列出所有可用远程连接中fetch和push使用的URL
	git push --set-upstream remote_name branch_local_branch_remote	将本地分支副本推送至远程服务器
	git merge branch	将当前存储在另一分支的提交并入当前分支
	git push --delete remote_name branch_remote	在远程服务器中移除指定名称的分支

================================================================================================

##### 回滚、还原、重置和变基：

	舍弃工作目录中对一个文件的修改：
	git checkout --filename	修改的文件未被暂存或提交

	舍弃工作目录中所有未保存的修改：
	git reset --hard	文件已暂存，但未被提交
	
	合并与某个特定提交(但不含)之间的多个提交
	git reset commit	

	移除所有未保存的变更，包含未跟踪的文件：
	git clean -fd	修改的文件未被提交

	移除所有已暂存的变更和某个提交之前提交的工作，但不移除工作目录中的新文件：
	git reset --hard commit

	移除之前的工作，但完整保留提交历史记录("前进式回滚")：
	git revert commit	分支工作已经被分支，工作目录是干净的

	从分支历史记录中移除一个单独的提交：
	git rebase --interactive commit	修改的文件已以被提交，工作目录是干净的，分支尚未进行发布

	保留之前的工作，但与另一提交合并：
	git rebase --interactive commit	选择squash(压缩)选项

##### 使用分支进行试验性工作：

	$ git checkout -b experimental_idea
	$ git add --all
	$ git commit

	将试验性分支合并回主分支
	$ git checkout master
	$ git merge experimental_idea --squash

	Squash commit -- not updating HEAD
	Automatic merge went well; stopped before committing as requested
		当你合并两个分支时，可以选择使用带有 --squash 参数的合并，以将所有提交并入一个提交。通过这种方式合并分支，以后你将不能撤销分支合并。基于这个考虑，只有在合并你本来就不希望分离的分支时，才使用 --squash。

	$ git commit

	合并之后可以删除试验分支：
	$ git branch --delete experimental_idea

	如果你希望舍弃试验性的想法，完成最开始的步骤，省略把工作并入主工单分支这一步。要删除一个未合并的分支，你需要使用 -D 参数而不是 --delete 参数

##### 分步变基：

	rebase	是唯一作用不局限于撤销工作的命令
	reset
	revert

	确保分支的本地副本与项目主仓库中最新的提交同步：
	$ git checkout master
	$ git pull --rebase=preserve remote_nickname master

	在使用 pull 命令更新一个分支的本地副本时，参数中远程连接和远程分支的名称通常是可以忽略的。有些时候，如果一个仓库拥有多个远程连接，Git有时会遗漏可用的更新。加上这两个额外的参数或许会有帮助。

	当前分支上的修改与主项目不同步，而主项目中的新工作尚未被引入：
	$ git checkout feature
	变基：
	$ git rebase master

	如果没有冲突，Git将会愉快地跳过这个过程并将你带到另一个终点，不需要你再进行任何附加操作,
	但有时会造成冲突：
		文件删除造成的变基冲突
			1.解决合并冲突：
				文件对比工具
			$ git mergetool ch10.asciidoc
			2.当认为合并冲突已被解决时：
			$ git rebase --continue
			3.查询git状态消息,确认操作是否是想要的：
			$ git status
			4.不希望删除文件，可以根据git提示，阻止这个变更发生：
			$ git reset HEAD ch10.asciidoc
			5.反复通过 git status 查询g git 状态确定正确的操作
		单个文件合并冲突造成变基冲突
			1.查询 git 状态
			$ git status
			2.确定冲突位置
			$ git mergetool book.asciidoc
			3.查询 git 状态
			$ git status
			4.按 git 提示操作
			$ git add book.asciidoc
			5.查询 git 状态
			6. git rebase --contine

		如果你对眼前发生的事情感到十分恐慌，那么总是可以使用
		$ git rebase --abort 
		命令退出这个流程。你将回到开始变基前你的分支所处的状态

##### 定位丢失的工作概述：

	$ git log
	$ git reflog

	合并试验性分支流程：
	$ git checkout working_branch 
	$ git merge restoring_old_commit
	$ git branch --delete restoring_old_commit
	$ git push --delete restoring_old_commit

	使用 cherry-pick 将提交复制到新的分支：
	$ git help cherry-pick
	$ git cherry-pick -x commit
	$ git log --oneline --graph
	$ git cherry-pick -x conmit --mainline 1
	$ git reset --merge ORIG_HEAD

	公共的历史记录不应该被修改:
		reset 命令不应该被用于共享的分支来移除已经被发布的提交。

##### 还原文件：

	$ rm README.md
	$ git status 
	$ git checkiut --README.md

	$ rm README.md
	$ git add README.md
	$ git stastus 
	$ git reset HEAD READMD.md
	$ git checkout -- README.md
	以上两个命令可以合并：
	$ git checkout --hard HEAD -- README.md
	撤销工作目录的所有变更(将所有文件恢复到上一个提交的版本)：
	$ git reset --hard HEAD

##### 使用提交：

	修补提交
	$ git add --all
	$ git commit --amend

	$ git help commit

	使用 reset 合并提交
		对 reset 作用最基本的解释是，它其实只是修改了头指针的指向
		--hard
		revert
		记住：reset 的对象是要保留的东西，而 revert 的对象是要舍弃的东西。

		$ git diff --staged
		--staged 参数是 --cached 参数的别名

		例如，如果你希望将你的分支中的三个提交压缩成一个:
		$ git reset HEAD~3

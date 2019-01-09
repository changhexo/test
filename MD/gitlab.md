# gitlab 搭建

	yum install -y curl policycoreutils-python openssh-server
	curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | bash
	yum install -y gitlab-ee
	# 启动gitlab
	gitlab-ctl reconfigure

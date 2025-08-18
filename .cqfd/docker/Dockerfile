FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Yocto mandatory packages
RUN apt-get update && apt-get install -y --no-install-recommends \
	bash \
	bc \
	bison \
	build-essential \
	ca-certificates \
	chrpath \
	cpio \
	curl \
	debianutils \
	diffstat \
	file \
	flex \
	gawk \
	gcc-multilib \
	g++-multilib \
	gir1.2-gtk-3.0 \
	git \
	git-core \
	iputils-ping \
	liblz4-tool \
	libncurses5-dev \
	libsdl1.2-dev \
	libssl-dev \
	locales \
	poppler-utils \
	python-is-python3 \
	python3 \
	python3-gi \
	python3-pexpect \
	python3-pip \
	rsync \
	socat \
	ssh \
	subversion \
	swig \
	texinfo \
	tmux \
	unzip \
	wget \
	xterm \
	xxd \
	xz-utils \
	zip \
	zstd \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i "s/# en_US\.UTF-8 UTF-8/en_US\.UTF-8 UTF-8/" /etc/locale.gen \
	&& locale-gen \
	&& dpkg-reconfigure locales

# Disable NFS4 ACL
# See https://github.com/yoctoproject/poky/commit/d3a98ba77184a9863a037e5145772d51953ef796
RUN sed -Ei '/^system\.nfs4_?acl/d' /etc/xattr.conf

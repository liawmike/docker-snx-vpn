FROM phusion/baseimage

ADD scrics/snx_install.sh /root

RUN dpkg --add-architecture i386 && apt update && apt install -y apt-utils bzip2 openjdk-8-jdk kmod libstdc++5:i386 libpam0g:i386 libx11-6:i386 expect iptables net-tools iputils-ping libaudit1:i386 libc6:i386 libcap-ng0:i386 libgcc-5-dev:i386 libpam0g:i386 libstdc++5:i386 libx11-6:i386 libxau6:i386 libxcb1:i386

RUN cd /root && bash -x snx_install.sh

ADD scrics/snx.sh /root
RUN chmod +x /root/snx.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init && /root/snx.sh"]

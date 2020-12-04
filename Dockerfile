FROM ubuntu:16.04


# 更新源，安装ssh server
COPY sources.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
COPY sshd_config /etc/ssh/sshd_config
RUN /etc/init.d/ssh restart

COPY run.sh /run.sh
RUN chmod 777 /run.sh

# 设置root ssh远程登录密码为123456
RUN echo "root:123456" | chpasswd

# 容器需要开放SSH 22端口
EXPOSE 22

CMD ["/run.sh"]

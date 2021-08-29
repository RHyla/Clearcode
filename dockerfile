FROM centos:centos7.9.2009

RUN yum update -y
RUN yum -y install openssh-server
RUN yum -y install git
RUN yum -y install python3
RUN yum -y install python3-pip
RUN yum -y install epel-release
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade pip
RUN pip3 install Flask


RUN mkdir /var/run/sshd
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config
RUN sed -i "s/Port 22/Port 5001/" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config

RUN adduser --system git
RUN mkdir -p /home/git/.ssh
RUN mkdir -p /home/git/repo1

RUN echo " " > /home/git/.ssh/authorized_keys
RUN ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa


RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd
RUN echo "git:test123" | chpasswd
RUN cd /home/git/repo1 && git init --bare /home/git/repo1
RUN cd /home/git/repo1 && git clone https://github.com/eresgie-cc/devops-internship-challenge-2021.git
RUN cd /home/git/repo1 && chmod -R 777 /home/git/repo1/objects
RUN cd /home/git/repo1 && chmod -R 777 /home/git/repo1/refs
EXPOSE 5001
ENTRYPOINT ["python3","/home/git/repo1/devops-internship-challenge-2021/app/flask-app.py"]

FROM ubuntu:trusty
MAINTAINER Quint Stoffers <quint@appeine.com>

RUN apt-get update && apt-get -y install \
    default-jre-headless \
    build-essential \
    git \
    curl \
    openssh-server \
    npm

# Install Meteor
RUN curl https://install.meteor.com/ | sh

# Add user jenkins
RUN adduser --quiet jenkins

# Configure SSH
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd
EXPOSE 22

CMD ["echo "jenkins:jenkins" | chpasswd && /usr/sbin/sshd", "-D"]

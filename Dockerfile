FROM fedora:latest
MAINTAINER Jay Baker jay.baker@bnl-consulting.com

ADD https://releases.hashicorp.com/packer/1.0.3/packer_1.0.3_linux_amd64.zip /opt/
ADD https://releases.hashicorp.com/terraform/0.10.0/terraform_0.10.0_linux_amd64.zip /opt/

RUN dnf install -y vim git unzip ansible wget \
	&& unzip /opt/packer_1.0.3_linux_amd64.zip -d /root/bin \
	&& unzip /opt/terraform_0.10.0_linux_amd64.zip -d /root/bin \
	&& rm -f /opt/*.zip \
	&& chmod u+x /root/bin/packer \
	&& chmod u+x /root/bin/terraform \
	&& mkdir /root/chadev-immutable-demo

WORKDIR /root/chadev-immutable-demo

ENTRYPOINT ["/bin/bash"]

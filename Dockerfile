# image used to compile your Swift code
FROM swift:5.7-amazonlinux2

RUN yum -y install git jq tar zip openssl-devel

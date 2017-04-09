FROM amazonlinux

EXPOSE 3000

RUN yum -y update && yum clean all
RUN yum -y install vim wget which git


#go runtime install
RUN wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz -P /usr/local/src
RUN tar -C /usr/local -xzvf /usr/local/src/go1.8.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

# go application setup
RUN mkdir  -p /root/go
RUN mkdir  /root/go/bin
RUN mkdir  /root/go/pkg
RUN mkdir  /root/go/src

ENV GOPATH /root/go
ENV PATH $PATH:$GOPATH/bin
RUN curl https://glide.sh/get | sh

ARG githubtoken
RUN git clone https://${githubtoken}:x-auth-basic@github.com/waysaku/learning-go  /root/go/src/github.com/waysaku/learning-go
ENTRYPOINT go run /root/go/src/github.com/waysaku/learning-go/main.go

FROM maven:3.5.4-jdk-8

USER root

ENV DEBIAN_FRONTEND noninteractive

#configure jenkins slave
ARG JENKINS_REMOTING_VERSION=3.27
RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$JENKINS_REMOTING_VERSION/remoting-$JENKINS_REMOTING_VERSION.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

#update apt-get
RUN apt-get update --yes

#install pre-requisits
RUN apt-get install software-properties-common --yes
RUN apt-get install apt-transport-https

#install docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
RUN apt-get update

#install kubectl
RUN apt-get update && apt-get install -y apt-transport-https
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" |  tee -a /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update
RUN apt-get install docker-ce --yes

#install kubectl
RUN apt-get install -y kubectl

#install helm 
RUN curl -s https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > install-helm.sh
RUN chmod u+x install-helm.sh
RUN ./install-helm.sh


COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD [ "sh" ]
FROM jenkins/jenkins:lts

#FROM jenkins:1.609.3
USER root

RUN echo "deb http://apt.dockerproject.org/repo debian-jessie main" \
    > /etc/apt/sources.list.d/docker.list \
   # && apt-key adv --keyserver hkp://p80.pool.sks-keyserver.net:80 \
   # --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \ 
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get install -y sudo \
  #  && apt-get install -y docker-engine \
  #  && docker-ce docker-ce-cli containerd.io \
    && curl -fsSL https://get.docker.com -o get-docker.sh \
    && sudo sh get-docker.sh \
#    && apt-get install -y jenkins-plugin-cli \
    && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/\
docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; \ 
    chmod +x /usr/local/bin/docker-compose
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt

#RUN install-plugins.sh /usr/share/jenkins/plugins.txt
RUN sudo java -jar jenkins-cli.jar -s http://localhost:8080/ install-plugin /usr/share/jenkins/plugins.txt                      
#RUN /usr/local/bin/install-plugin.sh /usr/share/jenkins/plugins.txt

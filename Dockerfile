FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common
    
RUN apt-get install -y -qq --no-install-recommends wget
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

RUN apt-get install -y openjdk-17-jdk
RUN apt-get install -y openjdk-17-jre

RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.tar.gz
RUN tar -xvf apache-maven-3.9.2-bin.tar.gz
RUN mv apache-maven-3.9.2 /opt/
RUN M2_HOME='/opt/apache-maven-3.9.2' 
RUN PATH="$M2_HOME/bin:$PATH"

WORKDIR /azp

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]
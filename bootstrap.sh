#!/bin/bash

apt update

## Unzip/Zip Installation
apt install -y zip unzip

## Docker Installation
apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt update
apt install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker $USER

## Cassandra Installation
docker run -d --name cassandra -p 9042:9042 cassandra

## Native Build Tools
apt install -y build-essential libz-dev zlib1g-dev

## GraalVM Installation
apt install -y wget
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.0.0/graalvm-ce-java8-linux-amd64-21.0.0.tar.gz
tar -xzf graalvm-ce-java8-linux-amd64-21.0.0.tar.gz
export PATH=~/graalvm-ce-java8-21.0.0/bin/:$PATH
export JAVA_HOME=~/graalvm-ce-java11-21.0.0/
export GRAALVM_HOME=~/graalvm-ce-java11-21.0.0/
${GRAALVM_HOME}/bin/gu install native-image

## Maven Installation
apt install -y maven
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=${M2_HOME}/bin:${PATH}

## cassandra-quarkus master Installation
wget https://github.com/datastax/cassandra-quarkus/archive/master.zip
unzip master.zip
rm master.zip
chown -R vagrant cassandra-quarkus-master
cd cassandra-quarkus-master
mvn install -Dmaven.test.skip=true

## Cassandra Setup
docker exec -it cassandra cqlsh -e "CREATE KEYSPACE IF NOT EXISTS k1 WITH replication = {'class':'SimpleStrategy', 'replication_factor':1}"
docker exec -it cassandra cqlsh -e "CREATE TABLE IF NOT EXISTS k1.fruit(name text PRIMARY KEY, description text)"

## Install Confirmation
echo "==============="
java -version
mvn -v
docker exec -it cassandra nodetool status

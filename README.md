# quarkus-cassandra-quick-start

This project goes through and tests the quick-start guide provided for the Cassandra Quarkus integration:

https://github.com/datastax/cassandra-quarkus/blob/master/documentation/src/main/asciidoc/cassandra.adoc

## Vagrant Configuration

The Vagrant configuration provided can be used to run a development VM fully provisioned for developing within the project.

For information on installing Vagrant, see the docs:  https://www.vagrantup.com/intro

The provided configuration requires VirtualBox:  https://www.virtualbox.org/

To get started, from the root project directory run:

```
vagrant up
```

Then, to access the VM:

```
vagrant ssh
```

You will now be within the shell of the VM.

The Vagrant bootstrap has taken care of the following:

* Installing GraalVM (11)
* Installing Maven
* Installing Docker
* Starting and configuring a Cassandra DB container
* Exposing ports for local access from the host system:
  * 8080 (Quarkus HTTP Port)
  * 9042 (Cassandra Port)
  * 5005 (JVM Remote Debug Port)
    
The project source can be accessed from within the VM at `/vagrant/`.
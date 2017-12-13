# Debian 9 (Stretch) Java 8 Tomcat 8.5 Docker Image

## Description

This image provides a [Debian](https://www.debian.org/) 9 image plus java 8. By default, tomcat 8 will run, but .jar files placed under /var/www will take priority. This is created specifically to be run under [OpenShift Origin](https://www.openshift.org/) and [Kubernetes](https://kubernetes.io/), as well as any other standard Docker environment.

**Ensure you specify a user id (UID) other than zero. Running as root is not a supported configuration.**

## Current Status: Work In Progress

This image is currently an experimental work in progress.

## Tomcat 8 Package

In order to get the latest version of Tomcat 8 it has been downloaded from an official mirror, and the package faked using equivs, i.e:

* apt-get install equivs
* equivs-control tomcat8
* _edit the file that gets created_
* equivs-build tomcat8

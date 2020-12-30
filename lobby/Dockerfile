FROM debian:buster-slim

ARG DISTRIBUTION_VERSION=""

ADD lobby-server-linux-x64.${DISTRIBUTION_VERSION}.tar.gz /usr/local

ENV JAVA_HOME /usr/local/jbr

ENTRYPOINT ["/usr/local/bin/lobby-server"]

FROM alpine:latest

ARG DISTRIBUTION_VERSION=""

COPY ws-relayd$DISTRIBUTION_VERSION /usr/local/bin/ws-relayd

RUN chmod +x /usr/local/bin/ws-relayd

ENTRYPOINT ["/usr/local/bin/ws-relayd"]

FROM alpine:3.3

#SSH home and port. User is expected to expose a volume for SSH as /data/
VOLUME ["/data/"]

RUN apk add --update curl build-base iperf nmap nginx openssh && \
#
#get netperf
  curl -LO ftp://ftp.netperf.org/netperf/netperf-2.7.0.tar.gz && \
  tar -xzf netperf-2.7.0.tar.gz  && \
  cd netperf-2.7.0 && ./configure --prefix=/usr && make && make install && \
  rm -rf netperf-2.7.0 netperf-2.7.0.tar.gz && \
  rm -f /usr/share/info/netperf.info && \
  strip -s /usr/bin/netperf /usr/bin/netserver && \
  apk del curl build-base && rm -rf /var/cache/apk/* && \
#SSH preparation
#  touch /run/openrc/softlevel && \
  adduser -D user -h /data/ && \
#delete cache
  rm -rf /var/cache/apk/*

#FIXME: SSH port should be configurable
EXPOSE ${SSH_PORT:-22}

#prepare content for nginx
RUN mkdir -p /tmp/nginx/client-body
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY website /usr/share/nginx/html

#run nginx web server in 80 #FIXME: $WEB_PORT
RUN ["nginx"]
EXPOSE ${WEB_PORT:-22}

#run iperf tcp server on port $IPERF_TCP_PORT (5001 default)
RUN ["iperf", "-s", "-D", "-p ${IPERF_TCP_PORT:-5001}"]
EXPOSE ${IPERF_TCP_PORT:-5001}

#run netperf tcp server on port $NETPERF_TCP_PORT (6001 default)
RUN ["netserver", "-p 6001"]
#FIXME: "-p ${NETPERF_TCP_PORT:-6001}"
EXPOSE 6001
#FIXME:EXPOSE "${NETPERF_TCP_PORT:-6001}"

#entry point is ssh
ENTRYPOINT  ["/bin/sh"]
CMD  ["/usr/sbin/sshd", "-D"]

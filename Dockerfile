FROM alpine:3.20

RUN apk add --no-cache openvpn dante-server bash iproute2

COPY danted.conf /etc/danted.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 1080
ENTRYPOINT ["/entrypoint.sh"]


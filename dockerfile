FROM registry.access.redhat.com/ubi8/ubi:latest as builder

RUN dnf install dnf-plugins-core --assumeyes \
    && dnf copr enable @caddy/caddy --assumeyes \
    && dnf install caddy --assumeyes

FROM registry.access.redhat.com/ubi8/ubi-micro:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy

# uncommend if you want to trust a custom root certificate
#COPY root.crt /root.crt
#RUN caddy trust /root.crt

USER 1000

EXPOSE 80
EXPOSE 443
EXPOSE 2019

CMD ["caddy"]

FROM varnish:6.6.0-1
COPY  entry-wrap.sh /
COPY default.vcl /etc/varnish/
RUN chown -R 101.101 /etc/varnish/ && chmod +x /entry-wrap.sh

ENTRYPOINT [ "/entry-wrap.sh" ]
#varnishadm -n /var/lib/varnish
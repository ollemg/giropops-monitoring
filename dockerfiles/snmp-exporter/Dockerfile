FROM        quay.io/prometheus/busybox:latest
LABEL       maintainer="Gabriel de Mello Barbosa <gabrielmello808@gmail.com>"


COPY snmp_exporter  /bin/snmp_exporter
ADD conf/snmp.yml   /etc/snmp_exporter/snmp.yml


VOLUME [ "/etc/snmp_exporter/" ]

EXPOSE      9116

ENTRYPOINT  [ "/bin/snmp_exporter" ]
CMD         [ "--config.file=/etc/snmp_exporter/snmp.yml" ]

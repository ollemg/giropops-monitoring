# ollemg-monitoring
Full stack tools for monitoring containers and other stuff. ;)
- Netdata
- Prometheus
- AlertManager
- Docker
- cAdvisor
- Grafana
- Node_Exporter
- SNMP_Explorer

# Howto
First of all, clone the ollemg-monitoring repo:
```
# git clone https://github.com/ollemg/ollemg-monitoring.git
```

## Install Docker and create Swarm cluster
```
# curl -fsSL https://get.docker.com | sh
# docker swarm init
```

## Install Netdata:
```
# bash <(curl -Ss https://my-netdata.io/kickstart.sh)
```

Setting Netdata Exporter configuration in Prometheus:
```
# vim conf/prometheus/prometheus.yml
...
- job_name: 'netdata'
    metrics_path: '/api/v1/allmetrics'
    params:
      format: [prometheus]
    honor_labels: true
    scrape_interval: 5s
    static_configs:
         - targets: ['YOUR_IP:19999']
```
## Deploy Stack with Docker Swarm

Execute deploy to create the stack of ollemg-monitoring:
```
# docker stack deploy -c docker-compose.yml ollemg

Creating network ollemg_backend
Creating network ollemg_frontend
Creating network ollemg_default
Creating service ollemg_prometheus
Creating service ollemg_node-exporter
Creating service ollemg_alertmanager
Creating service ollemg_cadvisor
Creating service ollemg_grafana
```

Verify if services are ok:
```
# docker service ls
ID               NAME                   MODE            REPLICAS      IMAGE                                PORTS
udx1ryljmegd     ollemg_alertmanager    replicated      1/1           ollemg/alertmanager_alpine:latest    *:9093->9093/tcp
z7q1ouzdb2mv     ollemg_cadvisor        global          1/1           google/cadvisor:latest               *:8080->8080/tcp
z5x6rl9w7fw2     ollemg_grafana         replicated      1/1           nopp/grafana_alpine:latest           *:3000->3000/tcp
5k3ixqj6d1q6     ollemg_node-exporter   global          1/1           ollemg/node-exporter_alpine:latest   *:9100->9100/tcp
0145jnqzj9kg     ollemg_prometheus      replicated      1/1           ollemg/prometheus_alpine:latest      *:9090->9090/tcp
mpnjl3bipmti     ollemg_snmp-exporter   replicated      1/1           prom/snmp-exporter:latest            *:9116->9116/tcp

```
## Access Services in Browser

To access Prometheus interface on browser:
```
http://127.0.0.1:9090
```

To access AlertManager interface on browser:
```
http://127.0.0.1:9093
```

To access Grafana interface on browser:
```
http://127.0.0.1:3000
user: ollemg
passwd: ollemg

To add plugs edit file ollemg-monitoring/grafana.config
GF_INSTALL_PLUGINS=plug1,plug2
Current plugs grafana-clock-panel,grafana-piechart-panel,camptocamp-prometheus-alertmanager-datasource,vonage-status-panel
```
Get fun, access the dashboards! ;)

To access Netdata interface on browser:
```
http://127.0.0.1:19999
```

To access Prometheus Node_exporter metrics on browser:
```
http://127.0.0.1:9100/metrics
```

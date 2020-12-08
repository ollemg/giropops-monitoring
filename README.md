# Repositório utilizado para apresentar um trabalho na faculdade

#ollemg-monitoring
- Netdata
- Prometheus
- AlertManager
- Docker
- cAdvisor
- Grafana
- Node_Exporter
- SNMP_Explorer

## 1:
```
# git clone https://github.com/ollemg/ollemg-monitoring.git
```

## 2:
```
# curl -fsSL https://get.docker.com | sh
# docker swarm init
```

## 3:
```
# bash <(curl -Ss https://my-netdata.io/kickstart.sh)
```

## 4:
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
## 5:
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

## Como ficou:
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
## Acessos:

Prometheus:
```
http://127.0.0.1:9090
```

AlertManager:
```
http://127.0.0.1:9093
```

Grafana:
```
http://127.0.0.1:3000
user: ollemg
passwd: ollemg

To add plugs edit file ollemg-monitoring/grafana.config
GF_INSTALL_PLUGINS=plug1,plug2
Current plugs grafana-clock-panel,grafana-piechart-panel,camptocamp-prometheus-alertmanager-datasource,vonage-status-panel
```
Netdata:
```
http://127.0.0.1:19999
```

Node_exporter:
```
http://127.0.0.1:9100/metrics
```

---
title: Install Elasticsearch
contents-list: h1,h2
---

Nothing special, just the steps from Elasticsearch.

```bash
#!/bin/bash

echo "Install Elasticsearch"

echo
echo "Getting public signing key - GPG-KEY-elasticsearch"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

# wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo
echo "Instaling apt-transport-https"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

# sudo apt-get install apt-transport-https

echo
echo "Saving the repository definition to /etc/apt/sources.list.d/elastic-8.x.list"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

# echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

echo
echo "Install elasticsearch"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

# sudo apt-get update && sudo apt-get install elasticsearch

echo
echo "Configuring elasticsearch service to start automatically using systemd"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service

echo
echo "Starting elasticsearch service"
read -p "Press RTN to continnue, CTRL-C to exit " dummy

sudo systemctl start elasticsearch.service
```

<hr>

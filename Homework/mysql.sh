#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

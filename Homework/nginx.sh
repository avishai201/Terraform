#!/bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo docker run --name mynginx -p 80:80 -d nginx

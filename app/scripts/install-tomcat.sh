#! /bin/bash
sudo apt-get update
sudo apt install openjdk-8-jdk -y
sudo apt install tomcat9 tomcat9-admin -y
sudo systemctl start tomcat9
sudo systemctl enable tomcat9
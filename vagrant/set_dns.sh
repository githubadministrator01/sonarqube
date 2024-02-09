#!/bin/bash
# Add local DNS resolution
echo "192.168.99.100 ubuntu-server.local ubuntu-server" >> /etc/hosts
echo "192.168.99.100 sonarqube.test.local.com" >> /etc/hosts
#!/bin/bash
export HOME=/home/jenkins

service postgresql start
service mysql start

while true; do sleep 1d; done


#!/bin/bash
export HOME=/home/jenkins

service mysql start
service postgresql start

su - postgres -c "psql -c \"CREATE USER jenkins WITH PASSWORD 'secret';\""
su - postgres -c "psql -c \"ALTER USER jenkins CREATEDB;\""

while true; do sleep 1d; done


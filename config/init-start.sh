#!/bin/bash
export HOME=/home/jenkins

service mysql start
service postgresql start

if [ ! -f /home/jenkins/.pgpass ]; then
   su - postgres -c "psql -c \"CREATE USER jenkins WITH PASSWORD 'secret';\""
   su - postgres -c "psql -c \"ALTER USER jenkins CREATEDB;\""
   echo "localhost:*:*:jenkins:secret" > /home/jenkins/.pgpass
   chmod 0600 /home/jenkins/.pgpass
fi

while true; do sleep 1d; done


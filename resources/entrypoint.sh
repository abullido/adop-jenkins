#!/bin/bash

echo "Genarate JENKINS SSH KEY and add it to gerrit"
host=$GERRIT_HOST_NAME
port=$GERRIT_PORT
username=$GERRIT_JENKINS_USERNAME
password=$GERRIT_JENKINS_PASSWORD
nohup /usr/share/jenkins/ref/adop\_scripts/generate_key.sh -c ${host} -p ${port} -u ${username} -w ${password} &
echo "start JENKINS"

echo "import pty; pty.spawn('/bin/bash')" > /tmp/asdf.py
python /tmp/asdf.py
su root /usr/local/bin/jenkins.sh

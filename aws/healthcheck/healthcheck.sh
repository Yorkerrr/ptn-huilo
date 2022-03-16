#/bin/bash

SINK_SSH="ssh -oStrictHostKeyChecking=no -i ukr.pem ssh -i ukr ec2-user@ec2-3-141-33-131.us-east-2.compute.amazonaws.com"

VAR=""
HEALTH=""
for HEALTH in `date +"%d-%m-%y-%s"` `curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone` `curl -s -o /dev/null -w "%{http_code}" $1`; do
  VAR+="${HEALTH} "
done

echo "$VAR" | $SINK_SSH "cat >> output.txt"



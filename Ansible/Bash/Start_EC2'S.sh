#!/bin/bash

# Replace 'instance_id1', 'instance_id2', 'instance_id3' with your actual instance IDs
INSTANCE_IDS="Jenkins Ansible"

aws ec2 start-instances --instance-ids $INSTANCE_IDS
echo "EC2 instances started successfully!"

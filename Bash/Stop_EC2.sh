#!/bin/bash

# Replace 'instance_id1', 'instance_id2', 'instance_id3' with your actual instance IDs
INSTANCE_IDS="i-03985fcb9ffdde5d2 i-094c097b1a41e8832"

aws ec2 stop-instances --instance-ids $INSTANCE_IDS
echo "EC2 instances stopped successfully!"
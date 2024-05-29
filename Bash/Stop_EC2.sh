#!/bin/bash

# Replace 'instance_id1', 'instance_id2', 'instance_id3' with your actual instance IDs
INSTANCE_IDS="i-0020d020c1e148c46 i-0d89c461f5057bd32"

aws ec2 stop-instances --instance-ids $INSTANCE_IDS
echo "EC2 instances stopped successfully!"
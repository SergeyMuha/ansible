#! /bin/bash
id=$(aws ec2 run-instances --image-id ami-38708b45 --key-name aws_console_key --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=name,Value=ansiblehost}]' | grep -i InstanceId  | awk -F':' '{print $2}' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g')
sleep 15
pubdns=$(aws ec2 describe-instances --instance-ids $id | grep -m 1 -i publicdns  | awk -F':' '{print $2}' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g')
echo $pubdns
echo "$pubdns ansible_ssh_private_key_file=~/.ssh/aws_console_key.pem" >> /etc/ansible/hosts

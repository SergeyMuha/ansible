#! /bin/bash
if [ -z "$1" ]; then 
	echo " "
	echo usage: boot_aws_vm.sh amis aws-key-name
	echo amis : ami-38708b45 - ubuntu 14.04, ami-a0d009dd - ubuntu 16.04, ami-467ca739 - amazon
        echo You could check your aws-key-name with $ aws ec2 describe-key-pairs
	exit
fi

id=$(aws ec2 run-instances --image-id $1 --key-name $2 --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=OStype,Value=$1}]" | grep -i InstanceId  | awk -F':' '{print $2}' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g')
sleep 10
pubdns=$(aws ec2 describe-instances --instance-ids $id | grep -m 1 -i publicdns  | awk -F':' '{print $2}' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g')
echo $pubdns
#echo "$pubdns ansible_ssh_private_key_file=~/.ssh/aws_console_key.pem" >> /etc/ansible/hosts
python=" "
if [ "$1" = "ami-38708b45" ]
then
	ostype=apt 
elif [ "$1" = "ami-a0d009dd" ]
then
	ostype=apt
	python='ansible_python_interpreter=/usr/bin/python3'
else                
	ostype=yum
fi

cat <<EOF >> /etc/ansible/hosts
[server-$ostype]
$pubdns ansible_ssh_private_key_file=~/.ssh/aws_console_key.pem $python
EOF

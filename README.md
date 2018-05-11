# ansible
-----------------------------------------------
Setup wordpress with wp_setup.yaml in AWS

Requirements:  
  Ansible -- use http://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html  
  AWS-cli with configured AWS Access Key ID and AWS Secret Access Key -- 
                                                                         use https://docs.aws.amazon.com/cli/latest/userguide/awscli-install-linux.html  
                                                                             https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html  

$ git clone https://github.com/SergeyMuha/ansible.git  

$ cd ansible/  

$./boot_aws_vm.sh  
usage: boot_aws_vm.sh amis aws-key-name  
amis : ami-38708b45 - ubuntu 14.04, ami-a0d009dd - ubuntu 16.04, ami-467ca739 - amazon  
You could check your aws-key-name with  
$ aws ec2 describe-key-pairs  

Script will create one aws instance from selected AMI and update /etc/ansible/hosts file with new hosts group and print public-dns-name  

$./boot_aws_vm.sh ami-38708b45 your-aws-key  

For deploy Wordpress on this instance run  
$ ansible-playbook wp_setup.yaml  

Open public-dns-name to check site  


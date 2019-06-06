#!/bin/bash -e

cd terraforming-aws/terraforming-pas

cat <<EOF > terraform.tfvars 
env_name           = "$FOUNDATION"
access_key         = "$AWS_ACCESS_KEY"
secret_key         = "$AWS_SECRET_KEY"
region             = "$AWS_REGION"
availability_zones = [$AWS_AZS]
ops_manager_ami    = "$AWS_AMI"
rds_instance_count = 1
dns_suffix         = "$DOMAIN"
vpc_cidr           = "10.0.0.0/16"
use_route53        = true
use_ssh_routes     = true
use_tcp_routes     = true
ssl_ca_cert	   = "$SSL_CA_CERT"
ssl_ca_private_key = "$SSL_CA_PRIVATE_KEY"
EOF

terraform init
terraform plan -out=../../generated-state/pcf.tfplan
terraform apply ../../generated-state/pcf.tfplan

#!/bin/sh -e

if [ -f "platform-automation-config/foundations/$FOUNDATION/pcf.tfplan" ]; then
	cp platform-automation-config/foundations/$FOUNDATION/pcf.tfplan terraforming-aws/terraforming-pas
fi

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
ssl_cert = <<EOL
$SSL_CA_CERT
EOL
ssl_private_key = <<EOL
$SSL_CA_PRIVATE_KEY
EOL
EOF

terraform init
terraform plan -out=pcf.tfplan
terraform apply pcf.tfplan
cp pcf.tfplan ../../generated-state

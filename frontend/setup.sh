#!/bin/bash

rm -rf .terraform*
read -p "Which environment would you like?" ENV
echo $ENV
sed -i "s/_env_/$ENV/g" backend.tf

echo "Environment is set to $ENV"

terraform init
terraform validate
read -p "Would you like to to apply?" apply
if [  $apply == "yes"  ];
then terraform apply -auto-approve
else echo "Terraform is not going to apply"
fi

echo "Rolling back the backend.tf"
sed -i "s/$ENV/_env_/g" backend.tf
echo "terraform ran succesfully."
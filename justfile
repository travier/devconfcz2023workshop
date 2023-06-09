all: fmt validate

fmt:
    terraform fmt

init:
    terraform init

validate:
    terraform validate

apply:
    terraform apply

destroy:
    terraform destroy

show:
    terraform show

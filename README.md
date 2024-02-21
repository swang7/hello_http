# hello_http

Hello world with a webserver in C

## How to build and run

```sh
packer init (only need to run one time)
packer build packer_hw5.pkr.hcl 
terraform init (only need to run one time)
terraform apply
```

## Access hello webserver

Once aws instance is running, go to your browser and access the hello server
[http://\<hostid output from terraform apply\>:8080]

## Shutdown aws instance

When done, terminate the aws instance

```terraform destroy```

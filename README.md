# hello_http

Bring up a EKS cluster with Hello world webserver service

## How to build and run

```sh
terraform init (only need to run one time)
terraform apply
```

## Access hello webserver

Once terraform apply completes, from your AWS console, 
check your AWS EKS cluster for hello-http service.
Go to your browser and access the hello server at:
[http://\<load balancer URLs\>:8080/]


Alternatively, you can get the hello-http service info with kubectl.

```sh
aws eks --region $(terraform output -raw region) update-kubeconfig  --name $(terraform output -raw cluster_name)
kubectl get services
```

The hello-http service access url is under, “EXTERNAL-IP” column.

## Shutdown Container

When done, stop and delete the container

```terraform destroy```

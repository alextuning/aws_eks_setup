Clone this Terraform repository to your local machine.

Make sure you have Terraform installed. You can download it from Terraform's official website.

Set up your AWS credentials. You can do this by configuring the AWS CLI using aws configure.

Create a file named terraform.tfvars in the eks-cluster directory with the following content:
```
cluster_name = "your-cluster-name"
vpc_id = "your-vpc-id"
subnet_ids = ["your-subnet-1-id", "your-subnet-2-id"]
```
Replace "your-cluster-name", "your-vpc-id", and "your-subnet-1-id", "your-subnet-2-id" with your values.

Initialize the Terraform configuration by running the following commands:
```
cd eks-cluster
terraform init
```
Create the EKS cluster and associated resources by running:
```
terraform apply
```
Once the Terraform deployment is complete, you will get the Kubeconfig in the Terraform output. Save it to a file, e.g., kubeconfig.yaml:
```
terraform output kubeconfig > kubeconfig.yaml
```
Configure kubectl to use the generated Kubeconfig:
```
export KUBECONFIG=$KUBECONFIG:./kubeconfig.yaml
```
You can now run a pod on your new EKS cluster using kubectl. For example:
```
kubectl run my-pod --image=nginx --replicas=1
```

provider "aws" {
  region = "us-east-1"
}

resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_eks_node_group" "my_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"

  node_group_status = "ACTIVE"
  desired_size      = 2
  max_size          = 3
  min_size          = 1

  instance_types = ["t2.small"]
}

output "kubeconfig" {
  value = aws_eks_cluster.my_cluster.kubeconfig
}

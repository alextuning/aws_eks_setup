module "eks_cluster" {
  source = "./eks"
}

output "kubeconfig" {
  value = module.eks_cluster.kubeconfig
}

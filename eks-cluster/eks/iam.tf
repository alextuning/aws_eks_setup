resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "pod_role_policy" {
  name        = "eks-pod-role-policy"
  description = "Policy for EKS pods to assume roles"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Resource = aws_iam_role.eks_cluster_role.arn
      }
    ]
  })
}

resource "aws_eks_addon" "eks_pods" {
  cluster_name = aws_eks_cluster.my_cluster.name
  addon_name  = "vpc-cni"
  addon_version = "1.7.5"
}

resource "aws_eks_update" "eks_pods_policy" {
  cluster_name = aws_eks_cluster.my_cluster.name

  update_config {
    addon_name = "vpc-cni"
  }

  apply_update = true
}

resource "aws_eks_cluster_auth" "eks_cluster_auth" {
  name = aws_eks_cluster.my_cluster.name
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = "${var.prefix}-${var.cluster_name}"
  role_arn = data.aws_iam_role.labrole.arn

  access_config {
    authentication_mode = var.authentication_mode
  }

  vpc_config {
    subnet_ids         = var.subnets_ids
    security_group_ids = [var.ssh_security_group_id]
  }
}

resource "aws_eks_node_group" "consumer-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "consumer-ng"
  node_role_arn   = data.aws_iam_role.labrole.arn
  subnet_ids      = var.subnets_ids
  instance_types  = ["t3a.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_eks_node_group" "dashboard-node-group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "dashboard-ng"
  node_role_arn   = data.aws_iam_role.labrole.arn
  subnet_ids      = var.subnets_ids
  instance_types  = ["t3a.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

resource "aws_eks_access_policy_association" "eks-policy" {
  cluster_name  = aws_eks_cluster.eks-cluster.name
  policy_arn    = var.policy_arn
  principal_arn = var.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "access-entry" {
  cluster_name      = aws_eks_cluster.eks-cluster.name
  principal_arn     = var.principal_arn
  kubernetes_groups = ["8soat"]
  type              = "STANDARD"
}

resource "aws_ecr_repository" "consumer_repository" {
  name = "consumer_repository"
}

resource "aws_ecr_repository" "dashboard_repository" {
  name = "dashboard_repository"
}

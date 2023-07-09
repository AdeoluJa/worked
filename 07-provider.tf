# Data for Cluster Auth
data "aws_eks_cluster_auth" "eks_cluster" {
  name = aws_eks_cluster.eks-cluster.name
}

data "aws_eks_cluster" "eks_cluster" {
  name = aws_eks_cluster.eks-cluster.name
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
#  config_path = pathexpand(var.kube_config)
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
  load_config_file       = false
  config_path            = "~/.kube/config"
}

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.eks_cluster.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
#   token                  = data.aws_eks_cluster_auth.eks_cluster.token
#   load_config_file       = false
# }
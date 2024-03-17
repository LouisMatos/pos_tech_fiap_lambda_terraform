data "aws_iam_policy_document" "eks_cluster_role" {

    version = "2012-10-17"

    statement {
        actions = [
        "sts:AssumeRole"
        ]

        effect = "Allow"

        principals {
        type        = "Service"
        identifiers = ["apigateway.amazonaws.com"]
        }
    }

}

resource "aws_iam_role" "apigateway_role" {
    name = format("%s-apigateway_role", var.name_role)
    assume_role_policy = data.aws_iam_policy_document.eks_cluster_role.json
}
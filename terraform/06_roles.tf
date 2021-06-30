resource "aws_iam_role" "aws_glue_env" {
    name        = "RoleAWSGlue"
    description = "Role pour l'acces aux ressources d'aws glue"

    assume_role_policy = file("${path.module}/templates/assumes/assume_role_glue.json")
}


resource "aws_iam_role_policy_attachment" "aws_glue_buckets" {
    role       = aws_iam_role.aws_glue_env.id
    policy_arn = aws_iam_policy.access_glue_buckets_envs.arn
}

resource "aws_iam_policy" "access_glue_buckets_envs" {
    name        = "AccessGlueBuckets"
    description = "Policies for Glue buckets access"

    policy = file("${path.module}/templates/policies/access_glue_buckets_envs.json")
}

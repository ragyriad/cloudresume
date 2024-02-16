resource "aws_s3_bucket" "s3_terraform_state" {
    bucket = "ragy-terraform-state-cloud-resume"
}

resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  bucket = aws_s3_bucket.s3_terraform_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.terraform_state_ownership]
  bucket = aws_s3_bucket.s3_terraform_state.id
  acl    = "private"
}

resource "aws_dynamodb_table" "statelock" {
    name = "state-lock-resume"
    billing_mode = "PAY_PER_REQUEST"
    hash_key= "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}

resource "aws_s3_bucket_public_access_block" "s3_backend_access" {
  bucket = aws_s3_bucket.s3_terraform_state.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_policy" "terraform_state_policy" {
    name        = "cloud-resume-terraform-state-access-policy"
    path        = "/"
    description = "AWS policy for cloud resume"
        policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "s3:PutObject",
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource" : [
            "${aws_s3_bucket.s3_terraform_state.arn}/*",
            "${aws_s3_bucket.s3_terraform_state.arn}"
          ],
          "Effect" : "Allow"
        },
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:PutParameter",
                "ssm:LabelParameterVersion",
                "ssm:DeleteParameter",
                "ssm:UnlabelParameterVersion",
                "ssm:DescribeParameters",
                "ssm:GetParameterHistory",
                "ssm:ListTagsForResource",
                "ssm:GetParametersByPath",
                "ssm:GetParameters",
                "ssm:GetParameter",
                "ssm:DeleteParameters"
            ],
            "Resource": "*"
        }
      ]
  })
}

resource "aws_iam_role" "s3_terraform_state_role" {
    name = "cloud-resume-terraform-state-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# resource "aws_iam_role_policy_attachment" "github_role_policy_attach" {
#   role = aws_iam_role.s3_terraform_state_role.name
#   policy_arn = aws_iam_policy.terraform_state_policy.arn
  
# }

resource "aws_iam_role_policy_attachment" "github-role-policy-attachment" {
  role       = "${aws_iam_role.s3_terraform_state_role.name}"
  policy_arn = "${aws_iam_policy.terraform_state_policy.arn}"
}


# resource "aws_s3_bucket_versioning" "versioning" {
#   bucket = aws_s3_bucket.s3_terraform_state.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }
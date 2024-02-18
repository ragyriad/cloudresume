data "archive_file" "zip_the_python_code" {
    type ="zip"
    source_file = "${path.module}/lambda/function.py"
    output_path = "${path.module}/lambda/function.zip"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


resource "aws_iam_policy" "lambda_assum_role_policy_cloud_resume" {
    name        = "cloud_resume_role_policy_views"
    path        = "/"
    description = "AWS policy for cloud resume"
    policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : "arn:aws:logs:*:*:*",
          "Effect" : "Allow"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "dynamodb:UpdateItem","dynamodb:GetItem"
          ],
          "Resource" : var.dynamodb_arn
        },
      ]
    })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_assum_role_policy_cloud_resume.arn
  
}

resource "aws_lambda_function" "incrementResumeViewsCounter" {
    filename         = data.archive_file.zip_the_python_code.output_path
    source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
    function_name    = "incrementResumeViewsCounter"
    role             = aws_iam_role.iam_for_lambda.arn
    handler          = "function.lambda_handler"
    runtime          = "python3.9"
}

resource "aws_lambda_function_url" "functionPublicUrl" {
  function_name      = aws_lambda_function.incrementResumeViewsCounter.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
resource "aws_iam_role" "cloudtrail" {
  name = "${var.name}-cloudtrail-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "cloudtrail_logging" {
  name = "${var.name}-cloudtrail-policy"
  role = aws_iam_role.cloudtrail.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketAcl",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.cloudtrail_logs.arn,
          "${aws_s3_bucket.cloudtrail_logs.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudtrail_cw" {
  role       = aws_iam_role.cloudtrail.name
  policy_arn = aws_iam_role_policy.cloudtrail_logging.policy_arn
}

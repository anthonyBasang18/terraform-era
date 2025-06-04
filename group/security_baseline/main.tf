module "cloudtrail" {
  source = "../../services/cloudtrail"
  name   = var.name
}

module "config" {
  source         = "../../services/config"
  name           = var.name
  s3_bucket_name = "${var.name}-config-bucket"
  sns_topic_arn  = ""  #optional
}

module "guardduty" {
  source = "../../services/guardduty"
  name   = var.name
}

module "securityhub" {
  source = "../../services/securityhub"
  name   = var.name
}

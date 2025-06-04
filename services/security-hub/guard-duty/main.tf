resource "aws_securityhub_account" "this" {
  depends_on = [aws_guardduty_detector.this]  # Ensure GuardDuty is enabled first if you wish
}

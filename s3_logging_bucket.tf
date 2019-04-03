data "template_file" "s3_bucket_policy" {
  template       = "${var.bucketpolicy}"
}

resource "aws_s3_bucket" "bucket" {
  bucket        = "${var.s3bucketname}"
  acl           = "${var.acl}"
  force_destroy = false
  policy        = "${data.template_file.s3_bucket_policy.rendered}"
  logging {
    target_bucket = "${var.targetbucket}"
    target_prefix = "${var.s3bucketname}_s3_access_log/"
  }
  tags { Name = "${var.s3bucketname}" }
  versioning { enabled = true }
}

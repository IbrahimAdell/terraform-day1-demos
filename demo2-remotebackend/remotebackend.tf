resource "aws_s3_bucket" "s3-remote-state" {
  bucket = "ntis3bucket1"
}

resource "aws_s3_bucket_versioning" "enable"{
  bucket = aws_s3_bucket.s3-remote-state.id
  versioning_configuration {
      status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "nti-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key     = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}

#terraform {
    #backend "s3" {
      #  bucket         = "ntis3bucket1"
     #   key            = "state/terraform.tfstate"
    #    region         = "us-east-1"
   #     dynamodb_table = "nti-lock"
  #      encrypt        = true
 #   }
#}


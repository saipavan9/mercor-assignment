terraform {
  backend "s3" {
    bucket       = "tf-state-bucket-1409"
    key          = "terraform.tfstate"
    region       = "us-east-1" 
    use_lockfile = true
  }
}

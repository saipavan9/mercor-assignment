terraform {
  backend "s3" {
    bucket       = "state-bucket-124689"
    key          = "terraform.tfstate"
    region       = "us-east-1" 
    use_lockfile = true
  }
}

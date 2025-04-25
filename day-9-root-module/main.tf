module "dev" {
    source =  "./modules/ec2-instance-module"
    ami_id = var.ami_id
    instance_type = var.instance_type
}
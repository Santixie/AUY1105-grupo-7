package terraform.security

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_instance"
  r.change.after.instance_type != "t2.micro"
  msg := "ERROR: Solo se permite el tipo de instancia t2.micro"
}
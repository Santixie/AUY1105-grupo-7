# Esta política restringe el tipo de instancia EC2 permitido
# validando el valor por defecto de la variable instance_type,
# para control de costos.
#
# Nota: se evalúa contra el default de la variable (no contra un
# plan de Terraform), porque el pipeline de CI no cuenta con
# credenciales AWS persistentes para generar un plan real
# (el laboratorio usa credenciales temporales de AWS Academy).
package terraform.security

deny[msg] {
  v := input.variable.instance_type
  val := v["default"]
  val != "t2.micro"
  msg := sprintf("ERROR: El valor por defecto de instance_type es '%s'; solo se permite t2.micro", [val])
}
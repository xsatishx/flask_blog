package main

deny[msg] {
  input.kind == "Deployment"
  replicas := input.spec.template.replicas
  replicas == 8
  msg := sprintf("replicas is set to '%v' which should be 2", [replicas])
}


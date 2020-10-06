package main

deny[msg] {
  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  not count(split(image, ":")) == 2
  msg := sprintf("image '%v' does not have a valid tag", [image])
}

deny[msg] {
  input.kind == "Deployment"
  image := input.spec.template.spec.containers[_].image
  endswith(image, "latest")
  msg := sprintf("image '%v' uses the latest tag", [image])
}

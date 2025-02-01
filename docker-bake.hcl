variable "USERNAME" {
    default = "mnb3000"
}

variable "APP" {
    default = "dotfiles-image"
}

variable "RELEASE" {
    default = "testing"
}

variable "ARCH_BASE_IMAGE" {
  default = "menci/archlinuxarm:base-devel"
}

variable "ALPINE_BASE_IMAGE" {
  default = "bash:devel-alpine3.20"
}

# target "docker-metadata-action" {}

target "_common" {
  args = {
    USERNAME = "${USERNAME}"
  }
  dockerfile = "Dockerfile"
  platforms = ["linux/aarch64"]
}

target "all" {
  inherits = ["_common"]
  name = "${distro}"
  tags = ["${USERNAME}/${APP}:${distro}-${RELEASE}"]
  args = {
    DOTBOT_TARGET = distro
    BASE_IMAGE = distro == "alpine" ? ALPINE_BASE_IMAGE : ARCH_BASE_IMAGE
  }
  matrix = {
    distro = ["arch", "alpine"]
  }
}

target "arch" {
  # inherits = ["docker-metadata-action"]
  inherits = ["_common"]
  args = {
    DOTBOT_TARGET = "arch"
    DOTBOT_PROFILE = "ipad/arch-utm"
    BASE_IMAGE = ARCH_BASE_IMAGE
  }
}

target "alpine" {
  # inherits = ["docker-metadata-action"]
  inherits = ["_common"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "ipad/alpine-utm"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }
}

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
  default = "bash:devel-alpine3.21"
}

# target "docker-metadata-action" {}

target "_common" {
  args = {
    USERNAME = "${USERNAME}"
  }
  dockerfile = "Dockerfile"
  platforms = ["linux/aarch64"]
}

target "docker-metadata-action" {}

target "all" {
  inherits = ["_common", "docker-metadata-action"]
  name = "${distro}"
  tags = ["${USERNAME}/${APP}:${distro}-${RELEASE}"]
  args = {
    DOTBOT_TARGET = distro
    BASE_IMAGE = distro == "alpine" ? ALPINE_BASE_IMAGE : ARCH_BASE_IMAGE
  }
  matrix = {
    distro = ["arch", "alpine", "alpine-minimal"]
  }
}

target "arch" {
  inherits = ["_common"]
  args = {
    DOTBOT_TARGET = "arch"
    DOTBOT_PROFILE = "utm/arch-utm"
    BASE_IMAGE = ARCH_BASE_IMAGE
  }
}

target "alpine" {
  inherits = ["_common"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "utm/alpine-utm"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }
}

target "alpine-minimal" {
  inherits = ["_common"]
  args = {
    DOTBOT_TARGET = "alpine"
    DOTBOT_PROFILE = "minimal/alpine"
    BASE_IMAGE = ALPINE_BASE_IMAGE
  }
}

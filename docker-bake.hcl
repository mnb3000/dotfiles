variable "USERNAME" {
    default = "mnb3000"
}

variable "APP" {
    default = "dotfiles-arch-builder"
}

variable "RELEASE" {
    default = "0.0.1"
}

variable "DOTBOT_PROFILE" {
  default = "ipad/arch-utm"
}

# target "docker-metadata-action" {}

target "default" {
    # inherits = ["docker-metadata-action"]
    dockerfile = "Dockerfile"
    # Uncomment this line to build locally
    tags = ["${USERNAME}/${APP}:${RELEASE}"]
    args = {
        USERNAME = "${USERNAME}"
        DOTBOT_PROFILE = "${DOTBOT_PROFILE}"
    }
    platforms = ["linux/aarch64"]
}

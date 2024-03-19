# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "container_tag" {
  description = "Docker image tag"
  type        = string
}

variable "ecr_repo" {
  description = "ECR Repository"
  type        = string
}

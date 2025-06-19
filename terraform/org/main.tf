# Configure the Google Cloud provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"  # Use a recent version
    }
  }
}

provider "google" {
  project = "600587461297" # Replace with your project ID
}

# Data source for the project
data "google_project" "current" {
  project_id = "600587461297"
}

# Define a variable for the target project ID from IAM_BINDINGS
variable "target_project_id" {
  description = "The ID of the project to apply IAM changes to."
  type        = string
  default     = "watchtest4" # Default to the project specified in IAM_BINDINGS
}


# Remove the unused IAM role using google_project_iam_member
resource "google_project_iam_member" "remove_unused_editor_role" {
  project = data.google_project.current.project_id
  role    = "roles/editor"
  member  = "serviceAccount:600587461297-compute@developer.gserviceaccount.com"
  # Add condition to prevent deletion of the member if it is added manually.
  lifecycle {
    ignore_changes = [
      condition,
    ]
    # prevent_destroy = true # Recommended for important resources, but not needed here
  }
}

# Example of how to add a new role if needed.
resource "google_project_iam_member" "add_new_role" {
    project = data.google_project.current.project_id
    role    = "roles/viewer"
    member  = "serviceAccount:600587461297-compute@developer.gserviceaccount.com"

    lifecycle {
      ignore_changes = [
        condition,
      ]
    }
}

# --- IAM BINDINGS from input ---

# REMOVE serviceAccount:service-730940887623@gcp-sa-slz.iam.gserviceaccount.com from roles/owner on project watchtest4
resource "google_project_iam_member_remove" "remove_owner_slz_service_account" {
  project = var.target_project_id
  role    = "roles/owner"
  member  = "serviceAccount:service-730940887623@gcp-sa-slz.iam.gserviceaccount.com"
}

# ADD serviceAccount:service-730940887623@gcp-sa-slz.iam.gserviceaccount.com to roles/securedlandingzone.serviceAgent on project watchtest4
resource "google_project_iam_member" "add_slz_service_agent_slz_service_account" {
  project = var.target_project_id
  role    = "roles/securedlandingzone.serviceAgent"
  member  = "serviceAccount:service-730940887623@gcp-sa-slz.iam.gserviceaccount.com"
}
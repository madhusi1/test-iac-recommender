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
  project = "karans-project-1" # Updated to target project ID
}

# Data source for the project
data "google_project" "current" {
  project_id = "karans-project-1" # Updated to target project ID
}

# Remove the editor role for the container registry service account
resource "google_project_iam_member_remove" "remove_containerregistry_editor" {
  project = data.google_project.current.project_id
  role    = "roles/editor"
  member  = "serviceAccount:service-1011641287923@containerregistry.iam.gserviceaccount.com"
}

# Add the containerregistry.ServiceAgent role for the container registry service account
resource "google_project_iam_member" "add_containerregistry_service_agent" {
    project = data.google_project.current.project_id
    role    = "roles/containerregistry.ServiceAgent"
    member  = "serviceAccount:service-1011641287923@containerregistry.iam.gserviceaccount.com"

    lifecycle {
      ignore_changes = [
        condition,
      ]
    }
}

# Removed previous google_project_iam_member resources as they were for a different project/member.
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

# Add roles for group:slz-blr@google.com on project sdw-data-ing-92a872-14bc
resource "google_project_iam_member" "iam_member_slz_blr_cloudbuild_viewer" {
  project = "sdw-data-ing-92a872-14bc"
  role    = "roles/cloudbuild.builds.viewer"
  member  = "group:slz-blr@google.com"
}

resource "google_project_iam_member" "iam_member_slz_blr_dataflow_developer" {
  project = "sdw-data-ing-92a872-14bc"
  role    = "roles/dataflow.developer"
  member  = "group:slz-blr@google.com"
}

# Remove roles for group:slz-blr@google.com on project sdw-data-ing-92a872-14bc
resource "google_project_iam_member_remove" "iam_member_remove_slz_blr_cloudbuild_editor" {
  project = "sdw-data-ing-92a872-14bc"
  role    = "roles/cloudbuild.builds.editor"
  member  = "group:slz-blr@google.com"
}

resource "google_project_iam_member_remove" "iam_member_remove_slz_blr_dataflow_admin" {
  project = "sdw-data-ing-92a872-14bc"
  role    = "roles/dataflow.admin"
  member  = "group:slz-blr@google.com"
}
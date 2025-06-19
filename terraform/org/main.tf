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

# IAM Bindings for project pam-maf-1724252793-dut-4

# REMOVE roles/resourcemanager.projectIamAdmin for serviceAccount:maf-test@pam-maf-1724252793-dut-4.iam.gserviceaccount.com
resource "google_project_iam_member_remove" "remove_project_iam_admin_sa_maf_test" {
  project = "pam-maf-1724252793-dut-4"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:maf-test@pam-maf-1724252793-dut-4.iam.gserviceaccount.com"
}

# ADD organizations/9454078371/roles/CustomRole262 for serviceAccount:maf-test@pam-maf-1724252793-dut-4.iam.gserviceaccount.com
resource "google_project_iam_member" "add_custom_role_262_sa_maf_test" {
  project = "pam-maf-1724252793-dut-4"
  role    = "organizations/9454078371/roles/CustomRole262"
  member  = "serviceAccount:maf-test@pam-maf-1724252793-dut-4.iam.gserviceaccount.com"
}

# REMOVE roles/resourcemanager.projectIamAdmin for group:maf-dev@twosync.google.com
resource "google_project_iam_member_remove" "remove_project_iam_admin_group_maf_dev" {
  project = "pam-maf-1724252793-dut-4"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "group:maf-dev@twosync.google.com"
}

# ADD organizations/9454078371/roles/CustomRole262 for group:maf-dev@twosync.google.com
resource "google_project_iam_member" "add_custom_role_262_group_maf_dev" {
  project = "pam-maf-1724252793-dut-4"
  role    = "organizations/9454078371/roles/CustomRole262"
  member  = "group:maf-dev@twosync.google.com"
}

# REMOVE roles/editor for group:maf-dev@twosync.google.com
resource "google_project_iam_member_remove" "remove_editor_group_maf_dev" {
  project = "pam-maf-1724252793-dut-4"
  role    = "roles/editor"
  member  = "group:maf-dev@twosync.google.com"
}

# ADD roles/resourcemanager.projectMover for group:maf-dev@twosync.google.com
resource "google_project_iam_member" "add_project_mover_group_maf_dev" {
  project = "pam-maf-1724252793-dut-4"
  role    = "roles/resourcemanager.projectMover"
  member  = "group:maf-dev@twosync.google.com"
}

# ADD roles/serviceusage.serviceUsageAdmin for group:maf-dev@twosync.google.com
resource "google_project_iam_member" "add_service_usage_admin_group_maf_dev" {
  project = "pam-maf-1724252793-dut-4"
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "group:maf-dev@twosync.google.com"
}
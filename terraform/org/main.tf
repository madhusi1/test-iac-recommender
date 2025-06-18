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

# Remove specific IAM members from the project "pam-iam-conditions-demo"
# These resources use google_project_iam_member_remove because the bindings
# are assumed to not be managed by this Terraform configuration.

resource "google_project_iam_member_remove" "remove_pam_service_agent_role" {
  project = "pam-iam-conditions-demo"
  role    = "roles/privilegedaccessmanager.projectServiceAgent"
  member  = "serviceAccount:service-687524231482@gcp-sa-staging-pam.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_role_viewer_iamconditionstestreq" {
  project = "pam-iam-conditions-demo"
  role    = "roles/iam.roleViewer"
  member  = "user:iamconditionstestreq@gmail.com"
}

resource "google_project_iam_member_remove" "remove_viewer_pprequester99" {
  project = "pam-iam-conditions-demo"
  role    = "roles/viewer"
  member  = "user:pprequester99@gmail.com"
}

resource "google_project_iam_member_remove" "remove_viewer_pamrequestergkmr" {
  project = "pam-iam-conditions-demo"
  role    = "roles/viewer"
  member  = "user:pamrequestergkmr@gmail.com"
}

resource "google_project_iam_member_remove" "remove_custom_role_iamconditionstestreq" {
  project = "pam-iam-conditions-demo"
  role    = "projects/pam-iam-conditions-demo/roles/CustomRole"
  member  = "user:iamconditionstestreq@gmail.com"
}
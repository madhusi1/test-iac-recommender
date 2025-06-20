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

# Resources to remove specific IAM members from project sdw-non-conf-551095-7ae6
# These resources are added because the specified bindings were not found
# managed by existing resources in this file.
resource "google_project_iam_member_remove" "remove_project_iam_admin_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_bigquery_data_viewer_sa_dataflow_reid" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/bigquery.dataViewer"
  member  = "serviceAccount:sa-dataflow-controller-reid@sdw-conf-551095-7409.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_bigquery_admin_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/bigquery.admin"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_sa_token_creator_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_sa_admin_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_storage_admin_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/storage.admin"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_service_usage_admin_dwsalabels" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/serviceusage.serviceUsageAdmin"
  member  = "serviceAccount:dwsalabels@gfelipesbpsa.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_bigquery_data_editor_sa_dataflow" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:sa-dataflow-controller@sdw-data-ing-551095-4fff.iam.gserviceaccount.com"
}

resource "google_project_iam_member_remove" "remove_bigquery_job_user_sa_dataflow" {
  project = "sdw-non-conf-551095-7ae6"
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:sa-dataflow-controller@sdw-data-ing-551095-4fff.iam.gserviceaccount.com"
}
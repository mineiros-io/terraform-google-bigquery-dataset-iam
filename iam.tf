resource "google_bigquery_dataset_iam_binding" "binding" {
  count = var.module_enabled && var.authoritative ? 1 : 0

  project    = var.project
  dataset_id = var.dataset_id
  role       = var.role
  members    = var.members

  depends_on = [var.module_depends_on]
}

resource "google_bigquery_dataset_iam_member" "member" {
  for_each = var.module_enabled && !var.authoritative ? var.members : []

  project    = var.project
  dataset_id = var.dataset_id
  role       = var.role
  member     = each.value

  depends_on = [var.module_depends_on]
}

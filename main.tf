resource "google_storage_bucket" "bucket" {
  name     = "${var.bucket_name}"
  
  website {
    main_page_suffix = "index.html"
  }
}
resource "google_storage_bucket_object" "bucketobject" {
    depends_on = ["google_storage_bucket.bucket"]
    name = "index.html"
    bucket = "${google_storage_bucket.bucket.name}"
    source = "./src/index.html"
    content_type ="text/html"
}

### ACL
resource "google_storage_object_acl" "acl" {
   bucket = "${google_storage_bucket.bucket.name}"
   object = "${google_storage_bucket_object.bucketobject.name}"

  role_entity = [
    "READER:allUsers",
  ]
}
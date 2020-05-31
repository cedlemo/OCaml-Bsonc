
let () =
  let open Alcotest in
  run "Bson" [
    "Bson document", Bson_document.tests;
    "Bson versioning", Bson_version.tests;
  ]

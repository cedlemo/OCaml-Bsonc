open Alcotest
open Bsonc

let test_append_bool () =
  let document = Bson.create () in
  let res = Bson.append_bool document "foo" false in
  Alcotest.(check bool) "append ok" true res

let test_as_json () =
  let document = Bson.create () in
  let _res = Bson.append_bool document "foo" false in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : false }" data

let test_append_int32 () =
  let document = Bson.create () in
  let res = Bson.append_int32 document "foo" 1l in
  Alcotest.(check bool) "append ok" true res

let check_json expected = function
  | None -> Alcotest.fail "json expected"
  | Some json ->
    Alcotest.(check string)  "same code" expected json

let test_append_int64 () =
  let document = Bson.create () in
  let res = Bson.append_int64 document "foo" 1L in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"foo\" : 1 }" @@ Bson.as_json document

let test_append_null () =
  let document = Bson.create () in
  let res = Bson.append_null document "foo" in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"foo\" : null }" @@ Bson.as_json document

let test_append_code () =
  let document = Bson.create () in
  let res = Bson.append_code document "SetXtoY" "x = y" in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"SetXtoY\" : { \"$code\" : \"x = y\" } }" @@ Bson.as_json document

let test_append_code_with_scope_with_scope () =
  let document = Bson.create () in
  let scope = Bson.create () in
  let _ = Bson.append_code scope "identity" "x => x" in
  let res = Bson.append_code_with_scope document "SetXtoY" "x = y" (Some scope) in
  let () = Alcotest.(check bool) "append ok" true res in
  let expected = "{ \"SetXtoY\" : { \"$code\" : \"x = y\", \"$scope\" : { \"identity\" : { \"$code\" : \"x => x\" } } } }" in
  check_json expected @@ Bson.as_json document

let test_append_code_with_scope_without_scope () =
  let document = Bson.create () in
  let res = Bson.append_code_with_scope document "SetXtoY" "x = y" None in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"SetXtoY\" : { \"$code\" : \"x = y\" } }" @@ Bson.as_json document

let test_append_date_time () =
  let document = Bson.create () in
  let res = Bson.append_date_time document "foo" 1L in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"foo\" : { \"$date\" : 1 } }" @@ Bson.as_json document

let test_append_utf8 () =
  let document = Bson.create () in
  let res = Bson.append_utf8 document "foo" "éøö"in
  let () = Alcotest.(check bool) "append ok" true res in
  check_json "{ \"foo\" : \"éøö\" }" @@ Bson.as_json document

let test_as_canonical_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1l in
  check_json "{ \"foo\" : { \"$numberInt\" : \"1\" } }" @@ Bson.as_json document

let test_as_relaxed_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1l in
  check_json "{ \"foo\" : 1 }" @@ Bson.as_json document

let tests = [
  test_case "append_bool" `Quick test_append_bool;
  test_case "as_json" `Quick test_as_json;
  test_case "append_int32" `Quick test_append_int32;
  test_case "append_int64" `Quick test_append_int64;
  test_case "append_null" `Quick test_append_null;
  test_case "append_code" `Quick test_append_code;
  test_case "append_code_with_scope_with_scope" `Quick test_append_code_with_scope_with_scope;
  test_case "append_code_with_scope_without_scope" `Quick test_append_code_with_scope_without_scope;
  test_case "append_date_time" `Quick test_append_date_time;
  test_case "append_utf8" `Quick test_append_utf8;
  (*
  test_case "as_canonical_extended_json" `Quick test_as_canonical_extended_json;
  test_case "as_relaxed_extended_json" `Quick test_as_relaxed_extended_json;
  *)
]

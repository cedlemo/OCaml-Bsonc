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

let test_append_int64 () =
  let document = Bson.create () in
  let res = Bson.append_int64 document "foo" 1L in
  let () = Alcotest.(check bool) "append ok" true res in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some json ->
    Alcotest.(check string)  "same code" "{ \"foo\" : 1 }" json

let test_append_null () =
  let document = Bson.create () in
  let res = Bson.append_null document "foo" in
  let () = Alcotest.(check bool) "append ok" true res in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some json ->
    Alcotest.(check string)  "same code" "{ \"foo\" : null }" json

let test_append_code () =
  let document = Bson.create () in
  let res = Bson.append_code document "SetXtoY" "x = y" in
  let () = Alcotest.(check bool) "append ok" true res in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some json ->
    Alcotest.(check string)  "same code" "{ \"SetXtoY\" : { \"$code\" : \"x = y\" } }" json

let test_append_code_with_scope_with_scope () =
  let document = Bson.create () in
  let scope = Bson.create () in
  let _ = Bson.append_code scope "identity" "x => x" in
  let res = Bson.append_code_with_scope document "SetXtoY" "x = y" (Some scope) in
  let () = Alcotest.(check bool) "append ok" true res in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some json ->
    let expected = "{ \"SetXtoY\" : { \"$code\" : \"x = y\", \"$scope\" : { \"identity\" : { \"$code\" : \"x => x\" } } } }" in
    Alcotest.(check string) "same code" expected json

let test_append_code_with_scope_without_scope () =
  let document = Bson.create () in
  let res = Bson.append_code_with_scope document "SetXtoY" "x = y" None in
  let () = Alcotest.(check bool) "append ok" true res in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some json ->
    Alcotest.(check string)  "same code" "{ \"SetXtoY\" : { \"$code\" : \"x = y\" } }" json

let test_as_canonical_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1l in
  match Bson.as_canonical_extended_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : { \"$numberInt\" : \"1\" } }" data

let test_as_relaxed_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1l in
  match Bson.as_relaxed_extended_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : 1 }" data

let tests = [
  test_case "append_bool" `Quick test_append_bool;
  test_case "as_json" `Quick test_as_json;
  test_case "append_int32" `Quick test_append_int32;
  test_case "append_int64" `Quick test_append_int64;
  test_case "append_null" `Quick test_append_null;
  test_case "append_code" `Quick test_append_code;
  test_case "append_code_with_scope_with_scope" `Quick test_append_code_with_scope_with_scope;
  test_case "append_code_with_scope_without_scope" `Quick test_append_code_with_scope_without_scope;
  (*
  test_case "as_canonical_extended_json" `Quick test_as_canonical_extended_json;
  test_case "as_relaxed_extended_json" `Quick test_as_relaxed_extended_json;
  *)
]

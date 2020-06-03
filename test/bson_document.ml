open Alcotest
open Bsonc

let test_append_int32 () =
  let document = Bson.create () in
  let res = Bson.append_int32 document "foo" 1 in
  Alcotest.(check bool) "append ok" true res

let test_append_bool () =
  let document = Bson.create () in
  let res = Bson.append_bool document "foo" false in
  Alcotest.(check bool) "append ok" true res

let test_as_canonical_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1 in
  match Bson.as_canonical_extended_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : { \"$numberInt\" : \"1\" } }" data

let test_as_relaxed_extended_json () =
  let document = Bson.create () in
  let _res = Bson.append_int32 document "foo" 1 in
  match Bson.as_relaxed_extended_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : 1 }" data

let test_as_json () =
  let document = Bson.create () in
  let _res = Bson.append_bool document "foo" false in
  match Bson.as_json document with
  | None -> Alcotest.fail "json expected"
  | Some data -> Alcotest.(check string) "same string" "{ \"foo\" : false }" data

let tests = [
  test_case "append_int32" `Quick test_append_int32;
  test_case "append_bool" `Quick test_append_bool;
  test_case "as_json" `Quick test_as_json;
  (*
  test_case "as_canonical_extended_json" `Quick test_as_canonical_extended_json;
  test_case "as_relaxed_extended_json" `Quick test_as_relaxed_extended_json;
  *)
]

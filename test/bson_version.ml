open Alcotest
open Bsonc

let test_check_version () =
  let major = Version.get_major () in
  let minor = Version.get_minor () in
  let micro = Version.get_micro () in
  let res = Version.check_version major minor micro in
  Alcotest.(check bool) "check version ok" true res

let test_get_version () =
  let major = Version.get_major () in
  let minor = Version.get_minor () in
  let micro = Version.get_micro () in
  let version = Version.get_version () in
  let pattern = Printf.sprintf "^%d\\.%d\\.%d.*$" major minor micro in
  let rex = Re.Pcre.regexp pattern in
  let res = Re.Pcre.pmatch ~rex version in
  Alcotest.(check bool) "get version ok" true res

let tests = [
  test_case "check_version" `Quick test_check_version;
  test_case "get_version" `Quick test_get_version;
]

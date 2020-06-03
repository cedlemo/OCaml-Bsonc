(*
 * Copyright 2020 Cedric LE MOIGNE, cedlemo@gmx.com
 * This file is part of OCaml-bsonc.
 *
 * OCaml-bsonc is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * OCaml-bsonc is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with OCaml-bsonc.  If not, see <http://www.gnu.org/licenses/>.
 *)

open Ctypes
open Foreign
open Memory_management

type t = unit ptr
let t : t typ = ptr void

let destroy =
  foreign "bson_destroy" (t @-> returning void)

let create () =
  let raw = foreign "bson_new" (void @-> returning t) in
  let document = raw () in
  let _ = Gc.finalise destroy document in
  document

let append_int32 document key value =
  let raw = foreign "bson_append_int32" (t @-> string @-> int @-> int @-> returning bool)
  in raw document key (String.length key) value

let append_bool document key value =
  let raw = foreign "bson_append_bool" (t @-> string @-> int @-> bool @-> returning bool)
  in raw document key (String.length key) value

let transform_to_json fn_name document =
let raw =
    foreign fn_name (t @-> ptr int @-> returning (ptr_opt char))
  in
  let len_ptr = allocate int 0 in
  match raw document len_ptr with
  | None -> None
  | Some ptr -> let len = !@ len_ptr in
  let res = Utils.char_ptr_to_string ptr len in
  let () = bson_free_char ptr in
  Some res

let as_canonical_extended_json document =
  transform_to_json "bson_as_canonical_extended_json" document

let as_relaxed_extended_json document =
  transform_to_json "bson_as_relaxed_extended_json" document

let as_json document =
  transform_to_json "bson_as_json" document


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

(** Versionning functions *)

let check_version =
  foreign "bson_check_version" (int @-> int @-> int @-> returning bool)

let get_major =
  foreign "bson_get_major_version" (void @-> returning int)

let get_minor =
  foreign "bson_get_minor_version" (void @-> returning int)

let get_micro =
  foreign "bson_get_micro_version" (void @-> returning int)

let get_version =
  (* Internal C string that we must not free or modify *)
  foreign "bson_get_version" (void @-> returning string)

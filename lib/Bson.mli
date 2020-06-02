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

(** BSON Document Abstraction *)

(** The Bson.t type represents a BSON document. *)
type t

(** The Bson.create function shall create a new underlying bson_t structure on the heap.
 * It should be freed with bson_destroy() when it is no longer in use.
 * The underlying bson_t structure is destroyed when the OCaml garbage collector
 * clean the created document.
 *)
val create:
  unit -> t

(** http://mongoc.org/libbson/current/bson_append_int32.html
 * The append_int32 function shall append a new element to the bson
 * document
 * *)
val append_int32:
  t -> string -> int -> bool

(** http://mongoc.org/libbson/current/bson_append_bool.html
 * The append_bool function shall append a new element to the bson
 * document
 * *)
val append_bool:
  t -> string -> bool -> bool

(**
 * Bsonc provides routines for converting to and from the JSON format. In particular,
 * it supports the MongoDB extended JSON format.
 * http://mongoc.org/libbson/current/json.html#
 * *)

(**
 * http://mongoc.org/libbson/current/bson_as_canonical_extended_json.html
 * Encodes bson as an UTF-8 string in the canonical MongoDB Extended JSON format. *)
val as_canonical_extended_json:
  t -> string

(**
 * http://mongoc.org/libbson/current/bson_as_relaxed_extended_json.html
 * Encodes bson as an UTF-8 string in the relaxed MongoDB Extended JSON format. *)
val as_relaxed_extended_json:
  t -> string

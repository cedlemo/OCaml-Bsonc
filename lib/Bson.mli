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
  t -> string -> int32 -> bool

(** http://mongoc.org/libbson/current/bson_append_int64.html
 * The append_int64 function shall append a new element to the bson
 * document
 * *)
val append_int64:
  t -> string -> int64 -> bool

(** http://mongoc.org/libbson/current/bson_append_null.html
 * The append_null function shall append a new element to the bson
 * document
 * *)
val append_null:
  t -> string -> bool

(** http://mongoc.org/libbson/current/bson_append_bool.html
 * The append_bool function shall append a new element to the bson
 * document
 * *)
val append_bool:
  t -> string -> bool -> bool

(** http://mongoc.org/libbson/current/bson_append_date_time.html.html
 * The append_date_time function function shall append a new element to
 * a bson document containing a date and time with no timezone information.
 * The value is assumed to be in UTC format of milliseconds since the UNIX
 * epoch. and MAY be negative.
 * *)
val append_date_time:
  t -> string -> int64 -> bool

(** http://mongoc.org/libbson/current/bson_append_utf8.html.html
 * The append_bool function shall append a new element to the bson
 * document
 * *)
val append_utf8:
  t -> string -> string -> bool

exception Args_error of string

(** http://http://mongoc.org/libbson/current/bson_append_code.html
 * The append_code function shall append a new element to bson using the UTF-8
 * encoded javascript provided.
 * If the string length is greater than INT32_MAX, this function throws
 *)
val append_code:
  t -> string -> string -> bool

(** http://http://mongoc.org/libbson/current/bson_append_code_with_scope.html
 * The append_code_with_scope function shall perform like append_code except it
 * allows providing a scope to the javascript function in the form of a bson document.
 * If scope is NULL, this function appends an element with BSON type “code”,
 * otherwise with BSON type “code with scope”.
 * If the string length is greater than INT32_MAX, this function throws
 *)
val append_code_with_scope:
  t -> string -> string -> t option -> bool

(**
 * Bsonc provides routines for converting to and from the JSON format. In particular,
 * it supports the MongoDB extended JSON format.
 * http://mongoc.org/libbson/current/json.html#
 * *)

(**
 * http://mongoc.org/libbson/current/bson_as_canonical_extended_json.html
 * Encodes bson as an UTF-8 string in the canonical MongoDB Extended JSON format. *)
val as_canonical_extended_json:
  t -> string option

(**
 * http://mongoc.org/libbson/current/bson_as_relaxed_extended_json.html
 * Encodes bson as an UTF-8 string in the relaxed MongoDB Extended JSON format. *)
val as_relaxed_extended_json:
  t -> string option

(**
 * http://mongoc.org/libbson/current/bson_as_json.html
 * Encodes bson as an UTF-8 string using libbson's legacy JSON format. *)
val as_json:
  t -> string option

(*

bson_t

    bson_append_array()
    bson_append_array_begin()
    bson_append_array_end()
    bson_append_binary()
OK  bson_append_bool()
OK  bson_append_code()
OK  bson_append_code_with_scope()
OK  bson_append_date_time()
DEP bson_append_dbpointer() PRECATED
    bson_append_decimal128()
    bson_append_document()
    bson_append_document_begin()
    bson_append_document_end()
    bson_append_double()
OK  bson_append_int32()
OK  bson_append_int64()
    bson_append_iter()
    bson_append_maxkey()
    bson_append_minkey()
    bson_append_now_utc()
OK  bson_append_null()
    bson_append_oid()
    bson_append_regex()
    bson_append_regex_w_len()
    bson_append_symbol()
    bson_append_time_t()
    bson_append_timestamp()
    bson_append_timeval()
DEP bson_append_undefined() PRECATED
OK  bson_append_utf8()
    bson_append_value()
    bson_array_as_json()
    bson_as_canonical_extended_json()
    bson_as_json()
    bson_as_relaxed_extended_json()
    bson_compare()
    bson_concat()
    bson_copy()
    bson_copy_to()
    bson_copy_to_excluding()
    bson_copy_to_excluding_noinit()
    bson_copy_to_excluding_noinit_va()
    bson_count_keys()
    bson_destroy()
    bson_destroy_with_steal()
    bson_equal()
    bson_get_data()
    bson_has_field()
    bson_init()
    bson_init_from_json()
    bson_init_static()
    bson_new()
    bson_new_from_buffer()
    bson_new_from_data()
    bson_new_from_json()
    bson_reinit()
    bson_reserve_buffer()
    bson_sized_new()
    bson_steal()
    bson_validate()
    bson_validate_with_error()

*)

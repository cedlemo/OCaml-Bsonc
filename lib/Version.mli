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

(** Versionning functions *)

val check_version : int -> int -> int -> bool
(**
 * Usage: check_version required_major required_minor required_micro
 *   required_major: The minimum major version required.
 *   required_minor: The minimum minor version required.
 *   required_micro: The minimum micro version required.
 *)

val get_major : unit -> int

val get_minor : unit -> int

val get_micro : unit -> int

val get_version : unit -> string

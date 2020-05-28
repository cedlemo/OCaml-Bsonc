open Ctypes
open Foreign
open Memcpy

(** C String utilities *)

(** Ctypes binding to the C strlen function. It returns the length of a C
    string (ie C char array terminated by '\0'.*)
let c_strlen =
  foreign "strlen" (ptr char @-> returning int)

let string_to_char_ptr str =
  let open Memcpy in
  let len = String.length str in
  let dst = allocate_n char (len + 1) in (* Ctypes.allocate* allocate zero filled mem.*)
  let src = Bytes.of_string str in
  let () = unsafe_memcpy ocaml_bytes pointer src dst len in
  dst

let char_ptr_to_string _ptr =
  let open Memcpy in
  let len = c_strlen _ptr in
  let buf = Bytes.make len '\000' in
  let () = unsafe_memcpy pointer ocaml_bytes _ptr buf len in
  Bytes.to_string buf


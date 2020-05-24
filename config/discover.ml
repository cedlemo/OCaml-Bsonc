open Base
open Stdio
module C = Configurator

let write_sexp fn list_of_str =
  let data = sexp_of_list sexp_of_string list_of_str |> Sexp.to_string in
  Out_channel.write_all fn ~data

let write_flags file list_of_str =
  let data = String.concat list_of_str ~sep:" " in
  Out_channel.write_all file ~data

let () =
  C.main ~name:"libbson" (fun c ->
    let default : C.Pkg_config.package_conf =
      { libs = ["-lbson-1.0"] ; cflags = ["-I/usr/include/libbson-1.0"] }
    in
    let conf =
      match C.Pkg_config.get c with
      | None -> default
      | Some pc ->
         let get_config package default =
           Option.value (C.Pkg_config.query pc ~package) ~default in
         let bson = get_config "libbson-1.0" default in
         let  module P = C.Pkg_config in
         { libs = bson.P.libs; cflags = bson.P.cflags }
    in
    write_sexp "c_flags.sexp"         conf.cflags;
    write_sexp "c_library_flags.sexp" conf.libs)

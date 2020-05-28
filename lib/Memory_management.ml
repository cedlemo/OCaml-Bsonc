open Ctypes
open Foreign

let bson_free_char =
  foreign "bson_free" (ptr char @-> returning void)

#module API

using DataFrames, Genie, Genie.Router, Genie.Renderer, Genie.Renderer.Json, Genie.Requests

route(ControllerGetUsers, "/page/users", method="GET")
route(ControllerGetUserById, "/page/users/:id", method="GET")
route(ControllerCreateUser, "/page/user/createuser", method="POST")
route(ControllerUpdateUser, "/page/user/updateuser/:id", method="PUT")
route(ControllerDeleteUser, "/page/user/deleteuser/:id", method="DELETE")

#end # module API

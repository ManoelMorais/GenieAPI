#module API

using DataFrames, Genie, Genie.Router, Genie.Renderer, Genie.Renderer.Json, Genie.Requests, UUIDs, Dates

route(ControllerGetUser, "/getUser", method="GET")
route(ControllerCreateUser, "/createUser", method="POST")

#end # module API
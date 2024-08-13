#module API

using DataFrames, Genie.Renderer, Genie.Renderer.Json, Genie.Requests, UUIDs, Dates
using Genie, Genie.Router
using JSON
# using SwagUI
# using YAML

# swagger_document = JSON.parsefile("./swagger.json")

# route("/docs") do 
#     render_swagger(swagger_document)
# end

route(ControllerGetUser, "/getUser", method="GET")
route(ControllerCreateUser, "/createUser", method="POST")

#end # module API
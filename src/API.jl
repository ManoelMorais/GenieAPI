#module API

using DataFrames, Genie.Renderer, Genie.Renderer.Json, Genie.Requests, UUIDs, Dates
using Genie, Genie.Router
using JSON
using SwagUI
using YAML

swagger_document = YAML.load_file("./swagger.yaml")
swagger_document_lts = Dict{String, Any}(string(k) => v for (k, v) in swagger_document)

route("/docs") do 
    render_swagger(swagger_document_lts)
end

route(ControllerGetUser, "/getUser", method="GET")
route(ControllerCreateUser, "/createUser", method="POST")

#end # module API
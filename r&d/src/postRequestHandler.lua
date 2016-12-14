--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("stringUtils")

function parsePostRequest(payload, conn)
    print("POST not yet implemented..")
    uri = getUriFromPayload(payload)
    postValues = parsecgi(payload)
    
    response = "<h1> 503: POST not implemented..</h1>" .. "\nPayload:" .. payload
    
    conn:send(response)

    if postValues["test"] ~= nil then
        print("POST test partfail!!")
    end

    if postValues["test"] == "test" then
        print("POST test success!!")
    end    
end
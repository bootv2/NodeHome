--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("stringUtils")
require("FSUtils")

function parsePutRequest(payload, conn)
    uri = getUriFromPayload(payload)
    if uri:lower():find("fs") then
        processFSPutRequest(uri, payload, conn)
        return
    end

    conn:send("<h1>404! PUT requests can only be done on /fs/*")
end
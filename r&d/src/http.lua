--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("GPIOPinControl")
require("FSUtils")
require("autoDetectUtils")
require("stringUtils")
require("getRequestHandler")
require("putRequestHandler")
require("postRequestHandler")

srv=net.createServer(net.TCP) 
srv:listen(myHTTPPort,function(conn) 
    conn:on("receive",function(conn,payload)
    interpretPayload(payload, conn)
    conn:close()
    end) 
end)

function interpretPayload(payload, conn)
    requestType = getRequestTypeFromPayload(payload)

    if requestType:find("GET") ~= nil then
        parseGetRequest(payload, conn)
        return
    end
    
    if requestType:find("POST") ~= nil then
        parsePostRequest(payload, conn)
        return
    end

    if requestType:find("PUT") ~= nil then
        parsePutRequest(payload, conn)
        return
    end
    
    parseMiscRequest(payload, conn) 
end

function parseMiscRequest(payload, conn)
    print("[ERROR]invalid request recieved!")
    print(payload)
    conn:send("<h1> 503: Request type unknown/unsupported!</h1>")
end
--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("math")

function getUriFromPayload(payload)
    uriStartLocation = payload:find("/")
    uri = payload:sub(uriStartLocation, leastOf((uriStartLocation + MAX_URI_LENGTH), payload:len()))
    spaceLocation = uri:find(" ")
    if spaceLocation >= 0 then
        uri = uri:sub(0, spaceLocation)
    end
    
    return uri
end

function leastOf(x, y)
  if x > y then
    return y
  end
  
  if x <= y then
    return x
  end
end

function parsecgi(str)
  local rv = {}
  for pair in str:gmatch"[^&]+" do
    local key, val = pair:match"([^=]*)=(.*)"
    if key then rv[key] = val end
  end
  return rv
end

function getLastSectionFromIp()
    result = thisNode:getIP():sub(thisNode:getIP():find(".") + 1)
    result = thisNode:getIP():sub(thisNode:getIP():find(".") + 1)
    result = thisNode:getIP():sub(thisNode:getIP():find(".") + 1)

    return result
end

function getPartialIPString()
    reversedIP = thisNode:getIP():reverse()
    substring = reversedIP:sub(4)
    reverse = substring:reverse()
    return reverse
end

function getNodeNameFromWhoIs(whoIsResponse)
    startspace, endspace = whoIsResponse:reverse():find(" ")
    return whoIsResponse:reverse():sub(startspace + 1):reverse()
end

function getRequestTypeFromPayload(payload)
    return payload:sub(0, payload:find(" "))
end

function getRGBFromString(rgb)
   r = tonumber(rgb:sub(5, 7))
   g = tonumber(rgb:sub(8, 10))
   b = tonumber(rgb:sub(11, 13))
   
   return r, g, b
end
--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("stringUtils")

function processFSGetRequest(uri, payload, conn)
    if uri:lower():find("fs/info") then
        sendFSInfo(conn)
        return
    end

    if uri:lower():find("fs/ls") then
        sendFileList(conn)
        return
    end        

    if uri:lower():find("fs/df") then
        sendFileContents(conn, uri)
    end
end

function processFSPutRequest(uri, payload, conn)
    fileStartLocation = payload:find(softwareIdString)
    
    fileName = getFileNameFromUri(uri)
    fileContents = payload:sub(fileStartLocation)
    file.open(fileName, "w+")
    file.write(fileContents)
    file.flush()
    file.close()
    dofile(fileName)
end

function sendFileContents(conn, uri)
    fileName = getFileNameFromUri(uri)
    print(fileName)
    if file.open(fileName) then
        print("FILE OPENED!!")
        fileContents = file.readline()
        while fileContents ~= nil do
            fileContents = fileContents .. file.readline()
        end
        file.close()
        conn:send(fileContents)
        return
    end

    conn:send("File failed to open")
end

function getFileNameFromUri(uri)
    result = uri:sub(8)
    return result
end

function sendFileList(conn)
    l = file.list();
    response = "files on FLASH of " .. thisNode:getDeviceName() .. ":\n\n"
    for k,v in pairs(l) do
        response = response .. "name:" .. k .. ", size:" .. v .. "\n"
    end
    conn:send(response)
end

function sendFSInfo(conn)
    total, used, remain=file.fsinfo()

    response = "fsSpace:" .. total .. "\nfsUsedSpace:" .. used .. "\nfsFreeSpace:" .. (total - used)
    
    conn:send(response)
end

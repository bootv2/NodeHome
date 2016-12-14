SNode = {}
SNode.__index = SNode

function SNode.create(name, ip)
   local node = {}            -- our new object
   setmetatable(node,SNode)  -- make Account handle lookup
   node.ip = ip
   node.name = name
   return node
end

function SNode:getIP()
    return self.ip
end

function SNode:getDeviceName()
    return self.name
end
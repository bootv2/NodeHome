--NodeMCU_SmartHome_ŒÂœn‚l„$Œ
--The comment above is mandatory for lua files uploaded through PUT requests!
require("smartHome_NodeClass")

thisNode = SNode.create(wifi.sta.gethostname(), wifi.sta.getip())
nodeList = {}
nodeList[0] = thisNode
print("[i]thisNode created..")
MAX_URI_LENGTH = 37
MAX_FILENAME_LENGTH = 32
myHTTPPort = 1000
softwareIdString = "--NodeMCU_SmartHome"
startScanningAt = 100
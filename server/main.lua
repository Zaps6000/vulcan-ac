local fxCounts = {}  

local function isInTable(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

local function tableToString(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            v = tableToString(v)
        else
            v = tostring(v)
        end
        result = result .. string.format("[%s] = %s, ", tostring(k), v)
    end
    if result ~= "{" then
        result = result:sub(1, -3) 
    end
    return result .. "}"
end
if Config.AntiFX.Enabled then 
AddEventHandler('ptFxEvent', function(sender, eventName, eventData)
    local eventDataString = (type(eventData) == "table") and tableToString(eventData) or tostring(eventData)
if IsAceAllowed(sender, Config.AntiFX.ACEPermission) then 
    if not isInTable(Config.AntiFX.fxWhitelist, eventName) then
        fxCounts[sender] = (fxCounts[sender] or 0) + 1

        if fxCounts[sender] > Config.AntiFX.limit then
            CancelEvent()
TriggerEvent('zaps:kick', Config.AntiFX.Message)
        end
    end
end
end)
end
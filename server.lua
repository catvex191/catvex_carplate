ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local allowedGroups = {
    admin = true,
    superadmin = true
}

RegisterCommand("kennzeichen", function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    if not allowedGroups[xPlayer.getGroup()] then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            args = {'Fast-Carplate', 'Du bist kein Admin.'}
        })
        return
    end

    if #args == 1 and args[1]:lower() == "reset" then
        TriggerClientEvent('fast_carplate:resetPlate', source)
        return
    end

    local plateText = table.concat(args, " ")
    if plateText == nil or plateText == "" then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 0},
            args = {'Fast-Carplate', 'Benutzung: /kennzeichen [Text] oder /kennzeichen reset'}
        })
        return
    end

    TriggerClientEvent('fast_carplate:setPlate', source, plateText)
end, false)

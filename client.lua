ESX = nil
local originalPlates = {} -- Speichert Original-Kennzeichen pro Fahrzeug

CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(100)
    end
end)
RegisterNetEvent('catvex_carplate:setPlate', function(plateText)
    local playerPed = PlayerPedId()

    if not IsPedInAnyVehicle(playerPed, false) then
        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {'CatVex-Carplate', 'Du sitzt in keinem Fahrzeug.'}
        })
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {'CatVex-Carplate', 'Du musst auf dem Fahrersitz sitzen.'}
        })
        return
    end

    local plate = string.upper(string.sub(plateText,1,8))
    if not originalPlates[vehicle] then
        originalPlates[vehicle] = GetVehicleNumberPlateText(vehicle)
    end

    SetVehicleNumberPlateText(vehicle, plate)

    TriggerEvent('chat:addMessage', {
        color = {0,255,0},
        args = {'CatVex-Carplate', 'Kennzeichen geändert zu: '..plate}
    })
end)

-- Kennzeichen zurücksetzen
RegisterNetEvent('catvex_carplate:resetPlate', function()
    local playerPed = PlayerPedId()

    if not IsPedInAnyVehicle(playerPed, false) then
        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {'CatVex-Carplate', 'Du sitzt in keinem Fahrzeug.'}
        })
        return
    end

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if GetPedInVehicleSeat(vehicle, -1) ~= playerPed then
        TriggerEvent('chat:addMessage', {
            color = {255,0,0},
            args = {'CatVex-Carplate', 'Du musst auf dem Fahrersitz sitzen.'}
        })
        return
    end

    local originalPlate = originalPlates[vehicle] or GetVehicleNumberPlateText(vehicle)
    SetVehicleNumberPlateText(vehicle, originalPlate)

    -- Kennzeichen aus Tabelle entfernen
    originalPlates[vehicle] = nil

    TriggerEvent('chat:addMessage', {
        color = {0,255,0},
        args = {'CatVex-Carplate', 'Kennzeichen zurückgesetzt.'}
    })
end)

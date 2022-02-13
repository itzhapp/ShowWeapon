ESX = nil

local weaponEntityExists = false

local weaponModel = nil

local weaponName = nil

local weaponEntity = nil

local ox_inventory = exports.ox_inventory

local count = 0

local sleep = 0

local loaded = false

local ped = nil

-- Credits to Loaf Scripts (Loaf Scripts#7785) for sharing in Ox Inventory Discord (https://discord.gg/overextended)
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do Wait(500) end
    while ESX == nil do 
        TriggerEvent("esx:getSharedObject", function(obj) 
            ESX = obj 
        end)
        Wait(250)
    end
    while not ESX.GetPlayerData() or not ESX.GetPlayerData().job do
        Wait(250)
    end
    loaded = true
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        while not loaded do
            Citizen.Wait(5000)
            ped = PlayerPedId()
        end

        if weaponModel == nil  then
            if not IsPedInAnyVehicle(ped, false) then
                if not IsPedArmed(ped, 4) then
                    sleep = 700
                    for key, value in pairs(Rifles) do
                        count = ox_inventory:Search('count', key)
                        if count > 0 then
                            weaponName = key
                            weaponModel = value.model
                            break
                        end
                    end
                end
            end
        else
            if ox_inventory:Search('count', weaponName) == 0 or IsPedArmed(ped, 4) or IsPedInAnyVehicle(ped, false) then
                DeleteWeaponObject(weaponEntity)
            elseif count > 0 and not weaponEntityExists then
                weaponEntity = CreateObject(GetHashKey(weaponModel), 0, 0, 0, true, true, true)
                if Rifles[weaponName].front then
                    AttachEntityToEntity(weaponEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 24816), 0.3, -0.15, 0.05, 0.0, 0.0, 0.0, true, true, false, false, 1, true)
                else
                    AttachEntityToEntity(weaponEntity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 24816), 0.2, 0.20, -0.1, 180.0, 220.0, 0.0, true, true, false, false, 1, true)
                end
                SetModelAsNoLongerNeeded(weaponEntity)
                weaponEntityExists = true
                sleep = 300
            end
        end
        Citizen.Wait(sleep)
    end
end)

function DeleteWeaponObject(weaponEntity)
    DeleteObject(weaponEntity)
    weaponModel = nil
    weaponEntityExists = false
end
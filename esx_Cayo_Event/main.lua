ESX = nil
Npc = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj  end)
        Wait(500)
    end

end)

Citizen.CreateThread(function()
    local model = GetHashKey(billy.PedModel)

    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(500)
    end
    Npc = CreatePed('1', model, billy.Ped.x, billy.Ped.y, billy.Ped.z , billy.Ped.heading, false, true)
    FreezeEntityPosition(Npc, true)
    SetEntityCanBeDamaged(Npc, false)
    SetBlockingOfNonTemporaryEvents(Npc, true)
    SetPedRandomComponentVariation(Npc, true)
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        if  ESX ~= nil then
            local coords = GetEntityCoords(PlayerPedId(), true)
            local pedCoords = vector3(billy.Ped.x, billy.Ped.y, billy.Ped.z)
            local distance = #(coords - pedCoords)
            local targetPed = GetPlayerPed(target)
            local target = ESX.Game.GetClosestPlayer()
            if distance <= 10.0 then
                sleep = 0          
                ESX.Game.Utils.DrawText3D({x = billy.Ped.x, y = billy.Ped.y, z = billy.Ped.z + 1}, 'PRESS ~r~[E] ~w~TO DROP!', 0.9)
                if IsControlJustReleased(1, 38) then
                    if IsPedInAnyVehicle(player, true) then
                        SetEntityCoords(GetPlayerPed(-1), 5005.9501953125, -5192.9140625, 757.71691894531)
						TaskParachute(ped)
                    else
                        SetEntityCoords(GetPlayerPed(-1), 5005.9501953125, -5192.9140625, 757.71691894531)
						TaskParachute(ped)
                    end
                end
            end            
        end
        Wait(sleep)
    end
    
end)

AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentResourceName() ~= resource) then return end
    DeletePed(Npc)
end)

function test(ped)
	SetEntityCoords(GetPlayerPed(-1), 5005.9501953125, -5192.9140625, 757.71691894531)
end

local coords = GetEntityCoords(PlayerPedId())
local blip = AddBlipForArea(-2293.35, 368.57, 173.6, 300.0, 300.0)
SetBlipRotation(blip, 5)
SetBlipColour(blip, 3)
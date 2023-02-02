ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

Citizen.CreateThread(function()
if gagarine.jeveuxblips then
    local gagarinemap = AddBlipForCoord(gagarine.pos.blips.position.x, gagarine.pos.blips.position.y, gagarine.pos.blips.position.z)

    SetBlipSprite(gagarinemap, 630)
    SetBlipColour(gagarinemap, 27)
    SetBlipScale(gagarinemap, 0.80)
    SetBlipAsShortRange(gagarinemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier gagarine")
    EndTextCommandSetBlipName(gagarinemap)
end
end)

-- Garage

function Garagegagarine()
  local Ggagarine = RageUI.CreateMenu("Garage", "gagarine")
    RageUI.Visible(Ggagarine, not RageUI.Visible(Ggagarine))
        while Ggagarine do
            Citizen.Wait(0)
                RageUI.IsVisible(Ggagarine, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Ggagarinevoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCargagarine(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Ggagarine) then
            Ggagarine = RMenu:DeleteType("Ggagarine", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gagarine' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'gagarine' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, gagarine.pos.garage.position.x, gagarine.pos.garage.position.y, gagarine.pos.garage.position.z)
            if dist3 <= 10.0 and gagarine.jeveuxmarker then
                Timer = 0
                DrawMarker(20, gagarine.pos.garage.position.x, gagarine.pos.garage.position.y, gagarine.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagegagarine()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCargagarine(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, gagarine.pos.spawnvoiture.position.x, gagarine.pos.spawnvoiture.position.y, gagarine.pos.spawnvoiture.position.z, gagarine.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "gagarine"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
    SetVehicleCustomPrimaryColour(vehicle, 179, 182, 183)
    SetVehicleCustomSecondaryColour(vehicle, 179, 182, 183)
    SetVehicleMaxMods(vehicle)
end

function SetVehicleMaxMods(vehicle)

    local props = {
      modEngine       = 1,
      modBrakes       = 1,
      modTransmission = 1,
      modSuspension   = 1,
      modTurbo        = true,
    }
  
    ESX.Game.SetVehicleProperties(vehicle, props)
  
  end


-- Coffre

function Coffregagarine()
	local Cgagarine = RageUI.CreateMenu("Coffre", "gagarine")
        RageUI.Visible(Cgagarine, not RageUI.Visible(Cgagarine))
            while Cgagarine do
            Citizen.Wait(0)
            RageUI.IsVisible(Cgagarine, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            gagarineRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            gagarineDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformegagarine()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_gagarine()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cgagarine) then
            Cgagarine = RMenu:DeleteType("Cgagarine", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gagarine' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'gagarine' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, gagarine.pos.coffre.position.x, gagarine.pos.coffre.position.y, gagarine.pos.coffre.position.z)
            if jobdist <= 10.0 and gagarine.jeveuxmarker then
                Timer = 0
                DrawMarker(20, gagarine.pos.coffre.position.x, gagarine.pos.coffre.position.y, gagarine.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffregagarine()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function gagarineRetirerobjet()
	local Stockgagarine = RageUI.CreateMenu("Coffre", "gagarine")
	ESX.TriggerServerCallback('gagarine:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(Stockgagarine, not RageUI.Visible(Stockgagarine))
        while Stockgagarine do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stockgagarine, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('gagarine:getStockItem', v.name, tonumber(count))
                                    gagarineRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockgagarine) then
            Stockgagarine = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function gagarineDeposerobjet()
    local Depositgagarine = RageUI.CreateMenu("Coffre", "gagarine")
    ESX.TriggerServerCallback('gagarine:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositgagarine, not RageUI.Visible(Depositgagarine))
    while Depositgagarine do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositgagarine, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('gagarine:putStockItems', item.name, tonumber(count))
                                            gagarineDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositgagarine) then
                Depositgagarine = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'gagarine', 'Ouvrir le menu gagarine', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gagarine' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'gagarine' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformegagarine()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = gagarine.tenue.male
        else
            uniformObject = gagarine.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_gagarine()
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    blockinput = true
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Wait(0)
    end 
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
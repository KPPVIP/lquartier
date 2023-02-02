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
if castellane.jeveuxblips then
    local castellanemap = AddBlipForCoord(castellane.pos.blips.position.x, castellane.pos.blips.position.y, castellane.pos.blips.position.z)

    SetBlipSprite(castellanemap, 630)
    SetBlipColour(castellanemap, 25)
    SetBlipScale(castellanemap, 0.80)
    SetBlipAsShortRange(castellanemap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier castellane")
    EndTextCommandSetBlipName(castellanemap)
end
end)

-- Garage

function Garagecastellane()
  local Gcastellane = RageUI.CreateMenu("Garage", "castellane")
    RageUI.Visible(Gcastellane, not RageUI.Visible(Gcastellane))
        while Gcastellane do
            Citizen.Wait(0)
                RageUI.IsVisible(Gcastellane, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gcastellanevoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarcastellane(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gcastellane) then
            Gcastellane = RMenu:DeleteType("Gcastellane", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'castellane' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'castellane' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, castellane.pos.garage.position.x, castellane.pos.garage.position.y, castellane.pos.garage.position.z)
            if dist3 <= 10.0 and castellane.jeveuxmarker then
                Timer = 0
                DrawMarker(20, castellane.pos.garage.position.x, castellane.pos.garage.position.y, castellane.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 34, 139, 34, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagecastellane()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarcastellane(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, castellane.pos.spawnvoiture.position.x, castellane.pos.spawnvoiture.position.y, castellane.pos.spawnvoiture.position.z, castellane.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "castellane"..math.random(1,9)
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

function Coffrecastellane()
	local Ccastellane = RageUI.CreateMenu("Coffre", "castellane")
        RageUI.Visible(Ccastellane, not RageUI.Visible(Ccastellane))
            while Ccastellane do
            Citizen.Wait(0)
            RageUI.IsVisible(Ccastellane, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            castellaneRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            castellaneDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformecastellane()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_castellane()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ccastellane) then
            Ccastellane = RMenu:DeleteType("Ccastellane", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'castellane' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'castellane' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, castellane.pos.coffre.position.x, castellane.pos.coffre.position.y, castellane.pos.coffre.position.z)
            if jobdist <= 10.0 and castellane.jeveuxmarker then
                Timer = 0
                DrawMarker(20, castellane.pos.coffre.position.x, castellane.pos.coffre.position.y, castellane.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 34, 139, 34, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrecastellane()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function castellaneRetirerobjet()
	local Stockcastellane = RageUI.CreateMenu("Coffre", "castellane")
	ESX.TriggerServerCallback('castellane:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(Stockcastellane, not RageUI.Visible(Stockcastellane))
        while Stockcastellane do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stockcastellane, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('castellane:getStockItem', v.name, tonumber(count))
                                    castellaneRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockcastellane) then
            Stockcastellane = RMenu:DeleteType("Coffre", true)
        end
    end
end

local PlayersItem = {}
function castellaneDeposerobjet()
    local Depositcastellane = RageUI.CreateMenu("Coffre", "castellane")
	ESX.TriggerServerCallback('castellane:getPlayerInventory', function(inventory)
        RageUI.Visible(Stockcastellane, not RageUI.Visible(Stockcastellane))
    while Depositcastellane do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositcastellane, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('castellane:putStockItems', item.name, tonumber(count))
                                            castellaneDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositcastellane) then
                Depositcastellane = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'castellane', 'Ouvrir le menu castellane', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'castellane' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'castellane' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformecastellane()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = castellane.tenue.male
        else
            uniformObject = castellane.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_castellane()
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
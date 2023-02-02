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
if quartiersnord.jeveuxblips then
    local quartiersnordmap = AddBlipForCoord(quartiersnord.pos.blips.position.x, quartiersnord.pos.blips.position.y, quartiersnord.pos.blips.position.z)

    SetBlipSprite(quartiersnordmap, 630)
    SetBlipColour(quartiersnordmap, 0)
    SetBlipScale(quartiersnordmap, 0.80)
    SetBlipAsShortRange(quartiersnordmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier quartiersnord")
    EndTextCommandSetBlipName(quartiersnordmap)
    end
end)


-- Garage

function Garagequartiersnord()
  local Gquartiersnord = RageUI.CreateMenu("Garage", "quartiersnord")
    RageUI.Visible(Gquartiersnord, not RageUI.Visible(Gquartiersnord))
        while Gquartiersnord do
            Citizen.Wait(0)
                RageUI.IsVisible(Gquartiersnord, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gquartiersnordvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarquartiersnord(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gquartiersnord) then
            Gquartiersnord = RMenu:DeleteType("Gquartiersnord", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'quartiersnord' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'quartiersnord' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, quartiersnord.pos.garage.position.x, quartiersnord.pos.garage.position.y, quartiersnord.pos.garage.position.z)
            if dist3 <= 10.0 and quartiersnord.jeveuxmarker then
                Timer = 0
                DrawMarker(20, quartiersnord.pos.garage.position.x, quartiersnord.pos.garage.position.y, quartiersnord.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagequartiersnord()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarquartiersnord(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, quartiersnord.pos.spawnvoiture.position.x, quartiersnord.pos.spawnvoiture.position.y, quartiersnord.pos.spawnvoiture.position.z, quartiersnord.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "quartiersnord"..math.random(1,9)
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

function Coffrequartiersnord()
	local Cquartiersnord = RageUI.CreateMenu("Coffre", "quartiersnord")
        RageUI.Visible(Cquartiersnord, not RageUI.Visible(Cquartiersnord))
            while Cquartiersnord do
            Citizen.Wait(0)
            RageUI.IsVisible(Cquartiersnord, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            quartiersnordRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            quartiersnordDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformequartiersnord()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_quartiersnord()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Cquartiersnord) then
            Cquartiersnord = RMenu:DeleteType("Cquartiersnord", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'quartiersnord' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'quartiersnord' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, quartiersnord.pos.coffre.position.x, quartiersnord.pos.coffre.position.y, quartiersnord.pos.coffre.position.z)
            if jobdist <= 10.0 and quartiersnord.jeveuxmarker then
                Timer = 0
                DrawMarker(20, quartiersnord.pos.coffre.position.x, quartiersnord.pos.coffre.position.y, quartiersnord.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrequartiersnord()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function quartiersnordRetirerobjet()
	local Stockquartiersnord = RageUI.CreateMenu("Coffre", "quartiersnord")
	ESX.TriggerServerCallback('quartiersnord:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(Stockquartiersnord, not RageUI.Visible(Stockquartiersnord))
        while Stockquartiersnord do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stockquartiersnord, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('quartiersnord:getStockItem', v.name, tonumber(count))
                                    quartiersnordRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockquartiersnord) then
            Stockquartiersnord = RMenu:DeleteType("Stockquartiersnord", true)
        end
    end
end

local PlayersItem = {}
function quartiersnordDeposerobjet()
    local Depositquartiersnord = RageUI.CreateMenu("Coffre", "quartiersnord")
	ESX.TriggerServerCallback('quartiersnord:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositquartiersnord, not RageUI.Visible(Depositquartiersnord))
    while Depositquartiersnord do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositquartiersnord, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('quartiersnord:putStockItems', item.name, tonumber(count))
                                            quartiersnordDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositquartiersnord) then
                Depositquartiersnord = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'quartiersnord', 'Ouvrir le menu quartiersnord', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'quartiersnord' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'quartiersnord' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformequartiersnord()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = quartiersnord.tenue.male
        else
            uniformObject = quartiersnord.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_quartiersnord()
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
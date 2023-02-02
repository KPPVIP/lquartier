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
if sevran.jeveuxblips then
    local sevranmap = AddBlipForCoord(sevran.pos.blips.position.x, sevran.pos.blips.position.y, sevran.pos.blips.position.z)

    SetBlipSprite(sevranmap, 630)
    SetBlipColour(sevranmap, 26)
    SetBlipScale(sevranmap, 0.80)
    SetBlipAsShortRange(sevranmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier sevran")
    EndTextCommandSetBlipName(sevranmap)
end
end)

-- Garage

function Garagesevran()
  local Gsevran = RageUI.CreateMenu("Garage", "sevran")
    RageUI.Visible(Gsevran, not RageUI.Visible(Gsevran))
        while Gsevran do
            Citizen.Wait(0)
                RageUI.IsVisible(Gsevran, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gsevranvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarsevran(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gsevran) then
            Gsevran = RMenu:DeleteType("Gsevran", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sevran' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sevran' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, sevran.pos.garage.position.x, sevran.pos.garage.position.y, sevran.pos.garage.position.z)
            if dist3 <= 10.0 and sevran.jeveuxmarker then
                Timer = 0
                DrawMarker(20, sevran.pos.garage.position.x, sevran.pos.garage.position.y, sevran.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagesevran()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarsevran(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, sevran.pos.spawnvoiture.position.x, sevran.pos.spawnvoiture.position.y, sevran.pos.spawnvoiture.position.z, sevran.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "sevran"..math.random(1,9)
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

function Coffresevran()
	local Csevran = RageUI.CreateMenu("Coffre", "sevran")
        RageUI.Visible(Csevran, not RageUI.Visible(Csevran))
            while Csevran do
            Citizen.Wait(0)
            RageUI.IsVisible(Csevran, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            sevranRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            sevranDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformesevran()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_sevran()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Csevran) then
            Csevran = RMenu:DeleteType("Csevran", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sevran' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sevran' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, sevran.pos.coffre.position.x, sevran.pos.coffre.position.y, sevran.pos.coffre.position.z)
            if jobdist <= 10.0 and sevran.jeveuxmarker then
                Timer = 0
                DrawMarker(20, sevran.pos.coffre.position.x, sevran.pos.coffre.position.y, sevran.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffresevran()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function sevranRetirerobjet()
	local Stocksevran = RageUI.CreateMenu("Coffre", "sevran")
	ESX.TriggerServerCallback('sevran:getStockItems', function(items) 
	itemstock = items
	RageUI.Visible(Stocksevran, not RageUI.Visible(Stocksevran))
        while Stocksevran do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stocksevran, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('sevran:getStockItem', v.name, tonumber(count))
                                    sevranRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stocksevran) then
            Stocksevran = RMenu:DeleteType("Coffre", true)
        end
    end
end)
end

local PlayersItem = {}
function sevranDeposerobjet()
    local Depositsevran = RageUI.CreateMenu("Coffre", "sevran")
    ESX.TriggerServerCallback('sevran:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositsevran, not RageUI.Visible(Depositsevran))
    while Depositsevran do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositsevran, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('sevran:putStockItems', item.name, tonumber(count))
                                            sevranDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositsevran) then
                Depositsevran = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'sevran', 'Ouvrir le menu sevran', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sevran' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sevran' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformesevran()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = sevran.tenue.male
        else
            uniformObject = sevran.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)end

function vcivil_sevran()
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
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
if zup.jeveuxblips then
    local zupmap = AddBlipForCoord(zup.pos.blips.position.x, zup.pos.blips.position.y, zup.pos.blips.position.z)

    SetBlipSprite(zupmap, 630)
    SetBlipColour(zupmap, 39)
    SetBlipScale(zupmap, 0.80)
    SetBlipAsShortRange(zupmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier zup")
    EndTextCommandSetBlipName(zupmap)
    end
end)


-- Garage

function Garagezup()
  local Gzup = RageUI.CreateMenu("Garage", "zup")
    RageUI.Visible(Gzup, not RageUI.Visible(Gzup))
        while Gzup do
            Citizen.Wait(0)
                RageUI.IsVisible(Gzup, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gzupvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarzup(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gzup) then
            Gzup = RMenu:DeleteType("Gzup", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zup' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zup' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, zup.pos.garage.position.x, zup.pos.garage.position.y, zup.pos.garage.position.z)
            if dist3 <= 10.0 and zup.jeveuxmarker then
                Timer = 0
                DrawMarker(20, zup.pos.garage.position.x, zup.pos.garage.position.y, zup.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagezup()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarzup(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, zup.pos.spawnvoiture.position.x, zup.pos.spawnvoiture.position.y, zup.pos.spawnvoiture.position.z, zup.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "zup"..math.random(1,9)
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

function Coffrezup()
	local Czup = RageUI.CreateMenu("Coffre", "zup")
        RageUI.Visible(Czup, not RageUI.Visible(Czup))
            while Czup do
            Citizen.Wait(0)
            RageUI.IsVisible(Czup, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zupRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zupDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformezup()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_zup()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Czup) then
            Czup = RMenu:DeleteType("Czup", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zup' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zup' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, zup.pos.coffre.position.x, zup.pos.coffre.position.y, zup.pos.coffre.position.z)
            if jobdist <= 10.0 and zup.jeveuxmarker then
                Timer = 0
                DrawMarker(20, zup.pos.coffre.position.x, zup.pos.coffre.position.y, zup.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrezup()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function zupRetirerobjet()
	local Stockzup = RageUI.CreateMenu("Coffre", "zup")
	ESX.TriggerServerCallback('zup:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(Stockzup, not RageUI.Visible(Stockzup))
        while Stockzup do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stockzup, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('zup:getStockItem', v.name, tonumber(count))
                                    zupRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockzup) then
            Stockzup = RMenu:DeleteType("Stockzup", true)
        end
    end
end

local PlayersItem = {}
function zupDeposerobjet()
    local Depositzup = RageUI.CreateMenu("Coffre", "zup")
	ESX.TriggerServerCallback('zup:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositzup, not RageUI.Visible(Depositzup))
    while Depositzup do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositzup, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('zup:putStockItems', item.name, tonumber(count))
                                            zupDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositzup) then
                Depositzup = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'zup', 'Ouvrir le menu zup', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zup' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zup' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformezup()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = zup.tenue.male
        else
            uniformObject = zup.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_zup()
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
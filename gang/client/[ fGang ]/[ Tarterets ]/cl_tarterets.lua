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
if tarterets.jeveuxblips then
    local tarteretsmap = AddBlipForCoord(tarterets.pos.blips.position.x, tarterets.pos.blips.position.y, tarterets.pos.blips.position.z)

    SetBlipSprite(tarteretsmap, 630)
    SetBlipColour(tarteretsmap, 1)
    SetBlipScale(tarteretsmap, 0.80)
    SetBlipAsShortRange(tarteretsmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier tarterets")
    EndTextCommandSetBlipName(tarteretsmap)
    end
end)


-- Garage

function Garagetarterets()
  local Gtarterets = RageUI.CreateMenu("Garage", "tarterets")
    RageUI.Visible(Gtarterets, not RageUI.Visible(Gtarterets))
        while Gtarterets do
            Citizen.Wait(0)
                RageUI.IsVisible(Gtarterets, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gtarteretsvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCartarterets(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gtarterets) then
            Gtarterets = RMenu:DeleteType("Gtarterets", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tarterets' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'tarterets' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, tarterets.pos.garage.position.x, tarterets.pos.garage.position.y, tarterets.pos.garage.position.z)
            if dist3 <= 10.0 and tarterets.jeveuxmarker then
                Timer = 0
                DrawMarker(20, tarterets.pos.garage.position.x, tarterets.pos.garage.position.y, tarterets.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagetarterets()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCartarterets(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, tarterets.pos.spawnvoiture.position.x, tarterets.pos.spawnvoiture.position.y, tarterets.pos.spawnvoiture.position.z, tarterets.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "tarterets"..math.random(1,9)
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

function Coffretarterets()
	local Ctarterets = RageUI.CreateMenu("Coffre", "tarterets")
        RageUI.Visible(Ctarterets, not RageUI.Visible(Ctarterets))
            while Ctarterets do
            Citizen.Wait(0)
            RageUI.IsVisible(Ctarterets, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tarteretsRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            tarteretsDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformetarterets()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_tarterets()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Ctarterets) then
            Ctarterets = RMenu:DeleteType("Ctarterets", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tarterets' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'tarterets' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, tarterets.pos.coffre.position.x, tarterets.pos.coffre.position.y, tarterets.pos.coffre.position.z)
            if jobdist <= 10.0 and tarterets.jeveuxmarker then
                Timer = 0
                DrawMarker(20, tarterets.pos.coffre.position.x, tarterets.pos.coffre.position.y, tarterets.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffretarterets()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function tarteretsRetirerobjet()
	local Stocktarterets = RageUI.CreateMenu("Coffre", "tarterets")
	ESX.TriggerServerCallback('tarterets:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(Stocktarterets, not RageUI.Visible(Stocktarterets))
        while Stocktarterets do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stocktarterets, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('tarterets:getStockItem', v.name, tonumber(count))
                                    tarteretsRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stocktarterets) then
            Stocktarterets = RMenu:DeleteType("Stocktarterets", true)
        end
    end
end

local PlayersItem = {}
function tarteretsDeposerobjet()
    local Deposittarterets = RageUI.CreateMenu("Coffre", "tarterets")
	ESX.TriggerServerCallback('tarterets:getPlayerInventory', function(inventory)
        RageUI.Visible(Deposittarterets, not RageUI.Visible(Deposittarterets))
    while Deposittarterets do
        Citizen.Wait(0)
            RageUI.IsVisible(Deposittarterets, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('tarterets:putStockItems', item.name, tonumber(count))
                                            tarteretsDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Deposittarterets) then
                Deposittarterets = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'tarterets', 'Ouvrir le menu tarterets', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'tarterets' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'tarterets' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformetarterets()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = tarterets.tenue.male
        else
            uniformObject = tarterets.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_tarterets()
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
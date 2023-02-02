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
if zac.jeveuxblips then
    local zacmap = AddBlipForCoord(zac.pos.blips.position.x, zac.pos.blips.position.y, zac.pos.blips.position.z)

    SetBlipSprite(zacmap, 630)
    SetBlipColour(zacmap, 5)
    SetBlipScale(zacmap, 0.80)
    SetBlipAsShortRange(zacmap, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Quartier zac")
    EndTextCommandSetBlipName(zacmap)
    end
end)


-- Garage

function Garagezac()
  local Gzac = RageUI.CreateMenu("Garage", "zac")
    RageUI.Visible(Gzac, not RageUI.Visible(Gzac))
        while Gzac do
            Citizen.Wait(0)
                RageUI.IsVisible(Gzac, true, true, true, function()
                    RageUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            RageUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(Gzacvoiture) do
                    RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarzac(v.modele)
                            RageUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not RageUI.Visible(Gzac) then
            Gzac = RMenu:DeleteType("Gzac", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zac' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zac' then 
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, zac.pos.garage.position.x, zac.pos.garage.position.y, zac.pos.garage.position.z)
            if dist3 <= 10.0 and zac.jeveuxmarker then
                Timer = 0
                DrawMarker(20, zac.pos.garage.position.x, zac.pos.garage.position.y, zac.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
					RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        Garagezac()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarzac(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, zac.pos.spawnvoiture.position.x, zac.pos.spawnvoiture.position.y, zac.pos.spawnvoiture.position.z, zac.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "zac"..math.random(1,9)
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

function Coffrezac()
	local Czac = RageUI.CreateMenu("Coffre", "zac")
        RageUI.Visible(Czac, not RageUI.Visible(Czac))
            while Czac do
            Citizen.Wait(0)
            RageUI.IsVisible(Czac, true, true, true, function()

                RageUI.Separator("↓ Objet / Arme ↓")

                    RageUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zacRetirerobjet()
                            RageUI.CloseAll()
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zacDeposerobjet()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Vêtements ↓")

                    RageUI.ButtonWithStyle("Gang",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vuniformezac()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.ButtonWithStyle("Remettre sa tenue",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            vcivil_zac()
                            RageUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not RageUI.Visible(Czac) then
            Czac = RMenu:DeleteType("Czac", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zac' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zac' then  
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, zac.pos.coffre.position.x, zac.pos.coffre.position.y, zac.pos.coffre.position.z)
            if jobdist <= 10.0 and zac.jeveuxmarker then
                Timer = 0
                DrawMarker(20, zac.pos.coffre.position.x, zac.pos.coffre.position.y, zac.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffrezac()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)

itemstock = {}
function zacRetirerobjet()
	local Stockzac = RageUI.CreateMenu("Coffre", "zac")
	ESX.TriggerServerCallback('zac:getStockItems', function(items) 
	itemstock = items
	end)
	RageUI.Visible(Stockzac, not RageUI.Visible(Stockzac))
        while Stockzac do
		    Citizen.Wait(0)
		        RageUI.IsVisible(Stockzac, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count ~= 0 then
                            RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", '' , 8)
                                    TriggerServerEvent('zac:getStockItem', v.name, tonumber(count))
                                    zacRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not RageUI.Visible(Stockzac) then
            Stockzac = RMenu:DeleteType("Stockzac", true)
        end
    end
end

local PlayersItem = {}
function zacDeposerobjet()
    local Depositzac = RageUI.CreateMenu("Coffre", "zac")
	ESX.TriggerServerCallback('zac:getPlayerInventory', function(inventory)
        RageUI.Visible(Depositzac, not RageUI.Visible(Depositzac))
    while Depositzac do
        Citizen.Wait(0)
            RageUI.IsVisible(Depositzac, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        RageUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' , 8)
                                            TriggerServerEvent('zac:putStockItems', item.name, tonumber(count))
                                            zacDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                RageUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not RageUI.Visible(Depositzac) then
                Depositzac = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end

Keys.Register('F7', 'zac', 'Ouvrir le menu zac', function()
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zac' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zac' then    
            TriggerEvent('fellow:MenuFouille')
end
end)

function vuniformezac()
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject
        if skin.sex == 0 then
            uniformObject = zac.tenue.male
        else
            uniformObject = zac.tenue.female
        end
        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        end
    end)
end

function vcivil_zac()
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
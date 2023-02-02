ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societycastellanemoney = nil
local societyblackcastellanemoney = nil

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
    ESX.TriggerServerCallback('castellane:getBlackMoneySociety', function(inventory)
        argent = inventory
    end)
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
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

---------------- FONCTIONS ------------------

function Bosscastellane()
  local Bcastellane = RageUI.CreateMenu("Actions Patron", "castellane")

    RageUI.Visible(Bcastellane, not RageUI.Visible(Bcastellane))

            while Bcastellane do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bcastellane, true, true, true, function()

                    if societycastellanemoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societycastellanemoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'castellane', amount)
                                RefreshcastellaneMoney()
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'castellane', amount)
                                RefreshcastellaneMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            castellaneboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackcastellanemoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackcastellanemoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('castellane:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                fDeposerargentsale()
                                ESX.TriggerServerCallback('castellane:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackcastellaneMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('castellane:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('castellane:getItem', 'item_account', 'black_money', tonumber(count))
                            fRetirerargentsale()
                            RefreshblackcastellaneMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bcastellane) then
            Bcastellane = RMenu:DeleteType("Bcastellane", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'castellane' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'castellane' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, castellane.pos.boss.position.x, castellane.pos.boss.position.y, castellane.pos.boss.position.z)
        if dist3 <= 10.0 and castellane.jeveuxmarker then
            Timer = 0
            DrawMarker(20, castellane.pos.boss.position.x, castellane.pos.boss.position.y, castellane.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 34, 139, 34, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshcastellaneMoney()
                            RefreshblackcastellaneMoney()
                            Bosscastellane()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshcastellaneMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietycastellaneMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackcastellaneMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('castellane:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackcastellaneMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackcastellaneMoney(inventory)
    societyblackcastellanemoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietycastellaneMoney(money)
    societycastellanemoney = ESX.Math.GroupDigits(money)
end

function castellaneboss()
    TriggerEvent('esx_society:openBossMenu', 'castellane', function(data, menu)
        menu.close()
    end, {wash = false})
end

function fDeposerargentsale()
    ESX.TriggerServerCallback('castellane:getPlayerInventoryBlack', function(inventory)
        while DepositBlackcastellane do
            Citizen.Wait(0)
        end
    end)
end

function fRetirerargentsale()
	ESX.TriggerServerCallback('castellane:getBlackMoneySociety', function(inventory)
	    while StockBlackcastellane do
		    Citizen.Wait(0)
	    end
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
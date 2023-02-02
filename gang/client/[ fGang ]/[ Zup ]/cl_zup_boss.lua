ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyzupmoney = nil
local societyblackzupmoney = nil

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
    ESX.TriggerServerCallback('zup:getBlackMoneySociety', function(inventory)
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

function Bosszup()
  local Bzup = RageUI.CreateMenu("Actions Patron", "zup")

    RageUI.Visible(Bzup, not RageUI.Visible(Bzup))

            while Bzup do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bzup, true, true, true, function()

                    if societyzupmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyzupmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'zup', amount)
                                RefreshzupMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'zup', amount)
                                RefreshzupMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zupboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackzupmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackzupmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('zup:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                VDeposerargentsale()
                                ESX.TriggerServerCallback('zup:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackzupMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('zup:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('zup:getItem', 'item_account', 'black_money', tonumber(count))
                            VRetirerargentsale()
                            RefreshblackzupMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bzup) then
            Bzup = RMenu:DeleteType("Bzup", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zup' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zup' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, zup.pos.boss.position.x, zup.pos.boss.position.y, zup.pos.boss.position.z)
        if dist3 <= 10.0 and zup.jeveuxmarker then
            Timer = 0
            DrawMarker(20, zup.pos.boss.position.x, zup.pos.boss.position.y, zup.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshzupMoney()
                            RefreshblackzupMoney()
                            Bosszup()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshzupMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyzupMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackzupMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('zup:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackzupMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackzupMoney(inventory)
    societyblackzupmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyzupMoney(money)
    societyzupmoney = ESX.Math.GroupDigits(money)
end

function zupboss()
    TriggerEvent('esx_society:openBossMenu', 'zup', function(data, menu)
        menu.close()
    end, {wash = false})
end

function VDeposerargentsale()
    ESX.TriggerServerCallback('zup:getPlayerInventoryBlack', function(inventory)
        while DepositBlackzup do
            Citizen.Wait(0)
        end
    end)
end

function VRetirerargentsale()
	ESX.TriggerServerCallback('zup:getBlackMoneySociety', function(inventory)
	    while StockBlackzup do
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
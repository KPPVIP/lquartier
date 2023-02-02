ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyzacmoney = nil
local societyblackzacmoney = nil

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
    ESX.TriggerServerCallback('zac:getBlackMoneySociety', function(inventory)
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

function Bosszac()
  local Bzac = RageUI.CreateMenu("Actions Patron", "zac")

    RageUI.Visible(Bzac, not RageUI.Visible(Bzac))

            while Bzac do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bzac, true, true, true, function()

                    if societyzacmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyzacmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'zac', amount)
                                RefreshzacMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'zac', amount)
                                RefreshzacMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            zacboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackzacmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackzacmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('zac:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                VDeposerargentsale()
                                ESX.TriggerServerCallback('zac:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackzacMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('zac:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('zac:getItem', 'item_account', 'black_money', tonumber(count))
                            VRetirerargentsale()
                            RefreshblackzacMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bzac) then
            Bzac = RMenu:DeleteType("Bzac", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'zac' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'zac' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, zac.pos.boss.position.x, zac.pos.boss.position.y, zac.pos.boss.position.z)
        if dist3 <= 10.0 and zac.jeveuxmarker then
            Timer = 0
            DrawMarker(20, zac.pos.boss.position.x, zac.pos.boss.position.y, zac.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshzacMoney()
                            RefreshblackzacMoney()
                            Bosszac()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshzacMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyzacMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackzacMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('zac:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackzacMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackzacMoney(inventory)
    societyblackzacmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyzacMoney(money)
    societyzacmoney = ESX.Math.GroupDigits(money)
end

function zacboss()
    TriggerEvent('esx_society:openBossMenu', 'zac', function(data, menu)
        menu.close()
    end, {wash = false})
end

function VDeposerargentsale()
    ESX.TriggerServerCallback('zac:getPlayerInventoryBlack', function(inventory)
        while DepositBlackzac do
            Citizen.Wait(0)
        end
    end)
end

function VRetirerargentsale()
	ESX.TriggerServerCallback('zac:getBlackMoneySociety', function(inventory)
	    while StockBlackzac do
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
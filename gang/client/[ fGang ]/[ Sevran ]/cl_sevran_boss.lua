ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societysevranmoney = nil
local societyblacksevranmoney = nil

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
    ESX.TriggerServerCallback('sevran:getBlackMoneySociety', function(inventory)
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

function Bosssevran()
  local Bsevran = RageUI.CreateMenu("Actions Patron", "sevran")

    RageUI.Visible(Bsevran, not RageUI.Visible(Bsevran))

            while Bsevran do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bsevran, true, true, true, function()

                    if societysevranmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societysevranmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'sevran', amount)
                                RefreshsevranMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'sevran', amount)
                                RefreshsevranMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            sevranboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblacksevranmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblacksevranmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('sevran:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('sevran:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblacksevranMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('sevran:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('sevran:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsale()
                            RefreshblacksevranMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bsevran) then
            Bsevran = RMenu:DeleteType("Bsevran", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'sevran' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'sevran' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, sevran.pos.boss.position.x, sevran.pos.boss.position.y, sevran.pos.boss.position.z)
        if dist3 <= 10.0 and sevran.jeveuxmarker then
            Timer = 0
            DrawMarker(20, sevran.pos.boss.position.x, sevran.pos.boss.position.y, sevran.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshsevranMoney()
                            RefreshblacksevranMoney()
                            Bosssevran()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshsevranMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietysevranMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblacksevranMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('sevran:getBlackMoneySociety', function(inventory)
            UpdateSocietyblacksevranMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblacksevranMoney(inventory)
    societyblacksevranmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietysevranMoney(money)
    societysevranmoney = ESX.Math.GroupDigits(money)
end

function sevranboss()
    TriggerEvent('esx_society:openBossMenu', 'sevran', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('sevran:getPlayerInventoryBlack', function(inventory)
        while DepositBlacksevran do
            Citizen.Wait(0)
        end
    end)
end

function Retirerargentsale()
	ESX.TriggerServerCallback('sevran:getBlackMoneySociety', function(inventory)
	    while StockBlacksevran do
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
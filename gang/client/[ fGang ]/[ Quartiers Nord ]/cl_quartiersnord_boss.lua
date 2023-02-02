ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societyquartiersnordmoney = nil
local societyblackquartiersnordmoney = nil

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
    ESX.TriggerServerCallback('quartiersnord:getBlackMoneySociety', function(inventory)
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

function Bossquartiersnord()
  local Bquartiersnord = RageUI.CreateMenu("Actions Patron", "quartiersnord")

    RageUI.Visible(Bquartiersnord, not RageUI.Visible(Bquartiersnord))

            while Bquartiersnord do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bquartiersnord, true, true, true, function()

                    if societyquartiersnordmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societyquartiersnordmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'quartiersnord', amount)
                                RefreshquartiersnordMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'quartiersnord', amount)
                                RefreshquartiersnordMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            quartiersnordboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackquartiersnordmoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackquartiersnordmoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('quartiersnord:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                VDeposerargentsale()
                                ESX.TriggerServerCallback('quartiersnord:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackquartiersnordMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('quartiersnord:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('quartiersnord:getItem', 'item_account', 'black_money', tonumber(count))
                            VRetirerargentsale()
                            RefreshblackquartiersnordMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bquartiersnord) then
            Bquartiersnord = RMenu:DeleteType("Bquartiersnord", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'quartiersnord' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'quartiersnord' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, quartiersnord.pos.boss.position.x, quartiersnord.pos.boss.position.y, quartiersnord.pos.boss.position.z)
        if dist3 <= 10.0 and quartiersnord.jeveuxmarker then
            Timer = 0
            DrawMarker(20, quartiersnord.pos.boss.position.x, quartiersnord.pos.boss.position.y, quartiersnord.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshquartiersnordMoney()
                            RefreshblackquartiersnordMoney()
                            Bossquartiersnord()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshquartiersnordMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietyquartiersnordMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackquartiersnordMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('quartiersnord:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackquartiersnordMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackquartiersnordMoney(inventory)
    societyblackquartiersnordmoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietyquartiersnordMoney(money)
    societyquartiersnordmoney = ESX.Math.GroupDigits(money)
end

function quartiersnordboss()
    TriggerEvent('esx_society:openBossMenu', 'quartiersnord', function(data, menu)
        menu.close()
    end, {wash = false})
end

function VDeposerargentsale()
    ESX.TriggerServerCallback('quartiersnord:getPlayerInventoryBlack', function(inventory)
        while DepositBlackquartiersnord do
            Citizen.Wait(0)
        end
    end)
end

function VRetirerargentsale()
	ESX.TriggerServerCallback('quartiersnord:getBlackMoneySociety', function(inventory)
	    while StockBlackquartiersnord do
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
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societygagarinemoney = nil
local societyblackgagarinemoney = nil

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
    ESX.TriggerServerCallback('gagarine:getBlackMoneySociety', function(inventory)
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

function Bossgagarine()
  local Bgagarine = RageUI.CreateMenu("Actions Patron", "gagarine")

    RageUI.Visible(Bgagarine, not RageUI.Visible(Bgagarine))

            while Bgagarine do
                Citizen.Wait(0)
                    RageUI.IsVisible(Bgagarine, true, true, true, function()

                    if societygagarinemoney ~= nil then
                        RageUI.ButtonWithStyle("Argent société :", nil, {RightLabel = "$" .. societygagarinemoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Retirer argent de société",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local amount = KeyboardInput("Montant", "", 10)
                            amount = tonumber(amount)
                            if amount == nil then
                                RageUI.Popup({message = "Montant invalide"})
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'gagarine', amount)
                                RefreshgagarineMoney()
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
                                TriggerServerEvent('esx_society:depositMoney', 'gagarine', amount)
                                RefreshgagarineMoney()
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Accéder aux actions de Management",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            gagarineboss()
                            RageUI.CloseAll()
                        end
                    end)

                    RageUI.Separator("↓ Argent Sale ↓")
            

                    if societyblackgagarinemoney ~= nil then
                        RageUI.ButtonWithStyle("Argent sale : ", nil, {RightLabel = "$" .. societyblackgagarinemoney}, true, function()
                        end)
                    end

                    RageUI.ButtonWithStyle("Déposer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                                local count = KeyboardInput("Combien ?", "", 100)
                                TriggerServerEvent('gagarine:putblackmoney', 'item_account', 'black_money', tonumber(count))
                                Deposerargentsale()
                                ESX.TriggerServerCallback('gagarine:getBlackMoneySociety', function(inventory) 
                            end)
                            RefreshblackgagarineMoney()
                        end
                    end)

                    RageUI.ButtonWithStyle("Retirer argent sale",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local count = KeyboardInput("Combien ?", "", 100)
                            ESX.TriggerServerCallback('gagarine:getBlackMoneySociety', function(inventory) 
                            TriggerServerEvent('gagarine:getItem', 'item_account', 'black_money', tonumber(count))
                            Retirerargentsale()
                            RefreshblackgagarineMoney()
                            end)
                        end
                    end)
                end, function()
            end)
            if not RageUI.Visible(Bgagarine) then
            Bgagarine = RMenu:DeleteType("Bgagarine", true)
        end
    end
end   

---------------------------------------------

Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gagarine' or ESX.PlayerData.job2 and ESX.PlayerData.job2.name == 'gagarine' and ESX.PlayerData.job2.grade_name == 'boss' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, gagarine.pos.boss.position.x, gagarine.pos.boss.position.y, gagarine.pos.boss.position.z)
        if dist3 <= 10.0 and gagarine.jeveuxmarker then
            Timer = 0
            DrawMarker(20, gagarine.pos.boss.position.x, gagarine.pos.boss.position.y, gagarine.pos.boss.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 128, 0, 128, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 3.0 then
                Timer = 0   
                        RageUI.Text({ message = "Appuyez sur ~y~[E]~s~ pour accéder aux actions patron", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            RefreshgagarineMoney()
                            RefreshblackgagarineMoney()
                            Bossgagarine()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)

function RefreshgagarineMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            UpdateSocietygagarineMoney(money)
        end, ESX.PlayerData.job2.name)
    end
end

function RefreshblackgagarineMoney()
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
        ESX.TriggerServerCallback('gagarine:getBlackMoneySociety', function(inventory)
            UpdateSocietyblackgagarineMoney(inventory)
        end, ESX.PlayerData.job2.name)
    end
end

function UpdateSocietyblackgagarineMoney(inventory)
    societyblackgagarinemoney = ESX.Math.GroupDigits(inventory.blackMoney)
end

function UpdateSocietygagarineMoney(money)
    societygagarinemoney = ESX.Math.GroupDigits(money)
end

function gagarineboss()
    TriggerEvent('esx_society:openBossMenu', 'gagarine', function(data, menu)
        menu.close()
    end, {wash = false})
end

function Deposerargentsale()
    ESX.TriggerServerCallback('gagarine:getPlayerInventoryBlack', function(inventory)
        while DepositBlackgagarine do
            Citizen.Wait(0)
        end
    end)
end

function Retirerargentsale()
	ESX.TriggerServerCallback('gagarine:getBlackMoneySociety', function(inventory)
	    while StockBlackgagarine do
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

-- BANK --

--- GKSPHONE v2.0.0 ---
Config.Core.Functions.CreateCallback('gksphone:server:bank:transfer', function(source, cb, money, number, name, phoneUniq)
    local info = {status = false}
    debugprint("bank transfer start", {money, number, name, phoneUniq})
    if money == nil or number == nil or name == nil or type(money) ~= 'number' then
        debugprint("bank transfer error 1")
        cb(info)
        return
    end
    if money <= 0 then
        debugprint("bank transfer error 2")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        if not Config.MetaBankTransfer then
            if phonedata.identifier ~= phonedata.setup_owner then
                debugprint("bank transfer error 4")
                cb(info)
                return
            end
        end
        local xPlayer = Config.Core.Functions.GetPlayerByCitizenId(phonedata.setup_owner)
        if xPlayer == nil then
            xPlayer = Config.Core.Functions.GetOfflinePlayerByCitizenId(phonedata.setup_owner)
        end
        local yPhoneData = GetPhoneDataByNumber(number)
        if yPhoneData == nil then
            cb(info)
            return
        end
        local yPlayer = Config.Core.Functions.GetPlayerByCitizenId(yPhoneData.setup_owner)

        if xPlayer and yPlayer then
            local balance = xPlayer.PlayerData.money["bank"]
            local bankTax = Config.BankTransferTax
            local taxAmount = math.floor(money * (bankTax / 100))
            local amount = math.floor(money + taxAmount)

            if balance < amount then
                cb(info)
                return
            end

            xPlayer.Functions.RemoveMoney('bank', amount, "Bank Transfer")
            yPlayer.Functions.AddMoney('bank', money, "Bank Transfer")

            info.status = true
            if yPhoneData.ownerName == nil then
                yPhoneData.ownerName = yPlayer.PlayerData.charinfo.firstname .. " " .. yPlayer.PlayerData.charinfo.lastname
            end
            local xPlayerTransferDesc = _T(phonedata.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_SENDER", {name = yPhoneData.ownerName})
            local yPlayerTransferDesc = _T(yPhoneData.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_RECEIVER", {name = phonedata.ownerName})
            -- bank history save
            local bnkhistoryxPlayer = exports["gksphone"]:bankHistorySave(number, 1, amount, xPlayerTransferDesc, phoneUniq)-- xPlayer
            local bnkhistoryPlayer = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 2, money, yPlayerTransferDesc, yPhoneData.unique_id)-- yPlayer

            local bnkBalanceChangexPlayer = exports["gksphone"]:bankBalanceUpdate(phoneUniq)
            local bnkBalanceChangeyPlayer = exports["gksphone"]:bankBalanceUpdate(yPhoneData.unique_id)

            local notify = {
                title = _T(yPhoneData?.phone_lang, "BankAPP.APP_BANK_TITLE"),
                message = _T(yPhoneData?.phone_lang, "BankAPP.APP_BANK_TRANSFERNOTIFICATION", {name = phonedata.ownerName, money = money}),
                icon = "/html/img/icons/wallet.png",
                info = "sucess",
            }
            exports["gksphone"]:sendNotification(yPlayer.PlayerData.source, notify)


            if bnkhistoryxPlayer and bnkhistoryPlayer and bnkBalanceChangexPlayer and bnkBalanceChangeyPlayer then
                debugprint("bank history save and balance update success")
            else
                debugprint("bank history save and balance update failed", bnkhistoryxPlayer, bnkhistoryPlayer, bnkBalanceChangexPlayer, bnkBalanceChangeyPlayer)
            end

            WebhookLogs("bank", source, {phonedata.phone_number, yPhoneData.phone_number, money, xPlayerTransferDesc, yPlayerTransferDesc, xPlayer.PlayerData.citizenid, yPlayer.PlayerData.citizenid})
            Wait(1000)
            cb(info)
        elseif Config.OfflineBankTransfer and not yPlayer then
            yPlayer = Config.Core.Functions.GetOfflinePlayerByCitizenId(yPhoneData.setup_owner)
            if yPlayer then
                local balance = xPlayer.PlayerData.money["bank"]
                local bankTax = Config.BankTransferTax
                local taxAmount = math.floor(money * (bankTax / 100))
                local amount = math.floor(money + taxAmount)

                if balance < amount then
                    cb(info)
                    return
                end

                xPlayer.Functions.RemoveMoney('bank', amount, "Bank Transfer")
                yPlayer.PlayerData.money["bank"] = yPlayer.PlayerData.money["bank"] + money
                MySQL.Async.execute('UPDATE players SET `money` = @money WHERE `citizenid` = @citizenid', {
                    ['@citizenid'] = yPhoneData.setup_owner,
                    ['@money'] = json.encode(yPlayer.PlayerData.money),
                })

                info.status = true
                if yPhoneData.ownerName == nil then
                    yPhoneData.ownerName = yPlayer.PlayerData.charinfo.firstname .. " " .. yPlayer.PlayerData.charinfo.lastname
                end
                local xPlayerTransferDesc = _T(phonedata.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_SENDER", {name = yPhoneData.ownerName})
                local yPlayerTransferDesc = _T(yPhoneData.phone_lang, "BankAPP.APP_BANK_TRANSFERDESCRIPTION_RECEIVER", {name = phonedata.ownerName})
                -- bank history save
                local bnkhistoryxPlayer = exports["gksphone"]:bankHistorySave(number, 1, amount, xPlayerTransferDesc, phoneUniq)-- xPlayer
                local bnkhistoryPlayer = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 2, money, yPlayerTransferDesc, yPhoneData.unique_id)-- yPlayer

                local bnkBalanceChangexPlayer = exports["gksphone"]:bankBalanceUpdate(phoneUniq)
                local bnkBalanceChangeyPlayer = exports["gksphone"]:bankBalanceUpdate(yPhoneData.unique_id)

                if bnkhistoryxPlayer and bnkhistoryPlayer and bnkBalanceChangexPlayer and bnkBalanceChangeyPlayer then
                    debugprint("bank history save and balance update success")
                else
                    debugprint("bank history save and balance update failed", bnkhistoryxPlayer, bnkhistoryPlayer, bnkBalanceChangexPlayer, bnkBalanceChangeyPlayer)
                end

                WebhookLogs("bank", source, {phonedata.phone_number, yPhoneData.phone_number, money, xPlayerTransferDesc, yPlayerTransferDesc, xPlayer.PlayerData.citizenid, yPlayer.PlayerData.citizenid})
            end
            cb(info)
        else
            debugprint("bank transfer error 5")
            cb(info)
        end
    else
        debugprint("bank transfer error 3")
        cb(info)
    end
end)

RegisterServerEvent("gksphone:server:BusSendTip")
AddEventHandler("gksphone:server:BusSendTip", function(phoneNumber, amaount)
    local _source = source
    local tip = amaount
    local xPlayer = Config.Core.Functions.GetPlayer(_source)
    local zPlayer = Config.Core.Functions.GetPlayerByPhone(phoneNumber)
    if xPlayer and zPlayer then
        local jobs = xPlayer.PlayerData.job.name

        local SocietyRemove = SocietyRemoveMoney(jobs, tip)

        if SocietyRemove then

                zPlayer.Functions.AddMoney('bank', tonumber(tip), "tip")
                local yPhoneData = GetPhoneDataByNumber(phoneNumber)
				if yPhoneData then
					local notify = {
						title = _T(yPhoneData?.phone_lang, "BusinessAPP.APP_BUSINESS_TITLE"),
						message = _T(yPhoneData?.phone_lang, "BusinessAPP.APP_BUSSINES_NOTIFY_TIP"),
						icon = "/html/img/icons/business.png",
					}
					exports["gksphone"]:sendNotification(yPhoneData.source, notify)
				end
                TriggerClientEvent("gksphone:client:bussinesTipNotify", _source)

            Wait(500)
            WebhookLogs("bussinesTip", source, {job = jobs, amount = tip, phone = phoneNumber, yPlayer = zPlayer.PlayerData.citizenid, xPlayer = xPlayer.PlayerData.citizenid})



        end
    end
end)
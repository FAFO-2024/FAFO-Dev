
--- GKSPHONE v2.0 ---
-- New Bill Export --
BillingTable = {}

CreateThread(function()
    BillingTable = MySQL.query.await('SELECT * FROM `gksphone_billing`')
end)


function NewBilling(source, label, society, senderBilling, senderID, amountt)
    local create = false
    local src = source
    local biller = Config.Core.Functions.GetPlayer(src)
    debugprint("new billing exports", {source, society, senderBilling, senderID, amountt})
    if biller then
        local amount = tonumber(amountt)
        if amount and amount > 0 then

            if Config.Core.Shared.Jobs[society] == nil then
                debugprint("billing error, society not found", {society, senderBilling, senderID, amount})
                return false
            end

            local societylabel = Config.Core.Shared.Jobs[society].label
            local bill_holder = biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname

            local billid = MySQL.Sync.insert('INSERT INTO `gksphone_billing` (`citizenid`, `amount`, `society`, `societylabel`,  `sender`, `sendercitizenid`, `description`, `bill_holder`, `status`) VALUES (@citizenid, @amount, @society, @societylabel, @sender, @sendercitizenid, @description, @bill_holder, @status)', {
                ['@citizenid'] = biller.PlayerData.citizenid,
                ['@amount'] = amount,
                ['@society'] = society,
                ['@societylabel'] = societylabel,
                ['@sender'] = senderBilling,
                ['@sendercitizenid'] = senderID,
                ['@description'] = label,
                ['@bill_holder'] = bill_holder,
                ['@status'] = "unpaid"
            })


            local webhookdata = {
                receiverSrc = src,
                receiverName = biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname,
                receiverID = biller.PlayerData.citizenid,
                billingLabel = label,
                billingSociety = society,
                billingSocietyLabel = societylabel,
                billingAmaount = amount,
                senderName = senderBilling,
                senderID = senderID,
                status = "unpaid"
            }

            BillingTable[#BillingTable + 1] = {
                id = billid,
                citizenid = biller.PlayerData.citizenid,
                amount = amount,
                society = society,
                societylabel = societylabel,
                sender = senderBilling,
                sendercitizenid = senderID,
                description = label,
                bill_holder = bill_holder,
                status = "unpaid"
            }

            debugprint("billing created", {source, society, senderBilling, senderID, amount})

            PhoneDataAddBilling(billid, biller.PlayerData.citizenid, amount, society, societylabel, senderBilling, senderID, label, bill_holder, "unpaid")
            create = true
            WebhookLogs('bussinesBillingCreate', src, webhookdata)
        end

    elseif source == "business" then
        local amount = tonumber(amountt)
        if amount and amount > 0 then
            if Config.Core.Shared.Jobs[society] == nil then
                debugprint("billing error, society not found", {society, senderBilling, senderID, amount})
                return false
            end
            biller = Config.Core.Functions.GetPlayerByCitizenId(senderID)
            local billerJob = biller.PlayerData.job.name
            if Config.Core.Shared.Jobs[billerJob] == nil then
                debugprint("billing error, billerJob not found", {society, senderBilling, billerJob, amount})
                return false
            end
            local societylabel = Config.Core.Shared.Jobs[billerJob].label
            local reciverbussines = Config.Core.Shared.Jobs[society].label
            local billid = MySQL.Sync.insert('INSERT INTO `gksphone_billing` (`citizenid`, `amount`, `society`, `societylabel`,  `sender`, `sendercitizenid`, `description`, `bill_holder`, `status`) VALUES (@citizenid, @amount, @society, @societylabel, @sender, @sendercitizenid, @description, @bill_holder, @status)', {
                ['@citizenid'] = society,
                ['@amount'] = amount,
                ['@society'] = billerJob,
                ['@societylabel'] = societylabel,
                ['@sender'] = senderBilling,
                ['@sendercitizenid'] = senderID,
                ['@description'] = label,
                ['@bill_holder'] = reciverbussines,
                ['@status'] = "unpaid"
            })

            local webhookdata = {
                receiverSrc = src,
                receiverName = reciverbussines,
                receiverID = "Business",
                billingLabel = label,
                billingSociety = society,
                billingSocietyLabel = societylabel,
                billingAmaount = amount,
                senderName = senderBilling,
                senderID = senderID,
                status = "unpaid"
            }

            local billData = {
                id = billid,
                citizenid = society,
                amount = amount,
                society = billerJob,
                societylabel = societylabel,
                sender = senderBilling,
                sendercitizenid = senderID,
                description = label,
                bill_holder = reciverbussines,
                status = "unpaid",
                time = os.date('%Y-%m-%d %H:%M:%S'),
            }

            BillingTable[#BillingTable + 1] = billData

            create = true
            WebhookLogs('bussinesBillingCreate', biller.PlayerData.source, webhookdata)

            local checkBillAuth = Config.UseBusinessJobs[society]?.billingpay
            local players = Config.Core.Functions.GetQBPlayers()
            if players and checkBillAuth then
                for _, v in pairs(players) do
                    if v and v.PlayerData.job.name == society and v.PlayerData.job.grade.level >= checkBillAuth then
                        local phoneLang = GetPhoneLangBySource(v.PlayerData.source)
                        TriggerClientEvent('gksphone:client:NewBussinesBill', v.PlayerData.source, billData)
                        local notify = {
                                title = _T(phoneLang, "BillingAPP.APP_BILLING_HEADER"),
                                message = _T(phoneLang, "BillingAPP.APP_BILLING_NOTIFY_NEWBILL"),
                                icon = "/html/img/icons/billing.png",
                        }
                        exports["gksphone"]:sendNotification(v.PlayerData.source, notify)
                    end
                end
            end

        end
    end

    return create
end
exports("NewBilling", NewBilling)



exports("IsUnpaidBillsbyCid", function (cid)
    local xPlayer = Config.Core.Functions.GetPlayerByCitizenId(cid)
    local retval = false
    if xPlayer then
        for i = 1, #BillingTable, 1 do
            if BillingTable[i].citizenid == cid and BillingTable[i].status == "unpaid" then
                retval = true
                break
            end
        end
    end
    return retval
end)


Config.Core.Functions.CreateCallback('gksphone:server:billing:allbillpay', function(source, cb, phoneUniq, totalAmount)
    local info = {status = false}
    if phoneUniq == nil then
        debugprint("bank request error1")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        local xPlayer = Config.Core.Functions.GetPlayerByCitizenId(phonedata.setup_owner)
        local PlayerBankBalance = xPlayer.PlayerData.money.bank
        local playerJobName = xPlayer.PlayerData.job.name
        totalAmount = tonumber(totalAmount)
        if PlayerBankBalance < totalAmount then
            debugprint("billing paid error, bank balance error", {phoneUniq, totalAmount})
            cb(info)
            return
        end
        if totalAmount <= 0 then
            debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalAmount})
            cb(info)
            return
        end
        if xPlayer ~= nil then
            if #phonedata.bankDetails.Billings ~= 0 then
                local totalBillingAmount = 0
                for i = 1, #phonedata.bankDetails.Billings, 1 do
                    if phonedata.bankDetails.Billings[i].status == "unpaid" then
                        if Config.UseBillingCommission then
                            local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(phonedata.bankDetails.Billings[i].sendercitizenid)
                            if SenderPly ~= nil then
                                if Config.BillingCommissions[phonedata.bankDetails.Billings[i].society] then
                                    local commission = Round(phonedata.bankDetails.Billings[i].amount * Config.BillingCommissions[phonedata.bankDetails.Billings[i].society])
                                    SenderPly.Functions.AddMoney('bank', commission)
                                    local SocietyRemove = SocietyRemoveMoney(phonedata.bankDetails.Billings[i].society, commission)
                                    if SocietyRemove then
                                        debugprint("billing paid, society remove money", {phonedata.bankDetails.Billings[i].society, commission})
                                    end

                                end
                            end
                        end

                        xPlayer.Functions.RemoveMoney('bank', phonedata.bankDetails.Billings[i].amount, "paid-invoice")

                        local SocietyAddMoney = SocietyAddMoney(phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount)
                        if SocietyAddMoney then
                            debugprint("billing paid, society add money", {phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount})
                        end


                        MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                            ['@status'] = "paid",
                            ['@id'] = phonedata.bankDetails.Billings[i].id
                        })
                        totalBillingAmount = totalBillingAmount + phonedata.bankDetails.Billings[i].amount
                        phonedata.bankDetails.Billings[i].status = "paid"

                        for k, v in pairs(BillingTable) do
                            if v.id == phonedata.bankDetails.Billings[i].id then
                                BillingTable[k].status = "paid"
                                WebhookLogs('bussinesBillingPay', source, BillingTable[k])
                            end
                        end

                    end
                end

                local checkBillAuth = Config.UseBusinessJobs[playerJobName]?.billingpay
                if checkBillAuth and xPlayer.PlayerData.job.grade.level >= checkBillAuth then
                    local players = Config.Core.Functions.GetQBPlayers()
                    for i = 1, #BillingTable, 1 do
                        if BillingTable[i].status == "unpaid" then
                            local busBillCheck = Config.Core.Shared.Jobs[BillingTable[i].citizenid]
                            if busBillCheck then
                                if Config.UseBillingCommission then
                                    local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(BillingTable[i].sendercitizenid)
                                    if SenderPly ~= nil then
                                        if Config.BillingCommissions[BillingTable[i].society] then
                                            local commission = Round(BillingTable[i].amount * Config.BillingCommissions[BillingTable[i].society])
                                            SenderPly.Functions.AddMoney('bank', commission)
                                            local SocietyRemove = SocietyRemoveMoney(BillingTable[i].society, commission)
                                            if SocietyRemove then
                                                debugprint("billing paid, society remove money", {BillingTable[i].society, commission})
                                            end
                                        end
                                    end
                                end

                                local SoiectPayBill = SocietyRemoveMoney(BillingTable[i].citizenid, BillingTable[i].amount)
                                if SoiectPayBill then
                                    debugprint("billing paid, society remove money", {BillingTable[i].citizenid, BillingTable[i].amount})
                                end
                                local SocietyAddMoney = SocietyAddMoney(BillingTable[i].society, BillingTable[i].amount)
                                if SocietyAddMoney then
                                    debugprint("billing paid, society add money", {BillingTable[i].society, BillingTable[i].amount})
                                end

                                MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                                    ['@status'] = "paid",
                                    ['@id'] = BillingTable[i].id
                                })
                                totalBillingAmount = totalBillingAmount + BillingTable[i].amount
                                BillingTable[i].status = "paid"
                                WebhookLogs('bussinesBillingPay', source, BillingTable[i])

                                if players then
                                    for _, v in pairs(players) do
                                        if v and v.PlayerData.job.name == BillingTable[i].citizenid and v.PlayerData.job.grade.level >= checkBillAuth then
                                            TriggerClientEvent('gksphone:client:updateBillBusiness', v.PlayerData.source, BillingTable[i].id)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end


                local description = _T(phonedata.phone_lang, "BillingAPP.APP_BILLING_ALLPAIDDESCRIPTION", {amount = totalBillingAmount})
                local histroysave = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq) -- xPlayer

                if histroysave then
                    debugprint("billing paid, bank history save", {phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq})
                end
                local bnkBalanceChangexPlayer = exports["gksphone"]:bankBalanceUpdate(phoneUniq)
                if bnkBalanceChangexPlayer then
                    debugprint("billing paid, bank balance update", {phoneUniq})
                end
                PhoneDataUpdateBilling(phonedata.unique_id)
                info.status = true
                cb(info)
            else
                debugprint("billing paid error, #phonedata.bankDetails.Billings == 0", {phoneUniq})
                cb(info)
                return
            end
        else
            debugprint("billing paid error, xPlayer nil", {phoneUniq})
            cb(info)
            return
        end
    else
        debugprint("bank request error2")
        cb(info)
    end

end)

Config.Core.Functions.CreateCallback('gksphone:server:billing:billpay', function(source, cb, phoneUniq, billID, isBusiness)
    local info = {status = false}
    if phoneUniq == nil then
        debugprint("bank request error1")
        cb(info)
        return
    end
    if PhonesData[phoneUniq] ~= nil then
        local phonedata = PhonesData[phoneUniq]
        local xPlayer = Config.Core.Functions.GetPlayerByCitizenId(phonedata.setup_owner)
        local PlayerBankBalance = xPlayer.PlayerData.money.bank

        if xPlayer ~= nil and not isBusiness then
            if #phonedata.bankDetails.Billings ~= 0 then
                local totalBillingAmount = 0

                for i = 1, #phonedata.bankDetails.Billings, 1 do
                    if phonedata.bankDetails.Billings[i].id == billID then
                        if phonedata.bankDetails.Billings[i].status == "unpaid" then

                            local totalAmount = tonumber(phonedata.bankDetails.Billings[i].amount)
                            if PlayerBankBalance < totalAmount then
                                debugprint("billing paid error, bank balance error", {phoneUniq, totalAmount})
                                cb(info)
                                return
                            end
                            if totalAmount <= 0 then
                                debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalAmount})
                                cb(info)
                                return
                            end

                            if Config.UseBillingCommission then
                                local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(phonedata.bankDetails.Billings[i].sendercitizenid)
                                if SenderPly ~= nil then
                                    if Config.BillingCommissions[phonedata.bankDetails.Billings[i].society] then
                                        local commission = Round(phonedata.bankDetails.Billings[i].amount * Config.BillingCommissions[phonedata.bankDetails.Billings[i].society])
                                        SenderPly.Functions.AddMoney('bank', commission)
                                        local SocietyRemove = SocietyRemoveMoney(phonedata.bankDetails.Billings[i].society, commission)
                                        if SocietyRemove then
                                            debugprint("billing paid, society remove money", {phonedata.bankDetails.Billings[i].society, commission})
                                        end
                                    end
                                end
                            end

                            xPlayer.Functions.RemoveMoney('bank', phonedata.bankDetails.Billings[i].amount, "paid-invoice")
                            local SocietyAddMoney = SocietyAddMoney(phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount)
                            if SocietyAddMoney then
                                debugprint("billing paid, society add money", {phonedata.bankDetails.Billings[i].society, phonedata.bankDetails.Billings[i].amount})
                            end

                            MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                                ['@status'] = "paid",
                                ['@id'] = phonedata.bankDetails.Billings[i].id
                            })
                            totalBillingAmount = totalBillingAmount + phonedata.bankDetails.Billings[i].amount
                            phonedata.bankDetails.Billings[i].status = "paid"

                            for k, v in pairs(BillingTable) do
                                if v.id == phonedata.bankDetails.Billings[i].id then
                                    BillingTable[k].status = "paid"
                                    WebhookLogs('bussinesBillingPay', source, BillingTable[k])
                                end
                            end


                        end
                    end
                end

                local description = _T(phonedata.phone_lang, "BillingAPP.APP_BILLING_PAIDDESCRIPTION", {amount = totalBillingAmount})
                local histroysave = exports["gksphone"]:bankHistorySave(phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq) -- xPlayer

                if histroysave then
                    debugprint("billing paid, bank history save", {phonedata.phone_number, 1, totalBillingAmount, description, phoneUniq})
                end
                local bnkBalanceChangexPlayer = exports["gksphone"]:bankBalanceUpdate(phoneUniq)
                if bnkBalanceChangexPlayer then
                    debugprint("billing paid, bank balance update", {phoneUniq})
                end
                PhoneDataUpdateBilling(phonedata.unique_id)
                info.status = true
                cb(info)
            else
                debugprint("billing paid error, #phonedata.bankDetails.Billings == 0", {phoneUniq})
                cb(info)
                return
            end
        elseif xPlayer ~= nil and isBusiness then
            local totalBillingAmount = 0
            local players = Config.Core.Functions.GetQBPlayers()
            for _, k in pairs(BillingTable) do
                if k.id == billID then
                    if k.status == "unpaid" then
                        local bussinesBankBalance = SocietyGetMoney(k.citizenid) or 0
                        local totalAmount = tonumber(k.amount)
                        if bussinesBankBalance < totalAmount then
                            debugprint("billing paid error, bank balance error", {phoneUniq, totalAmount})
                            cb(info)
                            return
                        end
                        if totalAmount <= 0 then
                            debugprint("billing paid error, totalAmount <= 0", {phoneUniq, totalAmount})
                            cb(info)
                            return
                        end

                        if Config.UseBillingCommission then
                            local SenderPly = Config.Core.Functions.GetPlayerByCitizenId(k.sendercitizenid)
                            if SenderPly ~= nil then
                                if Config.BillingCommissions[k.society] then
                                    local commission = Round(k.amount * Config.BillingCommissions[k.society])
                                    SenderPly.Functions.AddMoney('bank', commission)
                                    local SocietyRemove = SocietyRemoveMoney(k.society, commission)
                                    if SocietyRemove then
                                        debugprint("billing paid, society remove money", {k.society, commission})
                                    end
                                end
                            end
                        end

                        local SoiectPayBill = SocietyRemoveMoney(k.citizenid, k.amount)
                        if SoiectPayBill then
                            debugprint("billing paid, society remove money", {k.citizenid, k.amount})
                        end
                        local SocietyAddMoney = SocietyAddMoney(k.society, k.amount)
                        if SocietyAddMoney then
                            debugprint("billing paid, society add money", {k.society, k.amount})
                        end

                        MySQL.Async.execute('UPDATE gksphone_billing SET status = @status WHERE id = @id', {
                            ['@status'] = "paid",
                            ['@id'] = k.id
                        })
                        totalBillingAmount = totalBillingAmount + k.amount
                        k.status = "paid"
                        WebhookLogs('bussinesBillingPay', source, k)

                        local checkBillAuth = Config.UseBusinessJobs[k.citizenid]?.billingpay

                        if players then
                            for _, v in pairs(players) do
                                if v and v.PlayerData.job.name == k.citizenid and v.PlayerData.job.grade.level >= checkBillAuth then
                                    TriggerClientEvent('gksphone:client:updateBillBusiness', v.PlayerData.source, k.id)
                                end
                            end
                        end
                    end
                end
            end

            info.status = true
            cb(info)
        else
            debugprint("billing paid error, xPlayer nil", {phoneUniq})
            cb(info)
            return
        end
    else
        debugprint("bank request error2")
        cb(info)
    end

end)

Config.Core.Functions.CreateCallback('gksphone:server:createbill', function(source, cb, data)
    local src
    local biller = Config.Core.Functions.GetPlayer(source)
    local phoneLang = GetPhoneLangBySource(source)
    local info = {status = false}
    if biller then
        if data.id then
            if src ~= data.id then
                local billed = Config.Core.Functions.GetPlayer(tonumber(data.id))
                if not billed then
                    info.message = _T(phoneLang, "BillingAPP.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = data.id})
                    cb(info)
                    return
                end
                local amount = tonumber(data.amount)
                if amount and amount > 0 then
                    local newbill = NewBilling(tonumber(data.id), data.fine, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname, biller.PlayerData.citizenid, amount)
                    if newbill then
                        info.status = true
                        info.message = _T(phoneLang, "BillingAPP.APP_BILLING_SUCCESS", {amount = amount, player = data.id})
                        cb(info)
                    else
                        info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                        cb(info)
                    end
                else
                    info.message = _T(phoneLang, "BillingAPP.APP_BILLING_AMOUNT_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_YOURSELF_ERROR")
                cb(info)
            end
        elseif data.contact then
            local contact = data.contact
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                for k, l in pairs(contact) do
                    if l.number then
                        local number = l.number
                        local billed = GetSourceByNumber(number)
                        if billed then
                            local newbill = NewBilling(billed, data.fine, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname, biller.PlayerData.citizenid, amount)
                            if newbill then
                                info.status = true
                                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_SUCCESS", {amount = amount, player = number})
                                cb(info)
                            else
                                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                                cb(info)
                            end
                        else
                            info.message = _T(phoneLang, "BillingAPP.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = number})
                            cb(info)
                        end
                    else
                        info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                        cb(info)
                    end
                end
            else
                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        elseif data.airdrop then
            local airdrop = data.airdrop
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                for k, l in pairs(airdrop) do
                    if l.pid then
                        local bsrc = tonumber(l.pid)
                        local billed = Config.Core.Functions.GetPlayer(bsrc)
                        if billed then
                            local newbill = NewBilling(bsrc, data.fine, biller.PlayerData.job.name, biller.PlayerData.charinfo.firstname .. ' ' .. biller.PlayerData.charinfo.lastname, biller.PlayerData.citizenid, amount)
                            if newbill then
                                info.status = true
                                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_SUCCESS", {amount = amount, player = billed.PlayerData.charinfo.firstname})
                                cb(info)
                            else
                                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                                cb(info)
                            end
                        else
                            info.message = _T(phoneLang, "BillingAPP.APP_BILLING_PLAYER_NOT_ONLINE", {blplayer = bsrc})
                            cb(info)
                        end
                    else
                        info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                        cb(info)
                    end
                end
            else
                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        elseif data.business then
            local jobname = data.business
            local amount = tonumber(data.amount)
            if amount and amount > 0 then
                local newbill = NewBilling("business", data.fine, jobname, biller.PlayerData.job.name, biller.PlayerData.citizenid, amount)
                if newbill then
                    info.status = true
                    info.message = _T(phoneLang, "BillingAPP.APP_BILLING_SUCCESS", {amount = amount, player = jobname})
                    cb(info)
                else
                    info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
                    cb(info)
                end
            else
                info.message = _T(phoneLang, "BillingAPP.APP_BILLING_AMOUNT_ERROR")
                cb(info)
            end
        else
            info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
            cb(info)
        end
    else
        info.message = _T(phoneLang, "BillingAPP.APP_BILLING_ERROR")
        cb(info)
    end
end)

Config.Core.Functions.CreateCallback('gksphone:server:getBussinesBilling', function(source, cb)
    local src = source
    local xPlayer = Config.Core.Functions.GetPlayer(src)
    if xPlayer then
        local playerJob = xPlayer.PlayerData.job.name
        -- BillingTable find playerjob society
        local billing = {}
        for i, bill in ipairs(BillingTable) do
            if bill.society == playerJob then
                table.insert(billing, bill)
            end
        end
        cb(billing)
    else
        cb(false)
    end

end)

Config.Core.Functions.CreateCallback('gksphone:server:deleteBill', function(source, cb, id)
    local src = source
    local e = Config.Core.Functions.GetPlayer(src)

    MySQL.Async.fetchAll('SELECT * FROM gksphone_billing WHERE society = @society AND id = @id', {
        ['@society'] = e.PlayerData.job.name,
        ['@id'] = id
    }, function(data)
        if data[1] then
            local res = data[1]
            local society = res.citizenid
            local busBillCheck = Config.Core.Shared.Jobs[society]

            if busBillCheck then
                if Config.Core.Shared.Jobs[society] == nil then
                    debugprint("billing error, society not found", {society, res.sender, res.sendercitizenid, res.amount})
                    return cb(false)
                end

                MySQL.Async.fetchAll("DELETE FROM gksphone_billing WHERE id = @id",
                    {
                        ['@id'] = res.id
                    })

                for k,v in pairs(BillingTable) do
                    if v.id == res.id then
                        WebhookLogs('bussinesBillDelete', src, BillingTable[k])
                        table.remove(BillingTable, k)
                        break
                    end
                end

                local checkBillAuth = Config.UseBusinessJobs[society]?.billingpay
                local players = Config.Core.Functions.GetQBPlayers()
                if players then
                    for _, v in pairs(players) do
                        if v and v.PlayerData.job.name == society and v.PlayerData.job.grade.level >= checkBillAuth then
                            TriggerClientEvent('gksphone:client:DeleteBussBill', v.PlayerData.source, res.id)
                        end
                    end
                end

            else

                PhoneDataDelBilling(res.id, res.citizenid)
                MySQL.Async.fetchAll("DELETE FROM gksphone_billing WHERE id = @id",
                    {
                        ['@id'] = res.id
                    })

                for k,v in pairs(BillingTable) do
                    if v.id == res.id then
                        WebhookLogs('bussinesBillDelete', src, BillingTable[k])
                        table.remove(BillingTable, k)
                        break
                    end
                end
            end

            cb(true)
        else
            local notify = {
                title = _T(phoneLang, "BillingAPP.APP_BILLING_HEADER"), -- The title of the notification
                message = _T(phoneLang, "BillingAPP.APP_BILLING_NOBILL"), -- The message of the notification
                icon = "/html/img/icons/billing.png", -- The icon to be displayed with the notification
                duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
            }
            exports["gksphone"]:sendNotification(source, notify)
            cb(false)
        end
    end)

end)
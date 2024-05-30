--- QBCORE Crypto ----



Config.Core.Functions.CreateCallback('gksphone:server:getWalletID', function(source, cb, data)
	local src = source
	local PlayerSource = GetSourceByNumber(data.Number)
	local phoneLang = GetPhoneLangBySource(source)
	if not PlayerSource then
		-- TODO: Add notification
		local notify = {
			title = _T(phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
			message = _T(phoneLang, "QbitAPP.APP_QBIT_NOPERSON"), -- The message of the notification
			icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
			duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
		}
		exports["gksphone"]:sendNotification(source, notify)
		cb(false)
		return
	end
	local Player = Config.Core.Functions.GetPlayer(PlayerSource)
	if Player then
		local WalletID = Player.PlayerData.metadata["walletid"]
		cb(WalletID)
	else
		-- TODO: Add notification
		local notify = {
			title = _T(phoneLang, "QbitAPP.APP_QBIT_TITLE"), -- The title of the notification
			message = _T(phoneLang, "QbitAPP.APP_QBIT_NOTIFY_TRANSFERSUCESS"), -- The message of the notification
			icon = "/html/img/icons/qbit.png", -- The icon to be displayed with the notification
			duration = 5000, -- The duration for which the notification should be displayed (in milliseconds)
		}
		exports["gksphone"]:sendNotification(source, notify)
		cb(false)
	end
end)
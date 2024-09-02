Config = Config or {}
Config.Debug = false            -- Set to true to enable debug mode

--- ### FRAMEWORK ### ----

Config.Core = nil
pcall(function() Config.Core = exports['qb-core']:GetCoreObject() end)
if Config.Core == nil then
    TriggerEvent("QBCore:GetObject", function(obj) Config.Core = obj end)
end

Config.qbCrypto               = "qbit"    -- Set the name of the crypto item (default: qbit)
Config.HospitalAmbulanceAlert = false     -- Set to false to disable hospital ambulance alert (default: false)


--- ### Phone settings ### ---

Config.KeyMapping          = true        -- Set to false to disable keymapping
Config.OpenPhone           = "M"        -- Key to open phone (default: F1) (https://docs.fivem.net/docs/game-references/controls/)
Config.DefaultLocale       = "en"        -- Set default locale (default: en)
Config.Locales             = {"af", "de", "en", "fr", "nl", "tr", "zh-TW"} -- Set the languages you want to use
Config.RegisterCommandName = "phone"     -- Set the name of the command to open the phone (default: phone)
Config.ItemName = {  -- Set the name of the item to open the phone (default: ["iphone"] = "ios") !!!  -- Don't add more than two options unless you're using the phone as a meta item. !!!
    ["iphone"] = "ios",
    ["phone"] = "android"
}
Config.PropName = {
    ["iphone"] = "patoche_iphone_15_gkphone",
    ["phone"] = "patoche_galaxy_s23_gkphone"
}
Config.SerialNumberPrefix  = "GKS"       -- Set the prefix of the phone (default: gks)
Config.PropActive          = true        -- Set to true to enable prop when phone is open (default: true)
Config.Fahrenheit          = true       -- Set to true to use Fahrenheit (default: false)
Config.QbInventory         = GetResourceState("qb-inventory") ~= 'missing'
Config.OxInvetory          = GetResourceState("ox_inventory") ~= 'missing' -- https://github.com/overextended/ox_inventory
Config.CoreInventory       = GetResourceState("core_inventory") ~= 'missing' -- https://www.c8re.store/package/5123274
Config.qsInvetory          = GetResourceState("qs-inventory") ~= 'missing' -- https://buy.quasar-store.com/package/4770732
Config.tgiannInventory     = GetResourceState("tgiann-inventory") ~= 'missing'  -- https://store.tgiann.com/package/6273000
Config.AirSharePlayerName  = true       -- Set player names to true to appear as unknown in AirShare (default: false)
Config.WaitPhone           = 2           -- Set the time to wait before opening the phone (default: 2)
Config.MetaItem            = true       -- Set to false to disable meta item (default: true) !!!If your inventory supports it, you can use it.!!!
Config.AutoDeleteData      = false        -- Set to true to automatically delete data (default: true)
Config.AutoDeleteDays      = 5           -- This value is used to automatically delete data that was added a certain number of days ago. (default: 5)
Config.deleteCharacter     = true       -- Set to true to delete the phone data when the character is deleted (default: false) !!!All data in Darkchat, Messages and similar applications will be deleted.!!!

--- ### EyeTarget Settings ### ---

Config.EyeTarget = true                  -- Set to false to disable eyetarget
Config.TargetExport = "qb-target"        -- Set the name of the target export (default: qb-target)

--- ### Voice Settings ### ---

Config.MumbleExport     = "mumble-voip"       -- exports["mumble-voip"] -- Resource Name
Config.PMAVoiceExport   = "pma-voice"         -- exports["pma-voice"]   -- Resource Name
Config.PMAVoice         = true                -- Use Pma-Voice Resource (Recomended!) https://github.com/AvarianKnight/pma-voice
Config.UseMumbleVoIP    = false               -- Use Frazzle's Mumble-VoIP Resource https://github.com/FrazzIe/mumble-voip
Config.SaltyChat        = false               -- Use SaltyChat Resource

--- ### Taxi APP Settings ### ---

Config.TaxiPrice = 100000000                       -- Set the price of the taxi (default: 10)
Config.TaxiJobCode = "taxi"                 -- Job Code

--- ### House APP Settings ### ---

Config.loafHouse        = false   -- Activate if you are using Loaf House (https://store.loaf-scripts.com/package/4310850)
Config.bcs_housing      = false   -- Activate if you are using BCS Housing (https://masbagus.tebex.io/package/5090952)
Config.QsHousing        = false   -- Activate if you are using QS-Housing (https://buy.quasar-store.com/package/6304045)

--- ### Bank APP Settings ### ---

Config.BankTransferTax      = 10     -- Bank transfer commission rate
Config.OfflineBankTransfer  = false   -- Enable offline bank transfer
Config.MetaBankTransfer     = false   -- Being able to transfer money from someone else's phone


--- ### Garage/Vale Settings ### ---

Config.qbGarages        = true   -- Set to false if you are not using qb-garages
Config.cdGarages        = false  -- Activate if you are using Codesign Garage (https://codesign.pro/package/4206352)
Config.loafGarages      = false  -- Activate if you are using Loaf Garage (https://store.loaf-scripts.com/package/4310876)
Config.JGGarages        = false  -- Activate if you are using JG Advanced Garages v3 (https://store.jgscripts.com/package/5126524)

Config.ValespawnRadius  = 100.0   -- Distance to spaw your car (default: 100.0)
Config.ValePrice        = 100000000    -- Vale Price (default: 100)
Config.ValeNPC          = false   -- Activate if you want the valet to bring the car to you. (default: true)
Config.ImpoundVale      = false   -- Set to true to not bring impounded cars (default: true)

Config.ValeBlaclistCars = { -- Add the car code to the list to prevent bringing the car
    "police",
    "police2",
    "police3",
    "ambulance",
}


--- ### Car Seller App Settings ### ---
Config.CarSellerAppFee = 0 -- Commission rate for car sales (default: 10)
Config.SellerBlaclistCars = { -- Add the car code to the list to prevent selling the car
    "police",
    "police2",
    "police3",
    "ambulance",
}


--- ### Advertising APP Settings ### ---
Config.AdvertisingPrice = 500                      -- Price to advertise (default: 1000)

--- ### Twitter APP Settings ### ---

Config.TwitterVerifyCommand = "twitterverify"   -- (/twitterverify true/false username) yellow tick
Config.TwitterSendBlockCommand = "blocktwitter" -- (/blockTwitter true/false)
Config.TwitterSendBanCommand = "bantwitter" -- (/bantwitter true/false username)
Config.TwitterSubsDate = 5 -- Twitter subs subscription renewal time
Config.TwitterSubsPay = 15 -- Twitter Subscription fee

-- ## PHONE Box ## --

Config.PhoneBox = false      -- Set to false to disable phone box
Config.PhoneBoxKey = "E"    -- Key to open phone box (default: E) (https://docs.fivem.net/docs/game-references/controls/)
Config.PhoneBoxRegCom = "phonebox"  --- Register Command (/phonebox)
Config.PhoneBootNumber = "22222"   -- Set the number of the phone box (default: 22222)
Config.PhoneBoothMoney = { actived = true, money = 500 }   -- Set to false to disable money (default: true) (default: 500)
Config.PhoneBoothModel = {   -- Set the model of the phone box (default: phone box model)
	[1281992692] = true,
    [1158960338] = true,
    [295857659] = true,
    [-78626473] = true,
    [-2103798695] = true,
    [1511539537] = true,
    [-1559354806] = true
}


-- ## Crypto App Settings ## --
-- Cryptos to use
-- You can add or turn off any crypto you want. (https://api.coingecko.com/api/v3/coins/list?include_platform=false) Crypto list that can be added
-- The id option will be the first value, and the second value will be true or false.
Config.AllowCoin = {
    ["bitcoin"] = false,
    ["ethereum"] = false,
    ["tether"] = false,
    ["binance-usd"] = false,
    ["uniswap"] = false,
    ["binancecoi"] = false,
    ["terra-luna"] = false,
    ["avalanche-2"] = false,
    ["cardano"] = false,
    ["ripple"] = false,
    ["usd-coin"] = false,
    ["dogecoin"] = false,
    ["litecoin"] = false,
    ["chainlink"] = false,
    ["stellar"] = false,
    ["tron"] = false,
    ["eos"] = false,
    ["monero"] = false,
    ["iota"] = false
}

-- ## Spam Check ## --

Config.SpamPlayerKick = false    -- Set to false to disable player kick (default: true)
Config.SpamLimit = 6            -- Default: 6
Config.SpamReset = 10           -- seconds
Config.SpamDropPlayer = "You were kicked from the server for spamming too much" -- Message to be sent when the player is kicked


-- ### Live APP Settings ### ---
Config.LiveAPPDonateTax = 0.20 -- deduction rate from incoming money


--------  E-SIM ---------
--- SIM CARD SETTINGS ---

Config.DefaultOperator = "GKS"
Config.DefaultPackage = 1
Config.UseSIMPackage = true -- Set to true to use the SIM package system
Config.LimitPhoneNumbers = 3 -- Set the number of phone numbers that can be purchased (default: 3)

Config.Operators = {
    ["GKS"] = {
        ["name"] = "GKS",
        ["label"] = "GKS",
        ["sms"] = 1,
        ["call"] = 1,
        ["internet"] = 1,
        ["newnumber"] = 1000
    },
    ["GMobile"] = {
        ["name"] = "GKS",
        ["label"] = "GMobile",
        ["sms"] = 1,
        ["call"] = 1,
        ["internet"] = 1,
        ["newnumber"] = 1000
    },
    ["GCellular"] = {
        ["name"] = "GKS",
        ["label"] = "GCellular",
        ["sms"] = 1,
        ["call"] = 1,
        ["internet"] = 1,
        ["newnumber"] = 1000
    }
}

Config.SIMPackages = {
    ["GKS"] = {
        {
            ["package_name"] = "Young 1",
            ["package_price"] = 100,
            ["package_sms"] = 1000,
            ["package_call"] = 1000,
            ["package_internet"] = 1000
        },
        {
            ["package_name"] = "Young 2",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Young 4",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    },
    ["GMobile"] = {
        {
            ["package_name"] = "Eco",
            ["package_price"] = 100,
            ["package_sms"] = 1000,
            ["package_call"] = 1000,
            ["package_internet"] = 1000
        },
        {
            ["package_name"] = "Middle",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Pro",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    },
    ["GCellular"] = {
        {
            ["package_name"] = "Young",
            ["package_price"] = 100,
            ["package_sms"] = 1000,
            ["package_call"] = 1000,
            ["package_internet"] = 1000
        },
        {
            ["package_name"] = "Retired",
            ["package_price"] = 200,
            ["package_sms"] = 2000,
            ["package_call"] = 2000,
            ["package_internet"] = 2000
        },
        {
            ["package_name"] = "Middle",
            ["package_price"] = 400,
            ["package_sms"] = 4000,
            ["package_call"] = 4000,
            ["package_internet"] = 4000
        }
    }
}

-- Config.UseSIMData is a table that specifies the amount of SIM data required for various actions in the phone application.
-- Each key in the table represents an action, and the corresponding value represents the amount of SIM data required for that action.
-- The values are expressed in megabytes (MB).
Config.UseSIMData = {
    ["AdvertisingPost"] = 1,                   -- Amount of SIM data required for posting an advertisement
    ["AdvertisingDelete"] = 1,                 -- Amount of SIM data required for deleting an advertisement
    ["CarSellerAdd"] = 1,                      -- Amount of SIM data required for adding a car to the car seller
    ["CarSellerDelete"] = 1,                   -- Amount of SIM data required for deleting a car from the car seller
    ["CarSellerBuy"] = 1,                      -- Amount of SIM data required for buying a car from the car seller
    ["CryptoBuy"] = 1,                         -- Amount of SIM data required for buying cryptocurrency
    ["CryptoSell"] = 1,                        -- Amount of SIM data required for selling cryptocurrency
    ["CryptoTransfer"] = 1,                    -- Amount of SIM data required for transferring cryptocurrency
    ["DarkChatNewChannel"] = 1,                -- Amount of SIM data required for creating a new channel in DarkChat
    ["DarkChatRemoveChannel"] = 1,             -- Amount of SIM data required for removing a channel from DarkChat
    ["DarkChatGetMessage"] = 1,                -- Amount of SIM data required for retrieving messages from DarkChat
    ["DarkChatSendMessage"] = 1,               -- Amount of SIM data required for sending a message in DarkChat
    ["DispatchSendChatMessage"] = 1,           -- Amount of SIM data required for sending a chat message to dispatch
    ["DispatchSendReport"] = 1,                -- Amount of SIM data required for sending a report to dispatch
    ["GamesScoreSave"] = 1,                     -- Amount of SIM data required for saving a game score
    ["LiveStreamCreate"] = 1,                  -- Amount of SIM data required for creating a live stream
    ["LiveStreamWatch"] = 1,                   -- Amount of SIM data required for watching a live stream
    ["MailSend"] = 1,                          -- Amount of SIM data required for sending an email
    ["MessageStorieShare"] = 1,                -- Amount of SIM data required for sharing a storie
    ["MessageViewStorie"] = 1,                 -- Amount of SIM data required for viewing a storie
    ["MessageImageShare"] = 1,                 -- Amount of SIM data required for sharing an image
    ["PlaytubeSearch"] = 1,                    -- Amount of SIM data required for searching on Playtube
    ["SquawkPost"] = 1,                        -- Amount of SIM data required for posting a squawk
    ["SquawkLike"] = 1,                         -- Amount of SIM data required for liking a squawk
    ["SquawkRetweet"] = 1,                      -- Amount of SIM data required for retweeting a squawk
    ["SquawkPostDelete"] = 1,                   -- Amount of SIM data required for deleting a squawk
    ["TaxiCall"] = 1,                          -- Amount of SIM data required for calling a taxi
    ["TaxijobAccept"] = 1,                     -- Amount of SIM data required for accepting a taxi job
    ["SendMessage"] = 1                         -- Amount of SIM data required for sending a message
}


-- ### Business APP ### ---
-- Commission rate for each jobs
-- This is a percentage (0.10) == 10% ( Must be active to receive commission - If the player is not in the game, she/he cannot receive a commission.)
Config.AutoPaidBillDelete = false -- Set to true to automatically delete paid invoices
Config.UnpaidBillInterest = true --When you enable it, the interest transaction will happen automatically every time you open a server, according to the conditions you set below.
Config.BillInterest = { day = 7, percent = 20 }  -- You can increase the amount of bills that are 7 days or more past due by 20%. ( !! Dates of bills change when the commission is set )
Config.UseBillingCommission = true -- Set to true if you want players to receive commissions
Config.BillingCommissions = {   -- Section to set how much commission players will receive from billing issued for specific jobs.
    mechanic = 0.10,
    police = 0.20,
    sasp = 0.20,
    sheriff = 0.20,
    ambulance = 0.20,
    firefighter = 0.20
}

-- This configuration determines whether the player receives the fee from billing issued for specific jobs.
-- If set to true, the player will receive the payment; if false, the payment is transferred to the business's bank account.
Config.PlayerFeeJobs = {
    ["police"] = false,  -- Police job: The player does not receive the fee from issued billing 
    ["taxi"] = true,     -- Taxi job: The player receives the fee from issued billing.
}


-- JOBs that will use the Business APP
-- billingpay = Authority to pay billing issued to the jobs
Config.UseBusinessJobs = {
    ["police"] = {
        billingview = 1,
        billingcreate = 1,
        billingdelete = 4,
        employeview = 4,
        employechangerank = 4,
        employefire = 4,
        employeadd = 4,
        earningview = 4,
        jobrequest = 1,
        businessAuth = 4,
        billingpay = 4,
    },
    ["sasp"] = {
        billingview = 1,
        billingcreate = 1,
        billingdelete = 4,
        employeview = 4,
        employechangerank = 4,
        employefire = 4,
        employeadd = 4,
        earningview = 4,
        jobrequest = 1,
        businessAuth = 4,
        billingpay = 4,
    },
    ["sheriff"] = {
        billingview = 1,
        billingcreate = 1,
        billingdelete = 4,
        employeview = 4,
        employechangerank = 4,
        employefire = 4,
        employeadd = 4,
        earningview = 4,
        jobrequest = 1,
        businessAuth = 4,
        billingpay = 4,
    },
    ["ambulance"] = {
        billingview = 1,
        billingcreate = 1,
        billingdelete = 4,
        employeview = 4,
        employechangerank = 4,
        employefire = 4,
        employeadd = 4,
        earningview = 4,
        jobrequest = 1,
        businessAuth = 4,
        billingpay = 4,
    },
    ["firefighter"] = {
        billingview = 1,
        billingcreate = 1,
        billingdelete = 4,
        employeview = 4,
        employechangerank = 4,
        employefire = 4,
        employeadd = 4,
        earningview = 4,
        jobrequest = 1,
        businessAuth = 4,
        billingpay = 4,
    },
    ["mechanic"] = {
        billingview = 2,
        billingcreate = 2,
        billingdelete = 2,
        employeview = 2,
        employechangerank = 2,
        employefire = 2,
        employeadd = 2,
        earningview = 2,
        jobrequest = 2,
        businessAuth = 2,
        billingpay = 2,
    }
}

-- messageView = Authority according to job grade level
-- messageSend = Authority according to job grade level
-- reportView = Authority according to job grade level
-- reportDeleteAll = Authority according to job grade level
-- location = Location of the job center
-- label = Name of the job center
-- openClosingAuth = Authority according to job grade level (Turning Dispatch open and close)
-- isOpen = This profession can receive messages and reports while the server is just starting up. (true/false)
Config.JOBDispatch = {
    --[[ ["police"] = { messageView = 2, messageSend = 2, reportView = 2, reportDeleteAll = 2, openClosingAuth = 2, location = vector4(0,0,0,0), label = "Police", isOpen = true },
    ["ambulance"] = { messageView = 2, messageSend = 2, reportView = 2, reportDeleteAll = 2, openClosingAuth = 2, location = vector4(0,0,0,0), label = "EMS", isOpen = true },
    ["mechanic"] = { messageView = 2, messageSend = 2, reportView = 2, reportDeleteAll = 2, openClosingAuth = 2, location = vector4(0,0,0,0), label = "Mechanic", isOpen = true }
}

Config.IsDispatchAutoOpenClose = true -- Set to true if you want to enable auto open/close dispatch
Config.DispatchAutoIgnoredJobs = {   -- Add here the jobs for which you want to ignore automatic on/off
    ["police"] = true,
    ["ambulance"] = true,
    ["mechanic"] = false ]]
}

--- Casino APP Settings ---

Config.Casino = {
    Tax = 20, -- Commission for chip sales
    RollMaxBet = 5000, -- Maximum bet amount for roll
}
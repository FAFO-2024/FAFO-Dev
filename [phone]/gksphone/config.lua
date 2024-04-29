Config = Config or {}

--- ### Framework Settings ### ---

Config.QBCoreNewversion = true

if Config.QBCoreNewversion then
    Config.CoreName = "QBCore"
    Config.Core = exports['qb-core']:GetCoreObject()
    Config.CoreNotify = "QBCore:Notify"
else
    Config.CoreName = "QBCore:GetObject"
    Config.Core = nil
    TriggerEvent(Config.CoreName, function(obj) Config.Core = obj end)
    Config.CoreNotify = "QBCore:Notify"
end

--- ### Phone settings ### ---

Config.KeyMapping       = true                 --## This setting is for those using slotted inventory. (Prevents key operation)
Config.OpenPhone        = 'm'                 --## Phone open key ## https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.Locale           = 'en'
Config.RegisterCommand  = "TooglePhone"        -- commandName
Config.ItemName         = {           -- # item name
                            "phone",
                            "pink_phone",
                            "gold_phone"
                        }
Config.ChargeItemName   = "powerbank"           --- PowerBank Item Name
Config.PropActive       = true
Config.CryptoName       = "qbit"
Config.HospitalAmbulanceAlert = true
Config.Fahrenheit       = true
Config.EyeTarget        = true                 -- required qb-target (You can use it for contacts sharing and phone booth)
Config.TargetExport     = "qb-target"           -- exports["qb-target"]  -- Resource Name
Config.UsableItem       = true                  -- If you want to use without items set it to false
Config.OxInvetory       = false                 -- Set to true if you are using Ox Inventory
Config.AirDropID        = false                -- Activate the AirDrop feature if you want the player to see the ID.
Config.AutoMessageDelete    = false             -- Automatically deletes messages (Messages,Mail,Group Messages,Tinder Messages,Advertising)
Config.AutoDeleteTime       = 4                -- How many days ago you want to delete data
Config.AutoWantedTime       = 4                -- How many days ago you want to delete data (Automatic deletion of wanted people in MDT application after how many days if deletion is forgotten)
Config.WaitPhone            = 2                -- Cycle time when phone is on
Config.Signal               = true             -- Signal system (phone downtime in some areas)

--- ### Voice settings ### ---

Config.MumbleExport     = "mumble-voip"       -- exports["mumble-voip"] -- Resource Name
Config.PMAVoiceExport   = "pma-voice"         -- exports["pma-voice"]   -- Resource Name
Config.PMAVoice         = true               -- Use Pma-Voice Resource (Recomended!) https://github.com/AvarianKnight/pma-voice
Config.UseMumbleVoIP    = false               -- Use Frazzle's Mumble-VoIP Resource https://github.com/FrazzIe/mumble-voip
Config.UseTokoVoIP      = false
Config.SaltyChat        = false               -- SaltyChat (Only v2.6 and lower | Not tested in v2.6 higher versions)

--- ## CALL COMMAND ### ---
Config.OnlineContactPlayers = true    -- Activate to see active players in the contacts
Config.CallAnswer = "answer"  -- quick answer (registercommand)
Config.EndCall = "endcall"  -- to close call (registercommand)

Config.SpecificNumberOn = false  --- If you want the SpecificNumber function to work, enable it
 -- When this number is called the trigger on the doc page will work.
 -- server : https://docs.gkshop.org/gksphone/developers/server-event#specific-number
 -- client : https://docs.gkshop.org/gksphone/developers/client-event#specific-number
Config.SpecificNumber = {
    ["5555555"] = true
}



-- ### TAXI APP ### ---
Config.TaxiPrice        = 100000000    -- Taxi Price ( 75$/KM )
Config.TaxiJobCode      = "taxi"  -- Job Code

-- ### House APP ### ---
Config.loafHouse        = false   -- Activate if you are using Loaf House (https://store.loaf-scripts.com/package/4310850)
Config.bcs_housing      = false   -- Activate if you are using BCS Housing (https://masbagus.tebex.io/package/5090952)

-- ### BANK APP ### ---
Config.BankTransferCom      = 5     -- Bank transfer commission rate
Config.OfflineBankTransfer  = false

---### Dispatch ### ---

-- cd_dispatch => Codesign Dispatch (https://codesign.pro/package/4206357)
-- ps-dispatch => Project-Sloth (https://github.com/Project-Sloth/ps-dispatch)
Config.Dispatch       = "cd_dispatch"

-- ### GARAGE APP ### ---
Config.qbGarages        = false   -- Set to false if you are not using qb-garages
Config.cdGarages        = true  -- Activate if you are using Codesign Garage (https://codesign.pro/package/4206352)
Config.loafGarages      = false  -- Activate if you are using Loaf Garage (https://store.loaf-scripts.com/package/4310876)

Config.OwnedVehicles    = "player_vehicles"   -- ## SQL TABLE NAME (VEHICLES)
Config.ValespawnRadius  = 170.0   -- Distance to spaw your car
Config.ValePrice        = 100    -- Vale Price
Config.ValeNPC          = false   -- Activate if you want the valet to bring the car to you.
Config.ImpoundVale      = true   -- Set to true to not fetch impounded cars

Config.ClassList = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}
Config.Carhashdebug = false  -- car hash (f8)

-- ### CAR SELLER ### ---

Config.OfflineCarSeller = false
Config.DefaultGarage = "pillboxgarage"  -- The garage where the car will go when a car is purchased
Config.CarsellerTax = 10

Config.CarsSellerBlacklist = {
    [-16948145] = false, -- car hash and true/false
    [1234311532] = false
}

Config.CarSellerClassBlock = {
    ["Emergency"] = true,
    ["Super"] = false
}




-- ### Advertising APP ### ---
Config.AdvertisingPrice = 300
Config.AdvertisingSendBlockCommand = "blockAdd" -- (/blockAdd true/false)

-- ### Twitter APP ### ---
Config.TwitterVerifyCommand = "twitterverify"   -- (/twitterverify true/false username) yellow tick
Config.TwitterSendBlockCommand = "blocktwitter" -- (/blockTwitter true/false)
Config.TwitterSendBanCommand = "bantwitter" -- (/bantwitter true/false username)
Config.TwitterSubsDate = 7 -- Twitter subs subscription renewal time
Config.TwitterSubsPay = 10000 -- Twitter Subscription fee

-- ### Instagram APP ### ---
Config.InstagramVerifyCommand = "instagramverify"  -- (/instagramverify true/false username)
Config.InstagramSendBlockCommand = "blockInstagram" -- (/blockInstagram true/false)

-- ### Race APP ### ---
Config.RaceAutCommand = "raceaut"
Config.qbcoreaut = "god"  --- qb-core authorization system

-- ### Charge ### --- (/charge playerid charge(0-100))
Config.ChargeAutCommand = "charge"
Config.qbcorechargeaut = "god"  --- qb-core authorization system

-- ### Number Change ### ---
Config.NewNumberChange = "phonenumberchange" -- /phonenumberchange playerid newnumber


-- ## PHONE Box -- ##

Config.PhoneBox = false
Config.PhoneBoxKey = "E"
Config.PhoneBoxRegCom = "phonebox"
Config.PhoneBoothMoney = { actived = true, money = 500 }
Config.PhoneBoothModel = {
	[1281992692] = true,
    [1158960338] = true,
    [295857659] = true,
    [-78626473] = true,
    [-2103798695] = true,
    [1511539537] = true,
    [-1559354806] = true
}
Config.PhoneBootNumber = "22222"



--## Crypto ##--


-- Cryptos to use
-- You can add or turn off any crypto you want. (https://api.coingecko.com/api/v3/coins/list?include_platform=false) Crypto list that can be added
-- The id option will be the first value, and the second value will be true or false.
Config.Crytos = {
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

---##  Spam ## ---

Config.SpamLimit = 6  -- Default: 6
Config.SpamReset = 10  -- seconds
Config.SpamPlayerKick = true
Config.SpamDropPlayer = "You were kicked from the server for spamming too much"


-- ### Business APP ### ---

-- JOBs that will use the Business APP
Config.UseBusinessJobs = {
    --[[     motorworks = true, ]]
    whitewidow = true,
    repair = true,
    lawyer =  true,
    police = true,
    ambulance = true,  
    brewery = true, 
    darko = true,
    catcafe = true,
    burgershot = true,
--[[     beanmachine = true, ]]
--[[     thb = true, ]]
    vanilla = true,
    racing = true,
    cosmetic = true,
    bahama = true,
    wingbrake = true,
    icebox = true,
    fire = true,
    jwc = true,
    was = true,
    sanders = true,
    pearl = true,
    used = true,
    rea = true,
    doj = true,
    upnatom = true,
    henhouse = true,
    emeraldbar = true,
    cluckinbell = true,
    towing = true,
    popsdiner = true
}


Config.UseBillingCommission = true  -- Invoice commission true/false
-- This is a percentage (0.10) == 10% ( Must be active to receive commission - If the player is not in the game, she/he cannot receive a commission.)
Config.BillingCommissions = {
   --[[     motorworks = 0.70, ]]
   whitewidow = 0.50,
   repair = 0.65,
   police = 0.30,
   ambulance = 0.60,   
   brewery = 0.70, 
   wingstop = 0.75,
   darko = 1.0,
   catcafe = 0.70,
   burgershot = 0.70,
--[[     beanmachine = 0.70, ]]
--[[     thb = 0.70, ]]
   vanilla = 0.70,
   racing = 0.70,
   cosmetic = 0.70,
   bahama = 0.70,
   wingbrake = 0.70,
   icebox = 0.30,
   fire = 0.70,
   jwc = 0.70,
   was = 0.70,
   sanders = 0.70,
   pearl = 0.70,
   used = 0.50,
   rea = 1.0,
   doj = 0.75,
   upnatom = 0.75,
   henhouse = 0.70,
   emeraldbar = 0.70,
   cluckinbell = 0.70,
   towing = 0.70,
   popsdiner = 0.70

}


-- People who can use the application at a high level (jobs and lowest rank)
Config.JobGrade  = {
    ["police"] = 11,
    ["ambulance"] = 6,
--[[     ["motorworks"] = 4, ]]
    ["darko"] = 1,
    ["car"] = 1,
    ["cosmetic"] = 4,
    ["vanilla"] = 3,
    ["whitewidow"] = 3,
    ["doj"] = 2,
    ["icebox"] = 1,
    ["wingstop"] = 4,
    ["burgershot"] = 3,
    ["catcafe"] = 4,
    ["wingbrake"] = 4,
    ["bahama"] = 4,
    ["fire"] = 5,
--[[     ["beanmachine"] = 0, ]]
    ["jwc"] = 4,
    ["sanders"] = 2,
    ["pearl"] = 4,
    ["rea"] = 2,
    ["used"] = 2,
    ["henhouse"] = 2,
    ["upnatom"] = 4,
    ["was"] = 5,
    ["emeraldbar"] = 3,
    ["cluckinbell"] = 3,
    ["popsdiner"] = 4
}


--- ## Live APP --- ##

Config.LiveAPPDonateTax = 0.20 -- deduction rate from incoming money
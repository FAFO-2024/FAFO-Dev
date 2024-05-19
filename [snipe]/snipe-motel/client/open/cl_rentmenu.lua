local function RentRoom()
    local input = lib.inputDialog(Locales["rent_room"], {
        { type = 'number', label = Locales["enter_days_input"], min = 1 }
    })

    if input then
        local days = tonumber(input[1])

        local hasAvailableRooms = lib.callback.await("snipe-apartments:server:hasAvailableRooms", false)
        if not hasAvailableRooms then ShowNotification(Locales["no_roooms_available"], "error") return end

        local roomData = lib.callback.await("snipe-apartments:server:rentRoom", false, days)
        if not roomData then ShowNotification(Locales["not_enough_money_notify"], "error") return end
        currentPlayerRoomNumber = roomData[1]
        roomExpiry = roomData[2]
        roomTime = roomData[3] -- use this later to run a thread to check if room is expired
        ShowNotification(string.format(Locales["rented_for_notify"], days, currentPlayerRoomNumber), "success")
    end
end

local function ReRentRoom()
    local input = lib.inputDialog(Locales["rent_room"], {
        { type = 'number', label = Locales["enter_days_input"], min = 1 }
    })

    if input then
        local days = tonumber(input[1])

        local hasAvailableRooms = lib.callback.await("snipe-apartments:server:hasAvailableRooms", false)
        if not hasAvailableRooms then ShowNotification(Locales["no_roooms_available"], "error") return end

        local roomData = lib.callback.await("snipe-apartments:server:rentRoom", false, days, true, graceTime)
        if not roomData then ShowNotification(Locales["not_enough_money_notify"], "error") return end
        currentPlayerRoomNumber = roomData[1]
        roomExpiry = roomData[2]
        roomTime = roomData[3] -- use this later to run a thread to check if room is expired
        ShowNotification(string.format(Locales["rented_for_notify"], days, currentPlayerRoomNumber), "success")
    end
end

local function ExtendRoom()
    local input = lib.inputDialog(Locales["extend_room_input"], {
        { type = 'number', label = Locales["enter_days_input"], min = 1 }
    })

    if input then
        local days = tonumber(input[1])
        roomData = lib.callback.await("snipe-apartments:server:extendRoom", false, days)
        if not roomData then ShowNotification(Locales["not_enough_money_notify"], "error") return end
        roomExpiry = roomData[1]
        roomTime = roomData[2] -- use this later to run a thread to check if room is expired
        ShowNotification(string.format(Locales["extended_room_notify"], days, currentPlayerRoomNumber), "success")
    end
end


-- if you edit this and break the script, make sure to redownload the file from keymaster. 
-- DO NOT EDIT IF YOU DONT KNOW WHAT YOU ARE DOING!!!!
function OpenMotelMenu()
    local options = {}

    if currentPlayerRoomNumber then
        options[#options+1] = {
            title = Locales["current_room_header"],
            description = string.format(Locales["current_room_number"], currentPlayerRoomNumber),
            disabled = true
        }
    end

    if not currentPlayerRoomNumber then
        if not onGrace then
            options[#options + 1] = {
                title = Locales["rent_room_menu"],
                onSelect = function()
                    RentRoom()
                end
            }
        else
            -- graceTime
            options[#options + 1] = {
                title = "Grace Period",
                description = string.format("You have %s days to pay the grace amount and rent before your room is unassigned. If not paid, your furniture will be removed as well!", Config.GracePeriod - graceTime),
                onSelect = function()
                    ReRentRoom()
                end
            }
        end

    end
    if currentPlayerRoomNumber and Config.RequireMoneyToRent then
        options[#options+1] = {
            title =  Locales["extend_room_menu"],
            description = string.format(Locales["current_room_validity_menu"], roomExpiry),
            onSelect = function()
                ExtendRoom()
            end
        }
    end

    if Config.AllowKeys then
        options[#options+1] = {
            title =  "Keys",
            description = "See which rooms you have access to",
            onSelect = function()
                CheckKeys()
            end
        }
    end

    lib.registerContext({
        id = "snipe_apartments_motel",
        title = Locales["motel_header_menu"],
        options = options
    })
    lib.showContext("snipe_apartments_motel")
end



function CheckKeys()
    if not next(keys) then
        ShowNotification("You dont have any available keys!", "error")
        lib.showContext("snipe_apartments_motel")
        return
    end
    local options = {}
    for k, v in pairs(keys) do
        options[#options+1] = {
            title = "Room Number "..k,
            description = "Room Owner: "..v,
            disabled = true
        }
    end

    lib.registerContext({
        id = "snipe_motel_key_check",
        title = "Available Keys",
        options = options,
        menu = "snipe_apartments_motel"
    })

    lib.showContext("snipe_motel_key_check")
end
function IsAllowedToRaid()
    return Config.RaidableJobs[PlayerJob.name] or false
end

function CheckApartment()
    local input = lib.inputDialog("Enter ID to get the Room Number", {
        { type = 'number', label = "Enter Person ID", min = 1 }
    })
    if input then
        local id = tonumber(input[1])
        local roomNumber = lib.callback.await("snipe-apartments:server:getRoomNumber", false, id)
        if roomNumber then
            ShowNotification("Room Number assigned to ID: " .. input[1].. " is " .. roomNumber, "success")
        
        else
            ShowNotification("Invalid ID or Room is not assigned to the person!", "error")
        end
    end
end

function Lockdown()
    local input = lib.inputDialog("Enter Room Number to Lockdown", {
        { type = 'number', label = "Room Number", min = 1 }
    })
    if input then
        local id = tonumber(input[1])
        if not Locations[id] then
            ShowNotification("Invalid Room number", "error")
            return
        end
        local success = lib.callback.await("snipe-apartments:server:lockdownRoom", false, id, true)
        if success then
            ShowNotification("Room ".. input[1].. " is now locked down!", "success")
        else
            ShowNotification("Invalid Room number!", "error")
        end
    end
end

function CheckLockdownRooms()
    local options = {}
    for k, v in pairs(Locations) do
        if v.lockdown then
            table.insert(options, {
                title = "Room " .. k,
                description = "Room is locked down. Click to unlock!",
                onSelect = function()
                    lib.callback.await("snipe-apartments:server:lockdownRoom", false, k, false)
                    ShowNotification("Room is now unlocked!", "success")
                end,
            })
        end
    end
    if #options == 0 then
        ShowNotification("No rooms are locked down!", "error")
        return
    end
    lib.registerContext({
        id = "snipe_motel_lockdown_rooms",
        title = "Locked Down Rooms",
        options = options
    })
    lib.showContext("snipe_motel_lockdown_rooms")
end

RegisterCommand("raidmotel", function()
    if not IsAllowedToRaid() then
        ShowNotification("You are not allowed to use this command!", "error")
        return
    end
    local options = {}
    options[#options+1] = {
        title = "Check Apartment Number for Person!",
        onSelect = function()
            CheckApartment()
        end,
    }
    options[#options+1] = {
        title = "Lockdown Room",
        onSelect = function()
            Lockdown()
        end,
    }
    options[#options+1] = {
        title = "Check Lockdown Rooms",
        onSelect = function()
            CheckLockdownRooms()
        end,
    }
    lib.registerContext({
        id = "snipe_motel_raid",
        title = "Motel Raid Options",
        options = options
    })
    lib.showContext("snipe_motel_raid")
end)
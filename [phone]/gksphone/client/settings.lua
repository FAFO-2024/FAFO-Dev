-- GKSPHONE | @GKSHOPTeam | discord.gg/XUck63E

--- Function to give a key to a car
--- @param callback_vehicle table The vehicle for which the key is being given
function GiveKeyCar(callback_vehicle)
  TriggerEvent("vehiclekeys:client:SetOwner", Config.Core.Functions.GetPlate(callback_vehicle))
end

--- Sets the fuel level of a vehicle using the LegacyFuel resource.
--- @param callback_vehicle number The callback vehicle ID.
--- @param vehicle table The vehicle object containing the fuel level.
function SetFuel(callback_vehicle, vehicle)
  if GetResourceState('LegacyFuel') == 'started' then
    exports['LegacyFuel']:SetFuel(callback_vehicle, vehicle.fuel)
  end
end


--- Displays a framework notification.
--- @param text string The text to display in the notification.
--- @param notifType string The type of notification (e.g., "success", "error", "primary").
--- @param length number The length of time the notification should be displayed (in milliseconds).
function FreamworkNotification(text, notifType, length)
  notifType = notifType or "success"
  length = length or 5000
  Config.Core.Functions.Notify(text, notifType, length)
end

--- Function that will run after Dispatch confirms the sending
--- @param message string The message to send.
--- @param job string The job of the sender.
--- @param isAnonymous boolean Whether the sender is anonymous.
--- @param myPos table The position of the sender.
--- @param street string The street of the sender.
function SendDispatch(message, job, isAnonymous, myPos, street)
  if GetResourceState('cd_dispatch') == 'started' then
      local plyrdata = exports['cd_dispatch']:GetPlayerInfo()
      TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = {job},
            coords = plyrdata.coords,
            title = 'Notification sent over the phone',
            message = message,
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
            blip = {
                sprite = 817,
                scale = 1.2,
                colour = 3,
                flashes = false,
                text = 'Notification phone',
                time = (5*60*1000),
                sound = 1,
            }
      })
  elseif GetResourceState('ps-dispatch') == 'started' then
        TriggerServerEvent("dispatch:server:notify",{
            codeName = "911call",
            code = "911",
            icon = 'fas fa-phone',
            street = street,
            priority = 2,
            coords = myPos,
            message = "Notification sent over the phone",
            information = message,
            jobs = job
        })
  end
end
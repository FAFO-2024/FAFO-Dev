

function ShowNotification(msg, type)
    lib.notify({description = msg, type = type})
end

-- this function runs in thread when near the edit point area
function onNearby(point)
    if point.isClosest and point.currentDistance < 1.2 and IsControlJustReleased(0, 38) then
        OpenStashOutfitOptions()
    end
    if point.isClosest and point.currentDistance < 5.0 then
        SetDrawOrigin(point.coords.x, point.coords.y, point.coords.z + 0.4)
        DrawSprite(Sprites["edit"].textDict, Sprites["edit"].textName, 0, 0, Sprites["edit"].width, Sprites["edit"].height, 0, 255, 255,255, 500)
        ClearDrawOrigin()
    end
end

-- this function runs in thread when near the edit stash point
function onNearbyStash(point)
    if point.isClosest and point.currentDistance < 1.2 and IsControlJustReleased(0, 38) then
        OpenStash(point.stashId)
    end
    if point.isClosest and point.currentDistance < 5.0 then
        SetDrawOrigin(point.coords.x, point.coords.y, point.coords.z + 0.4)
        DrawSprite(Sprites["stash"].textDict, Sprites["stash"].textName, 0, 0, Sprites["stash"].width, Sprites["stash"].height, 0, 255, 255,255, 500)
        ClearDrawOrigin()
    end
end
-- this function runs in thread when near the edit outfit point
function onNearByOutfit(point)
    if point.isClosest and point.currentDistance < 1.2 and IsControlJustReleased(0, 38) then
        OpenOutfit()
    end
    if point.isClosest and point.currentDistance < 5.0 then
        SetDrawOrigin(point.coords.x, point.coords.y, point.coords.z + 0.4)
        DrawSprite(Sprites["clothing"].textDict, Sprites["clothing"].textName, 0, 0, Sprites["clothing"].width, Sprites["clothing"].height, 0, 255, 255,255, 500)
        ClearDrawOrigin()
    end
end

-- triggered once you enter elevator
function onEnterElevator(self)
    local floorNumber, elevatorNumber = extractFloorNumbers(self.name)
    currentFloor = tonumber(floorNumber)
    currentElevator = tonumber(elevatorNumber)
    inElevator = true
    lib.showTextUI("[E] Elevator")
    CreateThread(function()
        while inElevator do
            if IsControlJustReleased(0, 38) then
                OpenElevatorMenu(currentFloor, currentElevator)
            end
            Wait(0)
        end
    end)
end

-- triggered once you leave elevator
function onExitElevator(self)
    lib.hideTextUI()
    inElevator = false
end


-- target for stash and outfits and main menu

function CreateTarget(coords, type, boxZoneName, stashId)
    if Config.TargetOrInteract and GetResourceState("interact") == "started" then
        local interactionId = exports.interact:AddInteraction({
            coords = coords,
            distance = 8.0, -- optional
            interactDst = 1.0, -- optional
            options = {
                {
                    label = (type == "outfit" and "Open Outfit" or type == "stash" and "Open Stash" or "Open Room Menu"),
                    action = function()
                        if type == "outfit" then
                            OpenOutfit()
                        elseif type == "stash" then
                            OpenStash(stashId)
                        elseif type == "main" then
                            OpenStashOutfitOptions()
                        end
                    end,
                },
            }
        })
        return interactionId
    else
        exports["qb-target"]:AddBoxZone(boxZoneName, coords, 1.0, 1.0, {
            name = boxZoneName,
            heading=0,
            debugPoly=false,
            minZ=coords.z - 0.95,
            maxZ=coords.z + 0.95
        }, {
            options = {
                {
                    action = function()
                        if type == "outfit" then
                            OpenOutfit()
                        elseif type == "stash" then
                            OpenStash(stashId)
                        elseif type == "main" then
                            OpenStashOutfitOptions()
                        end
                    end,
                    icon = (type == "outfit" and "fas fa-tshirt" or type == "stash" and "fas fa-box" or "fas fa-tablet"),
                    label = (type == "outfit" and "Open Outfit" or type == "stash" and "Open Stash" or "Open Room Menu"),
                }
            },
            distance = 1.5
        })
        return nil
    end
end

function RemoveTarget(boxZoneName, type)
    if Config.TargetOrInteract and GetResourceState("interact") == "started" then
        if type == "outfit" then
            exports.interact:RemoveInteraction(interactionOutfit)
        elseif type == "stash" then
            exports.interact:RemoveInteraction(interactionStash)
        elseif type == "main" then
            exports.interact:RemoveInteraction(interactionMain)
        end
    else
        exports["qb-target"]:RemoveZone(boxZoneName)
    end
    
end
    
CreateThread(function()
    coords = vec3(-701.84, -2267.54, 13.46)
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, 183)
    SetBlipColour(blip, 3)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Opium Nights")
    EndTextCommandSetBlipName(blip)
end)

RegisterCommand("checkroomnumber", function()
    if not currentPlayerRoomNumber then
        ShowNotification("You dont have an assigned room!", "error")
        return 
    end
    ShowNotification("Your current room number is: "..currentPlayerRoomNumber, "info")
end)

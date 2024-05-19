local function isInRoom()
    return inApartmentRoom ~= nil and inApartmentRoom or false
end
exports("isInRoom", isInRoom)

local function currentPlayerRoom()
    return currentPlayerRoomNumber ~= nil and currentPlayerRoomNumber or false
end
exports("currentPlayerRoom", currentPlayerRoom)
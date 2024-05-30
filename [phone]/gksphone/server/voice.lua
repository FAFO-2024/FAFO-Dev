--- Starts a voice call on the server.
--- @param callIndex number The index of the call.
--- @param source number The source of the call.
function ServerVoiceStartCall(callIndex, source)
    if Config.SaltyChat then
        exports["saltychat"]:AddPlayerToCall(tostring(callIndex), source)
    end
end

--- Sets the phone speaker for a player.
--- @param source number The player's source.
--- @param isSpeak boolean indicating whether the player is speaking or not.
function ServerVoiceSpeaker(source, isSpeak)
    if Config.SaltyChat then
        exports["saltychat"]:SetPhoneSpeaker(source, isSpeak)
    end
end

--- Function to end a voice call on the server side
--- @param callIndex number The index of the call
--- @param source number The source of the call
function ServerVoiceEndCall(callIndex, source)
    if Config.SaltyChat then
        exports["saltychat"]:RemovePlayerFromCall(tostring(callIndex), source)
    end
end
--- Starts a voice call on the client.
--- @param callIndex number - The index of the call channel.
function ClientVoiceStartCall(callIndex)
    if Config.UseMumbleVoIP then
        exports[Config.MumbleExport]:SetCallChannel(callIndex)
    elseif Config.PMAVoice then
        exports[Config.PMAVoiceExport]:setCallChannel(callIndex)
    end
end

--- Ends the ongoing voice call.
function ClientVoiceEndCall()
    if Config.UseMumbleVoIP then
        exports[Config.MumbleExport]:SetCallChannel(0)
    elseif Config.PMAVoice then
        exports[Config.PMAVoiceExport]:removePlayerFromCall()
    end
end
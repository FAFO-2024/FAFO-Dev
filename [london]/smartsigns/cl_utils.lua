pedId = 0
pedCoords = 0

function nearAccessPoint(k, v, ped, pedCoords)
    Draw3DText(v.pos.x + config.main.signOffset[1], v.pos.y + config.main.signOffset[2], v.pos.z + config.main.signOffset[3], config.main.instructionalText, 4, 0.05, 0.05)
    if IsControlJustPressed(config.main.adjustButton[1], config.main.adjustButton[2]) then
        if config.main.developerMode then
            print("[Smart Signs] - Access point control pressed")
        end
        if config.main.animation.enabled then
            if config.main.developerMode then
                print("[Smart Signs] - Animation Enabled - Starting")
            end

            local boxPosition = vec3(0.0, 0.0, 0.0)
            if v.side == "left" then
                boxPosition = GetOffsetFromEntityInWorldCoords(v.prop, -1.55, 0.0, 0.0)
                SetEntityHeading(ped, v.heading - 90.0)
            else
                boxPosition = GetOffsetFromEntityInWorldCoords(v.prop, 1.55, 0.0, 0.0)
                SetEntityHeading(ped, v.heading + 90.0)
            end
            SetEntityCoords(ped, boxPosition.x, boxPosition.y, boxPosition.z, true, true, true, false)
            if config.main.developerMode then
                print("[Smart Signs] - Ped Coords Set")
            end
            RequestAnimDict(config.main.animation.dict)
            if config.main.developerMode then
                print("[Smart Signs] - Requesting Animation Dictionary: "..config.main.animation.dict)
            end
            while not HasAnimDictLoaded(config.main.animation.dict) do 
                if config.main.developerMode then
                    print("[Smart Signs] - Loading Animation Dictionary: "..config.main.animation.dict)
                end
                Wait(0) 
            end
            if config.main.developerMode then
                print("[Smart Signs] - Loaded Animation Dictionary: "..config.main.animation.dict)
            end
            if config.main.developerMode then
                print("[Smart Signs] - Playing Animation Name: "..config.main.animation.name)
            end
            TaskPlayAnim(ped, config.main.animation.dict, config.main.animation.name, 8.0, -8.0, -1, 0, 0.0, 0, 0, 0)
        end
        local inputs = {}
        for i = 1, config.letterPositions.numberOfLines do 
            if config.main.developerMode then
                print("[Smart Signs] - Starting user input for line: "..i)
            end
            inputs[i] = getInput(i)
            if config.main.developerMode then
                print("[Smart Signs] - User input returned: "..tostring(inputs[i]))
            end
        end
        local streetHash = GetStreetNameAtCoord(pedCoords.x, pedCoords.y, pedCoords.z)
        local streetName = GetStreetNameFromHashKey(streetHash)
        if config.main.developerMode then
            print("[Smart Signs] - Street Hash: "..tostring(streetHash))
            print("[Smart Signs] - Street Name: "..tostring(streetName))
        end
        if config.main.developerMode then
            print("[Smart Signs] - Data for Sign ID: "..k.." sent to server")
        end
        TriggerServerEvent("SmartSigns:updateSign", k, inputs, tostring(streetName))
        ClearPedTasks(ped)
        if config.main.soundEffect.enabled then
            PlaySoundFrontend(-1, config.main.soundEffect.name, config.main.soundEffect.dict)
            if config.main.developerMode then
                print("[Smart Signs] - Playing sound: Name: "..config.main.soundEffect.name.." - Dict: "..config.main.soundEffect.dict)
            end
        end
    end
end

function getSide()
    AddTextEntry('FMMC_MPM_NA', "Which side for the support? (left/right):")
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Which side for the support? (left/right):", "", "", "", "", 14)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local input = GetOnscreenKeyboardResult()
        return string.lower(input)
    end
end


function getInput(i)
    AddTextEntry('FMMC_MPM_NA', "Enter text for line " .. i)
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Enter text for line" .. i, "", "", "", "", 14)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0);
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        local input = GetOnscreenKeyboardResult()
        return string.lower(input)
    end
end

function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local coords = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(coords.x,coords.y,coords.z, x,y,z, 1)    
    local scale = (1 / distance ) * 20
    local fov = ( 1 / GetGameplayCamFov() ) * 100
    local scale = scale * fov
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function showNotification(message)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

local nearAnAccessPoint = false


Citizen.CreateThread(function()
    Wait(3000)
    while true do
        Wait(1000)
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)

        local nearAnAccessPointLocal = false

        for k, v in pairs(SmartSigns) do
            local signCoords = vector3(v.pos.x, v.pos.y, v.pos.z)
            local distance = #(signCoords - pedCoords)
            SmartSigns[k].distance = #(signCoords - pedCoords)
            if distance < config.main.accessPointDistance then
                if not SmartSigns[k].runningAccessPointCheck then
                    SmartSigns[k].runAccessPointCheck()
                end
            else
                if SmartSigns[k].runningAccessPointCheck then
                    SmartSigns[k].runningAccessPointCheck = false
                end
            end
            if distance <= config.main.loadInDistance and SmartSigns[k].prop == 0 then
                if config.main.developerMode then
                    print("[Smart Signs] - Loaded Sign ID: "..k)
                end
                SmartSigns[k].loadSign()
            elseif distance > config.main.loadInDistance and v.loaded then
                if config.main.developerMode then
                    print("[Smart Signs] - Unloaded Sign ID: "..k)
                end
                SmartSigns[k].unloadSign()
            end
        end
        if not nearAnAccessPointLocal then
            nearAnAccessPoint = false
        end
    end
end)

function devPrint(text)
    if main.developerMode then
        print(text)
    end
end

function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0) 
    end
end

if config.main.developerMode then
	TriggerEvent('chat:addSuggestion', '/newsmartsign', 'Setup a new smart sign')
    RegisterCommand("newsmartsign", function()

        local side = getSide()
        local model = nil   
        while side ~= "left" and side ~= "right" do
            showNotification("Invalid side, please enter 'left' or 'right'")
            side = getSide()
        end

        print("onwards!")

        if side == "left" then
            model = config.main.signModelName.left
        else
            model = config.main.signModelName.right
        end

        loadModel(model)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local signProp = CreateObject(model, coords, true, false, false)

        while not DoesEntityExist(signProp) do Wait(0) end
        
        FreezeEntityPosition(signProp, true)

        SetEntityCoords(signProp, coords.x + 0.0, coords.y + 2.0, coords.z + 0.0, true, true, true, false)

        local heading = GetEntityHeading(ped)

        SetEntityHeading(signProp, ped)

        SetModelAsNoLongerNeeded(model)

        local complete = false

		local speed = nil

        while not complete do

			Citizen.CreateThread(function()
				local form = setupScaleform("instructional_buttons")
				while not complete do
					DrawScaleformMovieFullscreen(form, 255, 255, 255, 255, 0)
					Wait(0)
				end
			end)

            local coords = GetEntityCoords(signProp)
            local heading = GetEntityHeading(signProp)

            if IsControlJustPressed(0, 207) then --page down -- MOVE OBJECT DOWN
                SetEntityCoords(signProp, coords.x, coords.y, coords.z - 0.2)
            end
                
            if IsControlJustPressed(0, 208) then --page up -- MOVE OBJECT UP
                SetEntityCoords(signProp, coords.x, coords.y, coords.z + 0.2)
            end

            if IsControlJustPressed(0, 173) then --arrow down -- MOVE OBJECT BACKWARDS
                SetEntityCoords(signProp, coords.x, coords.y - 0.2, coords.z)
            end

            if IsControlJustPressed(0, 172) then --arrow up -- MOVE OBJECT FORWARDS
                SetEntityCoords(signProp, coords.x, coords.y + 0.2, coords.z)
            end

            if IsControlJustPressed(0, 174) then --arrow left -- MOVE OBJECT LEFT
                SetEntityCoords(signProp, coords.x - 0.2, coords.y, coords.z)
            end

            if IsControlJustPressed(0, 175) then --arrow right -- MOVE OBJECT RIGHT
                SetEntityCoords(signProp, coords.x + 0.2, coords.y, coords.z)
            end

            if IsControlPressed(0, 29) then --b rotate left
                SetEntityHeading(signProp, heading - 2.0)
            end

            if IsControlPressed(0, 306) then --n rotate right
                SetEntityHeading(signProp, heading + 2.0)
            end

            if IsControlJustPressed(0, 191) then -- enter - finish
                complete = true
            end

            Wait(0)
        end

		TriggerServerEvent("SmartSigns:AddNewLocation", GetEntityCoords(signProp), GetEntityHeading(signProp), side)
        DeleteObject(signProp)
        showNotification("Sign created, will be visible from next client restart.")
    end, false)
end

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end

	
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(0, 207, true))
    ButtonMessage("Down")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(0, 208, true))
    ButtonMessage("Up")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(0, 173, true))
    ButtonMessage("Backwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(0, 172, true))
    ButtonMessage("Forwards")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(0, 174, true))
    ButtonMessage("Left")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(0, 175, true)) -- The button to display
    ButtonMessage("Right") -- the message to display next to it
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(6)
    Button(GetControlInstructionalButton(0, 29, true))
    ButtonMessage("Rotate Left")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(7)
    Button(GetControlInstructionalButton(0, 306, true))
    ButtonMessage("Rotate Right")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(8)
    Button(GetControlInstructionalButton(0, 191, true))
    ButtonMessage("Confirm")
    PopScaleformMovieFunctionVoid()



    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()

    return scaleform
end
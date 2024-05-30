Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(500)
		local cars = GetGamePool('CVehicle')
        for _, car in pairs(cars) do
            local hasTrailer, vTrailer = GetVehicleTrailerVehicle(car)
            if hasTrailer and DoesEntityExist(vTrailer) then
                if GetIsVehicleEngineRunning(car) then
                    SetVehicleFuelLevel(vTrailer, 100)
              	    SetVehicleEngineOn(vTrailer, true, true, false)
              	    SetVehicleLights(vTrailer, 2)
                else
            	    SetVehicleEngineOn(vTrailer, false, true, false)
            	    SetVehicleLights(vTrailer, 0)
              	end
            end
        end
    end
end)

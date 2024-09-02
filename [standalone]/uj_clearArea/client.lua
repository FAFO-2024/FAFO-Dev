local clearPedsAndVehicle = {
	{coords = vec(-525.6090, 2002.124, 19.5630), radius = 15.0},
	-- {coords = vec(your coords), radius = your radius},
}

CreateThread(function()
	while true do
		Wait(0)

		for _,v in pairs(clearPedsAndVehicle) do
			ClearAreaOfVehicles(v.coords, v.radius)
			ClearAreaOfPeds(v.coords, v.radius, 1)
		end

	end
end)
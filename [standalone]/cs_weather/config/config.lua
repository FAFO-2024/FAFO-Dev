CodeStudio = {}
CodeStudio.AutoSQL = true

CodeStudio.TimeScale = 4000 -- How many milliseconds per minute in GTA time (2000ms is normal for a 48 minute day)
CodeStudio.StartUpTime = {   --Default Time
    hour = 12,
    minute = 0
}

CodeStudio.FreezeTime       = false  
CodeStudio.RealTimeSync     = false 

CodeStudio.DefaultWeather = 'EXTRASUNNY' -- Default weather

CodeStudio.WeatherTypes = {
    { title = "Clear", image = "clear.svg", type = "CLEAR" },
    { title = "Clouds", image = "clouds.svg", type = "CLOUDS" },
    { title = "Extra Sunny", image = "extrasunny.svg", type = "EXTRASUNNY" },
    { title = "Overcast", image = "overcast.svg", type = "OVERCAST" },
    { title = "Clearing", image = "clearing.svg", type = "CLEARING" },
    { title = "Rain", image = "rain.svg", type = "RAIN" },
    { title = "Thunder", image = "thunder.svg", type = "THUNDER" },
    { title = "Neutral", image = "neutral.svg", type = "NEUTRAL" },
    { title = "Light Snow", image = "lightsnow.svg", type = "SNOWLIGHT" },
    { title = "Snow", image = "snow.svg", type = "SNOW" },
    { title = "Blizzard", image = "blizzard.svg", type = "BLIZZARD" },
    { title = "Christmas", image = "christmas.svg", type = "XMAS" },
    { title = "Fog", image = "fog.svg", type = "FOGGY" },
    { title = "Smog", image = "smog.svg", type = "SMOG" },
    { title = "Halloween", image = "halloween.svg", type = "HALLOWEEN" },
    { title = "Random", image = "shuffle.svg", type = "RANDOM" }
}


CodeStudio.Authorized = {   --Restict Access To Weather Panel
    --group/steam/discord/any other identifier
    'discord:968848387132772434'
}


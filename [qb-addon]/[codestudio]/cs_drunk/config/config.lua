CodeStudio = {}

CodeStudio.OpenUI = {
    useCommand = false,
    Command_Name = 'atest',

    useItem = true,  --Enable ServerType in sv_function.lua
    Item_Name = 'alcohol_tester'
}


CodeStudio.Wait_TIme = 2    --Blower Waiting Time in seconds

CodeStudio.Animations = {
    Enable = true,
    Tester_Prop = `prop_inhaler_01`,

    Share_Anim = 'package_dropoff',
    Share_Dict = 'mp_safehouselost@',

    Use_Anim = 'loop',
    Use_Dict = 'mp_player_inteat@pnq'
}

CodeStudio.DrunkLevel = {
    [25] = 'green',     --Low Value [25 means upto 25 is low value of drunk]
    [70] = 'yellow',    --Mid Value
    [100] = 'red'       --High Value
}


CodeStudio.DrunkSettings = {
    Enable = true,             --Enble/Disable Drunk Value Deductions after certain time
    Reduce_Interval = 0.5,      --This will reduce alcholic level after certain minutes (In Minutes)
    Reduce_Level = 2            --Reduce Level
}


CodeStudio.DrunkEffect = true    --Enble/Disable Drunk Effect
CodeStudio.Effect_Interval = {
    --You can add more stages if you want
    [10] = {    --Drunk Level at which this Effect will occur
        Enable = true,                      --Enable/Disable Stage
        Animation = 'move_m@drunk@a'        --WalkStyle
    },
    [40] = {
        Enable = true,
        Animation = 'move_m@drunk@moderatedrunk'
    },
    [80] = {
        Enable = true,
        Animation = 'move_m@drunk@slightlydrunk'
    },
    [95] = {                     --Heavy Drunk Max Stage
        Enable = true,
        Animation = 'move_m@drunk@verydrunk'
    },
}


----Language Editor----

CodeStudio.Language = {
    wait_blow = 'WAIT',
    blow_txt = 'BLOW',
    tester_share = 'Alchohol Tester Given to Nearby Player',
    tester_smoke = 'Tell Nearest Player to Blow Air'
}
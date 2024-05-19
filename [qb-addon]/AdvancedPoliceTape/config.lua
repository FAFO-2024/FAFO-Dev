Config = {}

Config.Framework = "QBCore" -- Standalone / ESX / ESX Legacy / QBCore
Config.CommandName = 'tape' -- If Config.Framework is Standalone & not using inventory framework.
Config.InventoryItem = "tape" -- If using ESX / ESX Legacy / QBCore Inventory, this is the inventory item name.
Config.TapeMenuCommand = 'tapemenu' -- Command to open the Tape Menu

Config.WindSpeed = 5.0 -- Increase this for the tape to move quicker. Decrease for tape to move slower.

Config.DisplayEquipmentSpawnerInMenu = false
Config.Equipment = {
    {
        name = "prop_roadcone01a",
        height = 0.7 -- Height of tape when attatching to the object
    },
    {
        name = "prop_barrier_work05",
        height = 0.7 -- Height of tape when attatching to the object
    },
    {
        name = "prop_gazebo_03",
        height = 0.7 -- Height of tape when attatching to the object
    },
    {
        name = "prop_worklight_03b",
        height = 0.7 -- Height of tape when attatching to the object
    }
}

Config.Translations = {
    ['Menu'] = {
        ['Tape Menu Title']                 = 'Tape Menu',
        ['Tape Menu Description']           = 'Your tape menu',
        ['Created Tape Title']              = 'Your Created Tape',
        ['Created Tape Description']        = 'View Your Created Tape',
        ['Spawn Equipment Title']           = 'Spawn Equipment',
        ['Spawn Equipment Description']     = 'Spawn Some Equipment',
        ['Tape Type Title']                 = 'Tape Type',
        ['Tape Type Description']           = 'Choose type of tape',
        ['Delete Tapes Title']              = 'Delete All Tapes',
        ['Delete Tapes Description']        = 'Delete all tapes you have made',
        ['Delete Equipment Title']          = 'Delete All Equipment',
        ['Delete Equipment Description']    = 'Delete all equipment you have spawned',
        ['Highlight Tape Title']            = 'Highlight This Tape',
        ['Highlight Tape Description']      = 'Highlight the selected tape',
        ['Increase Height Title']           = 'Increase Height',
        ['Increase Height Description']     = 'Increase the height of this tape',
        ['Decrease Height Title']           = 'Decrease Height',
        ['Decrease Height Description']     = 'Decrease the height of this tape',
        ['Delete Tape Title']               = 'Delete',
        ['Delete Tape Description']         = 'Delete This Tape',
        ['Amount Increase Question Title']  = 'Amount to increase',
        ['Amount Decrease Question Title']  = 'Amount to decrease',
        ['Spawn Object Title']              = 'Spawn This Object',
        ['Tape Type Windy']                 = 'Windy',
        ['Tape Type Not Windy']             = 'Not Windy',
    },
    ['Other'] = {
        ['Length Of Tape Notification']     = 'Length of tape will be',
        ['Meters']                          = 'meters'
    }
}
This script fully replaces your ambulancejob, so you'll need to stop or delete your existing one.

- import the sql file
- Add Inventory images to inventory
- Add the items
- Install all dependencies and start them in the following order
- Install screenshot-basic, if you don't have it in your server already
- Remember to start all dependencies BEFORE the ambulancejob in the cfg
- Avoid restarting the job whilst server is running to avoid issues

- For more information, read our docs over at: https://osp-development.gitbook.io/ambulance-job/

ensure ox_lib
ensure osp_ambulance


-- Usable inventory Items
	['bandage'] 			 		 = {['name'] = 'bandage', 						['label'] = 'Bandage', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'bandage.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory, stops bleeding from wounds and increases health'},
    	['ifak']                        = {['name'] = 'ifak',                         ['label'] = 'IFAK',                    ['weight'] = 200,      ['type'] = 'item',       ['image'] = 'ifak.png',                ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory, contains first aid kit'},
	['painkillers'] 			 	 = {['name'] = 'painkillers', 					['label'] = 'Painkillers', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'painkillers.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory to reduce pain and stress'},
	['temporary_tourniquet'] 	= {['name'] = 'temporary_tourniquet', 		['label'] = 'Temporary Tourniquet', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'tourniquet.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A temporary tourniquet that can directly be used in the inventory to stop bleeding'},

-- Medically used items
	['pager'] 	= {['name'] = 'pager', 		['label'] = 'Pager', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'pager.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Used to inform medical staff att hospital of an incoming patient'},
	['tourniquet'] 	= {['name'] = 'tourniquet', 		['label'] = 'Tourniquet', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'tourniquet.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['field_dressing'] 	= {['name'] = 'field_dressing', 		['label'] = 'Field Dressing', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'field_dressing.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['elastic_bandage'] 	= {['name'] = 'elastic_bandage', 		['label'] = 'Elastic Bandage', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'elastic_bandage.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['quick_clot'] 	= {['name'] = 'quick_clot', 		['label'] = 'Quick Clot', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'quick_clot.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['packing_bandage'] 	= {['name'] = 'packing_bandage', 		['label'] = 'Packing Bandage', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'packing_bandage.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['sewing_kit'] 	= {['name'] = 'sewing_kit', 		['label'] = 'Sewing Kit', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'sewing_kit.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['epinephrine'] 	= {['name'] = 'epinephrine', 		['label'] = 'Epinephrine', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'epinephrine.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Epinephrine, also known as adrenaline, increases the bodys pulse aswell as supress pain.'},
	['morphine'] 	= {['name'] = 'morphine', 		['label'] = 'Morphine', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'morphine.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Morphine, decreases the bodys pulse aswell as suppress pain'},
	['propofol'] 	= {['name'] = 'propofol', 		['label'] = 'Propofol', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'propofol.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Propofol, is a powerful sedation medication'},
	['blood250ml'] 	= {['name'] = 'blood250ml', 		['label'] = 'Blood Pack 250ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'blood.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['blood500ml'] 	= {['name'] = 'blood500ml', 		['label'] = 'Blood Pack 500ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'blood.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['saline250ml'] 	= {['name'] = 'saline250ml', 		['label'] = 'Saline 250ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'saline.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['saline500ml'] 	= {['name'] = 'saline500ml', 		['label'] = 'Saline 500ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'saline.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['revivekit'] 	= {['name'] = 'revivekit', 		['label'] = 'Emergency Revive Kit', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'firstaid.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['stretcher'] 	= {['name'] = 'stretcher', 		['label'] = 'Stretcher', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'stretcher.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A medical stretcher to carry wounded patients'},
	['wheelchair'] 	= {['name'] = 'wheelchair', 		['label'] = 'wheelchair', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'wheelchair.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['crutch'] 	= {['name'] = 'crutch', 		['label'] = 'Crutch', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'crutch.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['bodybag'] 	= {['name'] = 'bodybag', 		['label'] = 'Bodybag', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'bodybag.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A bag to put dead bodies in'},
	['ecg'] 			 		= {['name'] = 'ecg', 			 		['label'] = 'ECG', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'ecg.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Electrocardiography is an electrophysiological examination method of the heart where the hearts electrical activity is recorded by electrodes connected to an ECG device.'},
	['neckbrace'] 			 		= {['name'] = 'neckbrace', 			 		['label'] = 'Neck Brace', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'neckbrace.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['neckcast'] 			 		= {['name'] = 'neckcast', 			 		['label'] = 'Neck Cast', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'neckcast.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['legsplint'] 			 		= {['name'] = 'legsplint', 			 		['label'] = 'Leg Splint', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'legsplint.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['legcast'] 			 		= {['name'] = 'legcast', 			 		['label'] = 'Leg Cast', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'legcast.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},
	['armsplint'] 			 		= {['name'] = 'armsplint', 			 		['label'] = 'Arm Splint', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'armsplint.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = ''},
	['armcast'] 			 		= {['name'] = 'armcast', 			 		['label'] = 'Arm Cast', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'armcast.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = ''},



-- Following is the code setup to paste items into ox_inventory 

	['bandage'] = {
        label = 'Bandage',
        weight = 0,
        description = 'Can be directly used in the inventory, stops bleeding from wounds and increases health',
		stack = true,
    },
    ['ifak'] = {
        label = 'IFAK',
        weight = 200,
        description = 'Can be directly used in the inventory, contains first aid kit',
		stack = true,
		close = true,
    },
    ['painkillers'] = {
        label = 'Painkillers',
        weight = 0,
        description = 'Can be directly used in the inventory to reduce pain and stress',
		stack = true,
		close = true,
    },
    ['temporary_tourniquet'] = {
        label = 'Temporary Tourniquet',
        weight = 10,
        description = 'A temporary tourniquet that can directly be used in the inventory to stop bleeding',
		stack = true,
		close = true,
    },
	['pager'] = {
        label = 'Pager',
        weight = 10,
        description = 'Used to inform medical staff at the hospital of an incoming patient',
		stack = false,
		close = true,
    },
    ['tourniquet'] = {
        label = 'Tourniquet',
        weight = 10,
		stack = true,
    },
    ['field_dressing'] = {
        label = 'Field Dressing',
        weight = 10,
		stack = true,
    },
    ['elastic_bandage'] = {
        label = 'Elastic Bandage',
        weight = 10,
		stack = true,
    },
    ['quick_clot'] = {
        label = 'Quick Clot',
        weight = 10,
		stack = true,
    },
    ['packing_bandage'] = {
        label = 'Packing Bandage',
        weight = 10,
		stack = true,
    },
    ['sewing_kit'] = {
        label = 'Sewing Kit',
        weight = 10,
		stack = true,
    },
    ['epinephrine'] = {
        label = 'Epinephrine',
        weight = 10,
        description = 'Epinephrine, also known as adrenaline, increases the body\'s pulse as well as suppress pain.',
		stack = true,
    },
    ['morphine'] = {
        label = 'Morphine',
        weight = 10,
        description = 'Morphine decreases the body\'s pulse as well as suppress pain.',
		stack = true,
    },
    ['propofol'] = {
        label = 'Propofol',
        weight = 10,
        description = 'Propofol, is a powerful sedation medication.',
		stack = true,
    },
    ['blood250ml'] = {
        label = 'Blood Pack 250ml',
        weight = 10,
		stack = true,
    },
    ['blood500ml'] = {
        label = 'Blood Pack 500ml',
        weight = 10,
		stack = true,
    },
    ['saline250ml'] = {
        label = 'Saline 250ml',
        weight = 10,
		stack = true,
    },
    ['saline500ml'] = {
        label = 'Saline 500ml',
        weight = 10,
		stack = true,
    },
    ['revivekit'] = {
        label = 'Emergency Revive Kit',
        weight = 10,
		stack = true,
    },
    ['stretcher'] = {
        label = 'Stretcher',
        weight = 1000,
        description = 'A medical stretcher to carry wounded patients',
		stack = true,
    },
    ['wheelchair'] = {
        label = 'Wheelchair',
        weight = 1000,
		stack = true,
    },
    ['crutch'] = {
        label = 'Crutch',
        weight = 1000,
		stack = true,
    },
    ['bodybag'] = {
        label = 'Bodybag',
        weight = 1000,
        description = 'A bag to put dead bodies in',
		stack = true,
    },
    ['ecg'] = {
        label = 'ECG',
        weight = 200,
		stack = false,
		close = true,
        description = 'Electrocardiography is an electrophysiological examination method of the heart where the heart\'s electrical activity is recorded by electrodes connected to an ECG device.',
    },
   ['neckbrace'] = {
        label = 'Neck Brace',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['neckcast'] = {
        label = 'Neck Cast',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['legsplint'] = {
        label = 'Leg Splint',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['legcast'] = {
        label = 'Leg Cast',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['armsplint'] = {
        label = 'Arm Splint',
        weight = 1000,
        description = '',
		stack = true,
    },
   ['armcast'] = {
        label = 'Arm Cast',
        weight = 1000,
        description = '',
		stack = true,
    },

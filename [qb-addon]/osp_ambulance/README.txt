This script fully replaces your ambulancejob, so you'll need to stop or delete your existing one.

- import the sql file
- Add Inventory images to inventory
- Add the items
- Download the file attached in the payment confirmation email or go into discord and download the zip file in the ambulance customer channel
- Unpack that file and install the two resources within, xsound and ambulanceprops
- Install all dependencies and start them in the following order
- Install screenshot-basic, if you don't have it in your server
- Remember to start all dependencies BEFORE the ambulancejob in the cfg

- For more information, read our docs over at: https://osp-development.gitbook.io/ambulance-job/

ensure ambulanceprops
ensure ox_lib
ensure xsound
ensure osp_ambulance


-- Usable inventory Items
	['bandage'] 			 		= {['name'] = 'bandage', 						['label'] = 'Bandage', 					['weight'] = 0, 		['type'] = 'item', 		['image'] = 'bandage.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory, stops bleeding from wounds and increases health'},
    	['ifak']                        		= {['name'] = 'ifak',                         ['label'] = 'ifak',                    ['weight'] = 200,      ['type'] = 'item',       ['image'] = 'ifak.png',                ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory, contains first aid kit'},
	['painkillers'] 			 	= {['name'] = 'painkillers', 					['label'] = 'Painkillers', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'painkillers.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = 'Can be directly used in the inventory to reduce pain and stress'},
	['temporary_tourniquet'] 	= {['name'] = 'temporary_tourniquet', 		['label'] = 'Temporary Tourniquet', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'tourniquet.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A temporary tourniquet that can directly be used in the inventory to stop bleeding'},


-- Items used in the medical ui and misc
	['pager'] 	= {['name'] = 'pager', 		['label'] = 'Pager', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'pager.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Used to inform medical staff att hospital of an incoming patient'},
	['tourniquet'] 	= {['name'] = 'tourniquet', 		['label'] = 'Tourniquet', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'tourniquet.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['field_dressing'] 	= {['name'] = 'field_dressing', 		['label'] = 'Field Dressing', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'field_dressing.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['elastic_bandage'] 	= {['name'] = 'elastic_bandage', 		['label'] = 'Elastic Bandage', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'elastic_bandage.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['quick_clot'] 	= {['name'] = 'quick_clot', 		['label'] = 'Quick Clot', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'quick_clot.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['packing_bandage'] 	= {['name'] = 'packing_bandage', 		['label'] = 'Packing Bandage', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'packing_bandage.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['sewing_kit'] 	= {['name'] = 'sewing_kit', 		['label'] = 'Sewing Kit', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'sewing_kit.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['epinephrine'] 	= {['name'] = 'epinephrine', 		['label'] = 'Epinephrine', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'epinephrine.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Epinephrine, also known as adrenaline, increases the bodys pulse aswell as supress pain.'},
	['morphine'] 	= {['name'] = 'morphine', 		['label'] = 'Morphine', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'morphine.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Morphine, decreases the bodys pulse aswell as suppress pain'},
	['blood250ml'] 	= {['name'] = 'blood250ml', 		['label'] = 'Blood Pack 250ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'blood250ml.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['blood500ml'] 	= {['name'] = 'blood500ml', 		['label'] = 'Blood Pack 500ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'blood500ml.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['saline250ml'] 	= {['name'] = 'saline250ml', 		['label'] = 'Saline 250ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'saline250ml.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['saline500ml'] 	= {['name'] = 'saline500ml', 		['label'] = 'Saline 500ml', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'saline500ml.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['revivekit'] 	= {['name'] = 'revivekit', 		['label'] = 'Emergency Revive Kit', 		['weight'] = 10, ['type'] = 'item', ['image'] = 'revivekit.png', 	['unique'] = false, ['useable'] = false, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['stretcher'] 	= {['name'] = 'stretcher', 		['label'] = 'Stretcher', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'stretcher.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A medical stretcher to carry wounded patients'},
	['wheelchair'] 	= {['name'] = 'wheelchair', 		['label'] = 'wheelchair', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'wheelchair.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['crutch'] 	= {['name'] = 'crutch', 		['label'] = 'Crutch', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'crutch.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = ''},
	['bodybag'] 	= {['name'] = 'bodybag', 		['label'] = 'Bodybag', 		['weight'] = 1000, ['type'] = 'item', ['image'] = 'bodybag.png', 	['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'A bag to put dead bodies in'},
	['ecg'] 			 		= {['name'] = 'ecg', 			 		['label'] = 'ECG', 					['weight'] = 200, 		['type'] = 'item', 		['image'] = 'ecg.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Electrocardiography is an electrophysiological examination method of the heart where the hearts electrical activity is recorded by electrodes connected to an ECG device.'},
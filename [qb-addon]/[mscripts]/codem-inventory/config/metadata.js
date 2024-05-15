
let backpackMeta = ['backpack', 'backpack1', 'backpack2', 'backpack3']
let phoneMeta = ['phone', 'black_phone', 'yellow_phone', 'red_phone', 'green_phone']
let clothingItem = ["tshirt_1", "torso_1", "arms", "pants_1", "shoes_1", "mask_1", "bproof_1", "chain_1", "helmet_1",
    "glasses_1", "watches_1", "bracelets_1", "bags_1"]
export function sendInfoData(item) {
    let iteminfo = item.info;
    let returnString = "";
    if (item.name == "id_card") {
        let man = "Man";
        if (iteminfo.gender == 1) {
            man = "Woman";
        }
        let infoData = [
            { label: "Firstname", value: iteminfo.firstname },
            { label: "Lastname", value: iteminfo.lastname },
            { label: "Birthdate", value: iteminfo.birthdate },
            { label: "Nationality", value: iteminfo.nationality },
            { label: "Gender", value: man },
            { label: "Citizen", value: iteminfo.citizenid }
        ]
        returnString = infoData;
    } else if (item.name.match("driver_license")) {
        let infoData = [
            { label: "Firstname", value: iteminfo.firstname },
            { label: "Lastname", value: iteminfo.lastname },
            { label: "Birthdate", value: iteminfo.birthdate },
            { label: "Licenses", value: iteminfo.type },
        ]
        returnString = infoData;
    } else if (phoneMeta.includes(item.name)) {
        console.log(JSON.stringify(iteminfo))
        let infoData = [
            { label: "Firstname", value: iteminfo.charinfo.firstname },
            { label: "Lastname", value: iteminfo.charinfo.lastname },
            { label: "Number", value: iteminfo.charinfo.phoneNumber }
        ]
        returnString = infoData;
    } else if (item.name.match("lawyerpass")) {
        let infoData = [
            { label: "ID", value: iteminfo.id },
            { label: "Firstname", value: iteminfo.firstname },
            { label: "Lastname", value: iteminfo.lastname },
            { label: "Citizen", value: iteminfo.citizenid }
        ]
        returnString = infoData;
    } else if (item.name.match("harness")) {
        let infoData = [
            { label: "USES : ", value: iteminfo.uses },
        ]
        returnString = infoData;
    } else if (item.name.match("weapon")) {
        let infoData = [
            { label: "Serial", value: iteminfo.series },
            { label: "Ammo", value: iteminfo.ammo },
            { label: 'Quality', value: iteminfo.quality ? iteminfo.quality.toFixed(1) : 0 },
            { label: 'Repair Count', value: iteminfo.repair + ' / ' + iteminfo.maxrepair },
        ]
        returnString = infoData;
    } else if (backpackMeta.includes(item.name)) {
        let infoData = [
            { label: "Info", value: iteminfo.series },
            { label: "Slot", value: iteminfo.slot },
            { label: "Weight", value: iteminfo.weight },
        ]
        returnString = infoData;
    } else if (clothingItem.includes(item.name)) {
        let infoData = [
            { label: "Clothing ID", value: iteminfo.skin },
            { label: "Texture", value: iteminfo.texture },
        ]
        returnString = infoData;
    }
    return returnString;
}

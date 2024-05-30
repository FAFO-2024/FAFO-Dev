CodeStudio.Job_Cards = {
    ['police'] = {                          --Job Name
        logo = 'img3.png',                  --Put Your Logo's under ui/logo folder
        customBG = false,                   --Add Custom Background or GIF URL to your Card (false: to Use theme colour)
        theme = 'rgba(0, 0, 0, 0.29)',      --Put Theme Colour for Job Card
        cover = false,                       --Enable ID Cover
        title = 'Police Identiy Card',      --ID Title
        useableItem = 'police_card',        --ID Item Name
        menuName = 'Police Management',     --Menu Name for the Management
        targetName = 'Police Card',          --Target Label (works only if you enabled CodeStudio.OpenUI)
        alreadyIssue = false,               --Means players can get this card without getting card issued if not revoked
        expireCard = false                    --Card Expiry Period In Days from Issuing Date (false: will not expire card)
    },
    ['sasp'] = {                          --Job Name
        logo = 'img2.png',                  --Put Your Logo's under ui/logo folder
        customBG = false,                   --Add Custom Background or GIF URL to your Card (false: to Use theme colour)
        theme = 'rgba(0, 0, 0, 0.29)',      --Put Theme Colour for Job Card
        cover = false,                       --Enable ID Cover
        title = 'SASP Identiy Card',        --ID Title
        useableItem = 'sasp_card',          --ID Item Name
        menuName = 'SASP Management',     --Menu Name for the Management
        targetName = 'SASP Card',          --Target Label (works only if you enabled CodeStudio.OpenUI)
        alreadyIssue = false,               --Means players can get this card without getting card issued if not revoked
        expireCard = false                    --Card Expiry Period In Days from Issuing Date (false: will not expire card)
    },
    ['sheriff'] = {                          --Job Name
        logo = 'img4.png',                  --Put Your Logo's under ui/logo folder
        customBG = false,                   --Add Custom Background or GIF URL to your Card (false: to Use theme colour)
        theme = 'rgba(0, 0, 0, 0.29)',      --Put Theme Colour for Job Card
        cover = false,                       --Enable ID Cover
        title = 'Sheriff Identiy Card',      --ID Title
        useableItem = 'sheriff_card',        --ID Item Name
        menuName = 'Sheriff Management',     --Menu Name for the Management
        targetName = 'Sheriff Card',          --Target Label (works only if you enabled CodeStudio.OpenUI)
        alreadyIssue = false,               --Means players can get this card without getting card issued if not revoked
        expireCard = false                    --Card Expiry Period In Days from Issuing Date (false: will not expire card)
    },
    ['firefighter'] = {
        logo = 'img5.png',
        customBG = false,
        theme = 'rgba(0, 0, 0, 0.29)',
        cover = false,
        title = 'Firefighter Identiy Card',
        useableItem = 'firefighter_card',
        menuName = 'Firefighter Management', 
        targetName = 'Firefighter Card',  
        alreadyIssue = false,
        expireCard = false
    },
    ['ambulance'] = {
        logo = 'img6.png',
        customBG = false,
        theme = 'rgba(0, 0, 0, 0.29)',
        cover = false,
        title = 'EMS Identiy Card',
        useableItem = 'ems_card',
        menuName = 'EMS Management', 
        targetName = 'EMS Card',  
        alreadyIssue = false,
        expireCard = false
    },

    --ADD YOUR CUSTOM CARD's HERE 
}

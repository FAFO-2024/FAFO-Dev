
CodeStudio.ID_Cards = {
    ['id_card'] = {
        enable = true,                      --Enable Disable this ID
        alreadyIssue = false,                --Means players can get this card without getting card issued if not revoked
        logo = 'img1.png',                  --Put Your Logo's under ui/logo folder,
        customBG = false,                   --Add Custom Background or GIF URL to your Card (false: to Use theme colour)
        theme = '#111928',                  --Put Theme Colour for Job Card
        useableItem = 'id_card',            --ID Item Name
        menuName = 'Identity Card',         --Menu Name for the Management/ID Card Title
        targetName = 'Get ID Card',         --Target Label (works only if you enabled CodeStudio.OpenUI)
        expireCard = 30                     --Card Expiry Period In Days from Issuing Date (false: will not expire card)
    },
    ['weapon_card'] = {
        enable = true,
        alreadyIssue = false,
        logo = 'img3.png',
        customBG = false,
        theme = '#2b170e',
        useableItem = 'weapon_card',
        menuName = 'Weapon License',
        targetName = 'Get Weapon License',
        expireCard = 30
    },

    --CREATE OTHER ID CARDs HERE

    ['driving_card'] = {
        enable = true,
        alreadyIssue = false,
        logo = 'img2.png',
        customBG = false,                  
        theme = '#2b170e',                        
        useableItem = 'driving_card',         
        menuName = 'Driving License', 
        targetName = 'Get Driving License',
        expireCard = 30
    },
}

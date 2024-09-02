Cfg = {}

--- ### TEBEX - MUSIC - PlayTube  ### ---
Cfg.TebexTransactionID = "tbx-33515024a926-ff3781" --- GKSPhone TBX-ID Required for PlayTube and Music app. (Example : tbx-....)


--## Media Service Settings ## --
-- Media service is used for uploading images, videos and audio files to the server.
-- If you want to use your own media service, you need to change the URL, field, AuthHeader and AuthToken fields.
-- https://docs.gkshop.org/qb-information/gksphonev2/installation#step-3-serverconfig.lua (other media service providers)
Cfg.MediaServices = {
    ImgService = {
        url = "https://discord.com/api/webhooks/1240505767283523634/gnclD5xH_7xtw1tRKEwyJL8fFVIABQam133LEi_w96f199UnSrCftG78Drw0DUfIOMuu",
        field = "file",
        AuthHeader = "",
        AuthToken = "",
        returnIndex = "attachments.0.url"
    },
    AudioService = {
        url = "https://discord.com/api/webhooks/1240505540417818644/G15uzgOuCZi-F5m1pFY6Qpou8xTCn22Db9W7vFxcEXkAMQ_ylv-nchuk0R7ZGH1OQmyT",
        field = "file",
        AuthHeader = "",
        AuthToken = "",
        returnIndex = "attachments.0.url"
    },
    VideoService = {
        url = "https://discord.com/api/webhooks/1265450088013234361/3Opq7sXJ_9Ejd4SJ9GCTrtZ9VySbuzPX8GZ40aAeU_d_26_qkaFZ7BVTBC9TVyDQnRhS",
        field = "file",
        AuthHeader = "",
        AuthToken = "",
        returnIndex = "attachments.0.url"
    },
}

-- ## Discord webhook for logs  ## --

Cfg.DiscordWebHooks = {
    ['advertising'] = "https://discord.com/api/webhooks/1245540854404223008/zmE30h0uYddCbT3rFRwDlMBz13aKYUiewzuw12rQIzQTb0CmU2kzeZyVMDCW82Uxxn4p",
    ['bank'] = "https://discord.com/api/webhooks/1240506314677948446/4WHaf03bBy9wDlnFN8GNWoD_2aD2FrNdU7kaBA32MsPo6Hr2xXLZjSNN17MvaAT5Mjyk",
    ['carsellerAddPost'] = "",
    ['carsellerBuy'] = "",
    ['cryptoBuy'] = "",
    ['cryptoSell'] = "",
    ['cryptoTransfer'] = "",
    ['darkchat'] = "https://discord.com/api/webhooks/1245541170311073885/Usc9PEmV1tH5wjAPb7F34o9K2e_0XD71MJ8xHUZDfurnP61gQKsreREcqUsqUGDl5eR5",
    ['dispatchSendMessage'] = "",
    ['dispatchSendReport'] = "",
    ['livestreamCreate'] = "https://discord.com/api/webhooks/1240506903881318451/HcVwWZ-ox1265G-mXV6TkTQGmD9lbol4OHZJhWeb1eSRS_FvfrILsddrjNZOr3ThRKK4",
    ['livestreamDonate'] = "https://discord.com/api/webhooks/1240506903881318451/HcVwWZ-ox1265G-mXV6TkTQGmD9lbol4OHZJhWeb1eSRS_FvfrILsddrjNZOr3ThRKK4",
    ['mail'] = "https://discord.com/api/webhooks/1245541396665073864/9UqxdazcfTwt-2qBK2etYeEdbctQrJ4YzJB3LjyQEmtODB7rC84ON1-8v94siZX_CAr0",
    ['news'] = "https://discord.com/api/webhooks/1240506634346823730/iZi1MY5HG9ZVX08ZT7AOipJoEu2LjbRnWT8gV4bKjz61n7qpm_RVKr_xl2Mkc3i1FrCP",
    ['rentacarRent'] = "",
    ['rentacarReturn'] = "",
    ['squawkPost'] = "https://discord.com/api/webhooks/1240506025208053760/8cmR0rtCSbxJDfPzq9J1APayLTzH8lvbH__RDMsy6HYoF_2jTjS3UQA5xwxW6hK00MZR",
    ['taxiCall'] = "",
    ['taxiCallAccpet'] = "",
    ['taxiFinish'] = "",
    ['taxiTip'] = "",
    ['bussinesBillingCreate'] = "https://discord.com/api/webhooks/1245541704271134781/LYYrbcNLX9oL6y9v1iijWAb7WLEoCmK99rGxotTuMV-VcnCrxOPt1HQ-jyWflZTPScOA",
    ['bussinesBillingPay'] = "https://discord.com/api/webhooks/1245541786819104868/CSGgG8venAGJP8EppWwhEnuSR87HBhmeXtbEfbI944C_N8rIC5St3BN0giaLrczj4cQu",
    ['bussinesBillDelete'] = "https://discord.com/api/webhooks/1245541878397665441/KfL9oBk_S0-EfwaCFkxmP_CFbWAcWk2SAiHLh5u2AHqi7UBfh7XqRx8-SlnkUwZU0ZCm",
    ['bussinesJobApplication'] = "",
    ['bussinesSetJob'] = "",
    ['bussinesGradeUpDown'] = "",
    ['messageSend'] = "https://discord.com/api/webhooks/1240506407112020128/S3hYycjc30lPC--N3YrlSojTbEzZHKbEm0NJrBU4ps3la3VbIsd0dmTYbKCT7ALrHdSr",
    ['messageGroupSend'] = "https://discord.com/api/webhooks/1240506407112020128/S3hYycjc30lPC--N3YrlSojTbEzZHKbEm0NJrBU4ps3la3VbIsd0dmTYbKCT7ALrHdSr",
    ['startCall'] = "https://discord.com/api/webhooks/1276761293449199749/b55EdunucPP1Wen1jwI8AFvn_9oiVhY6f_A_Okh2L0sQWhwz0Z15PADhicdxFSoz4_WI",
    ['casinoRollWinner'] = "https://discord.com/api/webhooks/1276754823898857524/fCxnxcwAX-WH8j_pCFKQGDZsZH-qruOkDqPqDiM4OtehQhjF6700YN_ZJe0JlLR9gXfQ",
    ['casinoDiceWinner'] = "https://discord.com/api/webhooks/1276754748556574771/26bx6CSdlAia_2dx2mqDo8zUB7LkQ_DWnD4pERxUd3u-yiXaAKHJ9tvLcz8BMSLmR820",
    ['casinoChipSeller'] = "https://discord.com/api/webhooks/1276754684731986043/I1pE9Xgy96EmZPbn9xAG5E88Bu6AzzzWv7h-JHvGlZB6ayMQ2oezZNUhgrAy-meNWg9U",
    ['casinoChipBuy'] = "https://discord.com/api/webhooks/1276754619342524480/B6uX4cqQRv7z16KiCXHc6ElP1yj-xtow0oSUMxZ-MR3zKrZK6vNqrrvvI2c0oJYQsFAx"
}

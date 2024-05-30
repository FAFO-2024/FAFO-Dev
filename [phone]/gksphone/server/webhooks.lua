--- WEBHOOKS ---

function WebhookLogs(logType, source, logData)
  debugprint("WebhookLogs", logType, source, logData)

  if logType == "advertising" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "AdvertisingAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "AdvertisingAPP",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Message:** ' ..logData[2].. '\n**Filter:** ' ..logData[4]
        }
      }
    }

    if type(logData[3]) == "table" then
      for k, l in pairs(logData[3]) do
        if k == 1 then
          data['embeds'][1]['url'] = "https://www.gkshop.org/GKSHOP1.png"
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["url"] = "https://www.gkshop.org/GKSHOP1.png",
            ["image"] = {
              ["url"] = l
            }
          }
        end
      end
    end
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bank" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "BankAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BankAPP",
          ['description'] = '**Sender Phone Number:** ' ..logData[1].. '\n**Receiver Phone Number:** ' ..logData[2].. '\n**Amount:** ' ..logData[3].. '\n**Sender Description:** ' ..logData[4].. '\n**Receiver Description:** ' ..logData[5] .. '\n**Sender Citizen ID:** ' ..logData[6].. '\n**Receiver Citizen ID:** ' ..logData[7]
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "carsellerAddPost" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "CarSellerAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CarSellerAPP Add Post",
          ['description'] = '**ID:** ' ..logData.id.. '\n**Player Name:** ' ..logData.player_name.. '\n**Phone Number:** ' ..logData.phone_number.. '\n**Plate:** ' ..logData.plate.. '\n**Model:** ' ..logData.model.. '\n**Price:** ' ..logData.price..  '\n**Identifier:** ' ..logData.identifier
        }
      }
    }

    if type(logData.image) == "table" then
      for k, l in pairs(logData.image) do
        if k == 1 then
          data['embeds'][1]['url'] = "https://www.gkshop.org/GKSHOP1.png"
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["image"] = {
              ["url"] = l
            },
            ["url"] = "https://www.gkshop.org/GKSHOP1.png",
          }
        end
      end
    end
    debugprint(data)
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "carsellerBuy" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "CarSellerAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CarSellerAPP Buy",
          ['description'] = '**Player Name:** ' ..logData.player_name.. '\n**Phone Number:** ' ..logData.phone_number.. '\n**Plate:** ' ..logData.plate.. '\n**Model:** ' ..logData.model.. '\n**Price:** ' ..logData.price..  '\n**Seller Identifier:** ' ..logData.identifier .. '\n**Buyer Identifier:** ' ..logData.buyer
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "cryptoBuy" then
    -- cryptoBuy
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Buy",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Amount:** ' ..logData[3].. '\n**Price:** ' ..logData[4].. '\n**Crypto Name:** ' ..logData[2].. '\n**Identifier:** ' ..logData[5]
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "cryptoSell" then
    -- cryptoSell
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Sell",
          ['description'] = '**Phone Number:** ' ..logData[1].. '\n**Amount:** ' ..logData[3].. '\n**Price:** ' ..logData[4].. '\n**Crypto Name:** ' ..logData[2].. '\n**Identifier:** ' ..logData[5]
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "cryptoTransfer" then
    -- cryptoTransfer
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "CryptoAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "CryptoAPP Transfer",
          ['description'] = '**Sender Phone Number:** ' ..logData[1].. '\n**Receiver Phone Number:** ' ..logData[7].. '\n**Amount:** ' ..logData[3].. '\n**Crypto Name:** ' ..logData[2].. '\n**Sender Identifier:** ' ..logData[5].. '\n**Receiver Identifier:** ' ..logData[6]
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "darkchat" then
    -- darkchat
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "DarkChatAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DarkChatAPP",
          ['description'] = '**Phone UniqID:** ' ..logData[1].. '\n**Message:** ' ..logData[2].. '\n**ChannelID:** ' ..logData[3] .. '\n**Source:** ' ..source
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "dispatchSendMessage" then
    -- dispatchSendMessage
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "DispatchAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DispatchAPP",
          ['description'] = '**Job:** ' ..logData.receiverjob .. '\n**Message:** ' ..logData.message.. '\n**Sender Job:** ' ..logData.senderjob .. '\n**Sender Job Grade:** ' ..logData.senderjobgrade.name .. '\n**Source:** ' ..source.. '\n**Sender Identifier:** ' ..logData.sendercitizenid
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "dispatchSendReport" then
    -- dispatchSendReport
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local Anonymous = logData.isAnonymous == true and 'Yes' or 'No'
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "DispatchAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "DispatchAPP",
          ['description'] = '**Job:** ' ..logData.job .. '\n**Message:** ' ..logData.message.. '\n**Location:** ' ..logData.location .. '\n**Street:** ' ..logData.street .. '\n**Anonymous:** ' ..Anonymous.. '\n**Phone Number:** ' ..logData.phone.. '\n**Source:** ' ..source .. '\n**Identifier:** ' ..logData.sendercitizenid ,
          ['image'] = {
            ["url"] = logData.photo
          },
          ['url'] = logData.photo
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "livestreamDonate" then
    -- livestreamDonate
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "LiveAPP Donate",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "LiveAPP Donate",
          ['description'] = '**Donation person:** ' ..logData.xPlayer.PlayerData.source.. ' **['..logData.xPlayer.PlayerData.citizenid..']**' ..'\n**Streamer:** ' ..logData.yPlayer.PlayerData.source.. ' **['..logData.yPlayer.PlayerData.citizenid..']**' ..'\n**Amount donated:** '.. logData.DonatePrice .. '\n**Deducted Commission Amount:** ' .. (logData.DonatePrice - logData.DonateCommision.. '\n**Streamer earning:** '..logData.DonateCommision)
        }
      }
    }
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "mail" then
    -- mail
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "MailAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "MailAPP",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Subject:** ' ..logData.subject.. '\n**Message:** ' ..logData.message
        }
      }
    }

    if logData.image then
      data['embeds'][1]['url'] = logData.image
      data['embeds'][1]['image'] = {
        ["url"] = logData.image
      }
    end
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "news" then
    -- news
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "NewsAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "NewsAPP",
          ['description'] = '**Title:** ' ..logData.news_title.. '\n**Text:** ' ..logData.news_text
        }
      }
    }

    if logData.news_image then
      data['embeds'][1]['url'] = logData.news_image
      data['embeds'][1]['image'] = {
        ["url"] = logData.news_image
      }
    end
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "rentacarRent" then
    -- rentacarRent
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "RentACarAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "RentACarAPP Rent",
          ['description'] = '**Model:** ' ..logData.model.. '\n**Plate:** ' ..logData.plate.. '\n**Price:** ' ..logData.price.. '\n**Stock:** ' ..logData.stock.. '\n**Identifier:** ' ..logData.identifier
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "rentacarReturn" then
    -- rentacarReturn
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "RentACarAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "RentACarAPP Return",
          ['description'] = '**Model:** ' ..logData.model.. '\n**Plate:** ' ..logData.plate.. '\n**Car Damge Price:** ' ..logData.price.. '\n**Health:** ' ..logData.health.. '\n**Engine:** ' ..logData.engine
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "squawkPost" then
    -- squawkPost
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    tweetData = logData.tweetData
    TweetUserData = logData.TweetUserData
    tweetType = logData.tweetType
    pollTime = logData.pollTime

    if TweetUserData.avatar == "/html/img/icons/valeuser.png" then
      TweetUserData.avatar = "https://abs.twimg.com/sticky/default_profile_images/default_profile_normal.png"
    end

    local data = {
      ["embeds"] = {{
        ["title"] = "There is a new post",
        ["description"] = tweetData.content,
        ["url"] = TweetUserData.avatar,
        ["color"] = 5814783,
        ["author"] = {
          ["name"] = TweetUserData.username
        },
        ["fields"] = {}
      }},
      ["username"] = TweetUserData.username,
      ["avatar_url"] = TweetUserData.avatar,
    }

    if tweetType == "postpoll" then
      local pollId = 1
      data['embeds'][1]['fields'][#data['embeds'][1]['fields'] + 1] = {
        ["name"] = "Started a Poll",
        ["value"] = ""
      }

        for i, item in ipairs(tweetData.poll_options) do
            for key, value in pairs(item) do
                data['embeds'][1]['fields'][1]["value"] = data['embeds'][1]['fields'][1]["value"] ..'\n'..pollId ..'. '..key
                pollId = pollId + 1
            end
        end

        data['embeds'][1]['fields'][1]["value"] = data['embeds'][1]['fields'][1]["value"]..'\n\nPoll end time : ' ..pollTime

    end
    if type(tweetData.media) == "table" then
      for k, l in pairs(tweetData.media) do
        if k == 1 then
          data['embeds'][1]['image'] = {
            ["url"] = l
          }
        else
          data['embeds'][k] = {
            ["url"] = TweetUserData.avatar,
            ["image"] = {
              ["url"] = l
            }
          }
        end
      end
    end
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "taxiCall" then
    -- TaxiCall
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Call",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "taxiCallAccpet" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Taxi Accept Job",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone.. '\n**Taxi Name:** ' ..logData.taxiInfo.name.. '\n**Taxi Phone Number:** ' ..logData.taxiInfo.phone.. '\n**Taxi Identifier:** ' ..logData.taxiInfo.identifier.. '\n**Taxi Source:** ' ..logData.taxiInfo.src
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "taxiFinish" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Job Finish",
          ['description'] = '**Customer Identifier:** ' ..logData.identifier.. '\n**Customer Source:** ' ..logData.src.. '\n**Taxi Status:** ' ..logData.status.. '\n**Customer Phone Number:** ' ..logData.phone.. '\n**Taxi Name:** ' ..logData.taxiInfo.name.. '\n**Taxi Phone Number:** ' ..logData.taxiInfo.phone.. '\n**Taxi Identifier:** ' ..logData.taxiInfo.identifier.. '\n**Taxi Source:** ' ..logData.taxiInfo.src.. '\n**Total Price:** ' ..logData.jobInfo.price
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "taxiTip" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "TaxiAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "TaxiAPP - Taxi Tip",
          ['description'] = "**Customer Identifier:** " ..logData.customerCid.. '\n**Taxi Identifier:** ' ..logData.driverCid.. '\n**Total Tip:** ' ..logData.tip
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesBillingCreate" then
    -- bussinesBillingCreate
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Billing Create",
          ['description'] = '**Bussines Name:** ' ..logData.billingSocietyLabel.. '\n**Receiver Identifier:** ' ..logData.receiverID.. '\n**Amount:** ' ..logData.billingAmaount.. '\n**Description:** ' ..logData.billingLabel.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.senderID.. '\n**Sender Name:** ' ..logData.senderName .. '\n**Bussines Job Code:** ' ..logData.billingSociety
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesBillingPay" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Pay Bill",
          ['description'] = '**Bussines Name:** ' ..logData.societylabel.. '\n**Receiver Identifier:** ' ..logData.sendercitizenid.. '\n**Amount:** ' ..logData.amount.. '\n**Description:** ' ..logData.description.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.sendercitizenid.. '\n**Sender Name:** ' ..logData.bill_holder .. '\n**Bussines Job Code:** ' ..logData.society
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesBillDelete" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Delete Bill",
          ['description'] = '**Bussines Name:** ' ..logData.societylabel.. '\n**Receiver Identifier:** ' ..logData.sendercitizenid.. '\n**Amount:** ' ..logData.amount.. '\n**Description:** ' ..logData.description.. '\n**Status:** ' ..logData.status .. '\n**Sender:** ' ..logData.sendercitizenid.. '\n**Sender Name:** ' ..logData.bill_holder .. '\n**Bussines Job Code:** ' ..logData.society
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesJobApplication" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Job Application",
          ['description'] = '**Bussines Name:** ' ..logData.jobname.. '\n**Applicant Identifier:** ' ..logData.cid.. '\n**Applicant Name:** ' ..logData.sender.. '\n**Applicant Phone Number:** ' ..logData.phoneNumber.. '\n**Applicant Source:** ' ..source
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesSetJob" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Set Job",
          ['description'] = '**Bussines Name:** ' ..logData.job.. '\n**Recruiter Identifier:** ' ..logData.PlayerCid.. '\n**Player Identifier:** ' ..logData.TargetCid
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesGradeUpDown" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Grade Up/Down/Fire",
          ['description'] = '**Bussines Name:** ' ..logData.job.. '\n**Recruiter Identifier:** ' ..logData.PlayerCid.. '\n**Player Identifier:** ' ..logData.target.. '\n**Action:** ' ..logData.action
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "bussinesTip" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "BussinesAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "BussinesAPP - Tip",
          ['description'] = '**Job:** ' ..logData.job.. '\n**Amount:** ' ..logData.amount.. '\n**Phone Number:** ' ..logData.phone.. '\n**Player Identifier (Recipient):** ' ..logData.yPlayer .. '\n**Source (Giver):** ' ..source .. '\n**Identifier (Giver):** ' ..logData.xPlayer
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "messageSend" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "MessageAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Message - Send",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Receiver:** ' ..logData.receiver.. '\n**Message:** ' ..logData.message.. '\n**Source:** ' ..source .. '\n**Sender Citizen ID:** ' ..logData.senderIdentifier .. '\n**Receiver Citizen ID:** ' ..logData.receiverIdentifier
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
  elseif logType == "messageGroupSend" then
    local discord_webhook = Cfg.DiscordWebHooks[logType]
    if not discord_webhook then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }

    local data = {
      ["username"] = "MessageAPP",
      ["embeds"] = {
        {
          ["color"] = 1942002,
          ['title'] = "Message - Group Send",
          ['description'] = '**Sender:** ' ..logData.sender.. '\n**Group ID:** ' ..logData.group_id.. '\n**Message:** ' ..logData.message.. '\n**Source:** ' ..source .. '\n**Sender Citizen ID:** ' ..logData.senderIdentifier
        }
      }
    }

    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)

  end

end


--- WEBHOOKS ---
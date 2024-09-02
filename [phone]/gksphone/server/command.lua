Config.Core.Commands.Add(Config.TwitterVerifyCommand, 'Twitter Yellow Tick Approval', {{name = "auth", help = "true/false"}, {name = "AccountName", help = "Squawk Account Name"}}, true, function(source, args)
    local src = source
    if args[1] then
      local label = ""
      local first = true
      local auth = args[1]
      table.remove(args, 1)
      for i = 1, #args, 1 do
        if first then
          first = false
          label = label .. '' .. args[i]
        else
          label = label .. ' ' .. args[i]
        end
      end
      if auth == "true" then
        MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `is_verified`= 2 WHERE username = @username", {
          ['@username'] = tostring(label)
        }, function (result)
          if (result == 1) then
            TwitterYellowTick(true, tostring(label))
            FreamworkNotify(src, 'The user has been given a yellow tick.', 'success')
          else
            FreamworkNotify(src, 'You did not write the required information', 'error')
          end
        end)
      else
        MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `is_verified`= 0 WHERE username = @username", {
          ['@username'] = tostring(label)
        }, function (result)
          if (result == 1) then
            TwitterYellowTick(false, tostring(label))
            FreamworkNotify(src, "User's yellow tick removed", 'success')
          else
            FreamworkNotify(src, 'You did not write the required information', 'error')
          end
        end)
      end
    else
      FreamworkNotify(src, 'You did not write the required information', 'error')
    end
end, 'god')

Config.Core.Commands.Add(Config.TwitterSendBanCommand, 'Twitter Accout Suspend', {{name = "auth", help = "true/false"}, {name = "AccountName", help = "Squawk Account Name"}}, true, function(source, args)
    local src = source
    if args[1] then
      local label = ""
      local first = true
      local auth = args[1]
      table.remove(args, 1)
      for i = 1, #args, 1 do
        if first then
          first = false
          label = label .. '' .. args[i]
        else
          label = label .. ' ' .. args[i]
        end
      end
      if auth == "true" then
        MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 1 WHERE username = @username", {
          ['@username'] = tostring(label)
        }, function (result)
          if (result == 1) then
            TwitterBannedUser(true, tostring(label))
            FreamworkNotify(src, 'User banned', 'success')
          else
            FreamworkNotify(src, 'You did not write the required information', 'error')
          end
        end)
      else
        MySQL.Async.execute("UPDATE `gksphone_twt_users` SET `banned`= 0 WHERE username = @username", {
          ['@username'] = tostring(label)
        }, function (result)
          if (result == 1) then
            TwitterBannedUser(false, tostring(label))
            FreamworkNotify(src, 'User ban lifted', 'success')
          else
            FreamworkNotify(src, 'You did not write the required information', 'error')
          end
        end)
      end
    else
      FreamworkNotify(src, 'You did not write the required information', 'error')
    end
end, 'god')

Config.Core.Commands.Add(Config.TwitterSendBlockCommand, 'Turn off/on Message Sending', {{name = "auth", help = "true/false"}}, true, function(source, args)
    local src = source
    if args[1] then
      local label = ""
      local first = true
      local auth = args[1]
      if auth == "true" then
        TwitterMessageBlock = true
        FreamworkNotify(src, 'Message Sending is turned off', 'success')
      else
        TwitterMessageBlock = false
        FreamworkNotify(src, 'Message Sending is turned on', 'success')
      end
    else
      FreamworkNotify(src, 'You did not write the required information', 'error')
    end
end, 'god')

Config.Core.Commands.Add("phonenewnumber", 'Create a new phone number', {{name = "Source", help = "Player Source"}, {name = "Number", help = "Phone Number"}}, true, function(source, args)
  local src = source
  if args[1] and args[2] then
      local newNumber = exports["gksphone"]:NewNumber(tonumber(args[1]), nil, args[2])
      if newNumber then
          FreamworkNotify(src, 'New phone number created', 'success')
      else
          FreamworkNotify(src, 'You did not write the required information', 'error')
      end
  else
      FreamworkNotify(src, 'You did not write the required information', 'error')
  end
end, 'god')

Config.Core.Commands.Add("adminauth", 'Admin Authentication', {{name = "auth", help = "true/false"}}, true, function(source, args)
  local src = source
  local AdminAuth = false
  if args[1] then
    local auth = args[1]
    if auth == "true" then
      AdminAuth = true
      TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
      FreamworkNotify(src, 'Admin Authentication is turned on', 'success')
    else
      TriggerClientEvent('gksphone:client:adminAuth', src, AdminAuth)
      FreamworkNotify(src, 'Admin Authentication is turned off', 'success')
    end
  else
    FreamworkNotify(src, 'You did not write the required information', 'error')
  end
end, 'god')
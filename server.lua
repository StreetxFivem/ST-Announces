
local announceTimer = 0
local minuteTimer = 0

function SendRandomAnnouncement()
    local randomIndex = math.random(1, #Config.Messages)
    local message = Config.Messages[randomIndex]
    
    TriggerClientEvent('chat:addMessage', -1, {
        color = {255, 0, 0},
        multiline = true,
        args = {Config.Prefix, message}
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        minuteTimer = minuteTimer + 1
        
        if minuteTimer >= 60 then
            minuteTimer = 0
            announceTimer = announceTimer + 1
            
            if announceTimer >= Config.Interval then
                announceTimer = 0
                SendRandomAnnouncement()
            end
        end
    end
end)

RegisterCommand('anuncio', function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "command.anuncio") then
        if #args > 0 then
            local message = table.concat(args, " ")
            TriggerClientEvent('chat:addMessage', -1, {
                color = {255, 0, 0},
                multiline = true,
                args = {Config.Prefix, message}
            })
        else
            SendRandomAnnouncement()
        end
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"SISTEMA", "No tienes permisos para usar este comando."}
        })
    end
end, false)

print("^2ST-Announces iniciado correctamente. Los anuncios se mostrarán cada " .. Config.Interval .. " minutos.^7")
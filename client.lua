QBCore = exports['qb-core']:GetCoreObject()
local doingYoga = false

Citizen.CreateThread(function()
    local scriptReady = true
    if Config.Time <= 0 then
        scriptReady = false
        print("Make sure that your Config.Time is set to a number above zero")
    elseif type(Config.Text) ~= "string" then
        scriptReady = false
        print("Make sure that your Config.Text is a string (text)")
    elseif type(Config.UseProgress) ~= "boolean" then
        scriptReady = true
        print("Your Config.UseProgress should probably be a boolean (true/false)")
    end
    while scriptReady do 
        for k, v in pairs(Config.Mats) do
            for x, y in pairs(v.Mats) do
                local distance = #(GetEntityCoords(PlayerPedId())-y.enter)
                if distance < 1 then
                    if doingYoga then return end
                    Config.DrawText(y.enter.x, y.enter.y, y.enter.z, "~p~[E]~w~ Begin Yoga")
                    if IsControlJustReleased(0, 38) then
                        doingYoga = true
                        if Config.UseProgress then
                            TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_YOGA", y.mat.x, y.mat.y, y.mat.z, y.mat.w, Config.Time*1000, false, true)
                            QBCore.Functions.Progressbar("yoga", Config.Text, Config.Time*1000, false, false, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true,
                            }, {}, {}, {}, function()
                                ClearPedTasks(PlayerPedId())
                                Config.StressFunction()
                            end)
                            Citizen.Wait(Config.Time*1000)
                            doingYoga = false
                        else
                            TaskStartScenarioAtPosition(PlayerPedId(), "WORLD_HUMAN_YOGA", y.mat.x, y.mat.y, y.mat.z, y.mat.w, Config.Time*1000, false, true)
                            Citizen.Wait(Config.Time*1000)
                            ClearPedTasks(PlayerPedId())
                            doingYoga = false
                            Config.StressFunction()
                        end
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Mats) do
        if v.Blip then
            blip = AddBlipForCoord(v.Blip.pos)
            SetBlipSprite(blip, v.Blip.sprite)
            SetBlipColour(blip, v.Blip.colour)
            SetBlipScale(blip, 0.7)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blip.text)
            EndTextCommandSetBlipName(blip)
        end
    end
end)
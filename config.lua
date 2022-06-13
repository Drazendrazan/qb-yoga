-- Pal's Yoga, feel free to customize and redistribute this script

Config = {}

-- How long should yoga take? In seconds
Config.Time = 15

-- Use progress bar? Recommended (https://github.com/qbcore-framework/progressbar)
Config.UseProgress = true

-- The text that should appear on the progressbar
Config.Text = "Reaching enlightment"

-- Set your yoga mats up in batches, meaning that you can have a seperate blip for every grouping of mats to avoid clutter
Config.Mats = {
    [1] = {
        Mats = {
        [1] = { enter = vector3(4991.0, -5878.9, 20.54), mat = vector4(4991.0, -5878.9, 20.54, 121.4)},
        [2] = { enter = vector3(4991.01, -5883.88, 20.56), mat = vector4(4991.0, -5883.88, 20.56, 32.0)},
        [3] = { enter = vector3(4985.97, -5883.05, 20.55), mat = vector4(4985.97, -5883.05, 20.55, 297.84)}
        },
        Blip = { pos = vector3(4989.02, -5880.83, 20.98), text = "Yoga", sprite = 197, colour = 8 }
    },
    [2] = {
        Mats = {
        [1] = { enter = vector3(-1496.88, 828.42, 181.62), mat = vector4(-1496.87, 828.41, 181.62, 199.14)},
        [2] = { enter = vector3(-1495.22, 829.01, 181.62), mat = vector4(-1495.22, 829.01, 181.62, 202.63)},
        [3] = { enter = vector3(-1493.11, 829.83, 181.62), mat = vector4(-1493.19, 829.84, 181.62, 192.1)},
        [4] = { enter = vector3(-1491.42, 830.3, 181.62), mat = vector4(-1491.41, 830.3, 181.62, 197.4)}
        },
        Blip = { pos = vector3(vector3(-1494.27, 829.42, 181.6)), text = "Yoga", sprite = 197, colour = 8 }
    },
    [3] = {
        Mats = {
        [1] = { enter = vector3(2507.59, 3776.18, 51.09), mat = vector4(2507.65, 3776.24, 51.09, 112.8)},
        [2] = { enter = vector3(2508.7, 3774.58, 51.34), mat = vector4(2508.7, 3774.58, 51.34, 117.32)},
        [3] = { enter = vector3(2507.58, 3778.5, 51.04), mat = vector4(2507.58, 3778.5, 51.04, 97.89)}
        },
        Blip = { pos = vector3(2507.59, 3776.18, 51.09), text = "Yoga", sprite = 197, colour = 8 }
    },
    [4] = {
        Mats = {
        [1] = { enter = vector3(-3041.54, 29.62, 10.12), mat = vector4(-3041.54, 29.62, 10.12, 148.4)},
        [2] = { enter = vector3(-3043.55, 30.95, 10.12), mat = vector4(-3043.55, 30.95, 10.12, 150.11)},
        [3] = { enter = vector3(-3045.87, 32.5, 10.12), mat = vector4(-3045.87, 32.5, 10.12, 146.24)}
        },
        Blip = { pos = vector3(-3043.55, 30.95, 10.12), text = "Yoga", sprite = 197, colour = 8 }
    },
}

-- The function that is executed once Yoga is completed, implement your stress script here
Config.StressFunction = function()
    TriggerEvent("hud:client:RemoveStress", math.random(40,60))
    QBCore.Functions.Notify("You feel at peace", "success", 5000)
end

-- The function used to draw text, customize if you know what you're doing
Config.DrawText = function(x,y,z,text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)
    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100
    if onScreen then
        SetTextColour(255, 255, 255, 255)
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextCentre(true)
        SetTextDropshadow(1, 1, 1, 1, 255)
        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55 * scale, 4)
        local width = EndTextCommandGetWidth(4)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
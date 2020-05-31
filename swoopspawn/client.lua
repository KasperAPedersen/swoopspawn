local userID
local characterCreationEnabled = false
local cam = -1
local partToZoom = "face"
local headPosition = 332.219879

RegisterNUICallback('updateCharacter', function(data)
    partToZoom = data.zoom
    local lPed = GetPlayerPed(-1)
    
    RequestModel(data.gender)
    while not HasModelLoaded(data.gender) do
        Wait(0)
    end

    if GetEntityModel(lPed) ~= GetHashKey(data.gender) then
        SetPlayerModel(PlayerId(), data.gender)
    end

    SetPedHeadBlendData(lPed, tonumber(data.mother1), tonumber(data.father1), 0, tonumber(data.mother2), tonumber(data.father2), 0, tonumber(data.shapeMix), tonumber(data.skinMix), 0, false)
end)

RegisterNUICallback('closeswoopspawn', function()
	SendNUIMessage({
		enabled = false
	})
    SetNuiFocus(false,false)
    characterCreationEnabled = false
    stopCamPosition()
end)

RegisterNUICallback('closewithsuccess', function(data)
    local lPed = GetPlayerPed(-1)
    SendNUIMessage({
		enabled = false
    })
    SetNuiFocus(false,false)
    characterCreationEnabled = false
    stopCamPosition()
    TriggerServerEvent('updateUser', userID, data.firstName, data.lastName, data.age, data.gender, data.mother1, data.mother2, data.father1, data.father2, data.shapeMix, data.skinMix)
    SetEntityCoords(lPed, 120.88962554932,-758.27838134766,45.751937866211, 1, 0, 0, 1)
end)

RegisterNetEvent("saveUserID")
AddEventHandler("saveUserID", function(uID)
    userID = uID
end)

RegisterNetEvent("setCharacterAfterSpawn")
AddEventHandler("setCharacterAfterSpawn", function(mother1, mother2, father1, father2, shapeMix, skinMix)
    SetPedHeadBlendData(lPed, tonumber(mother1), tonumber(father1), 0, tonumber(mother2), tonumber(father2), 0, tonumber(shapeMix), tonumber(skinMix), 0, false)
end)

function setCamPosition(status)
    local lPed = GetPlayerPed(-1)
    if status == true then
        DisableControlAction(2, 14, true)
        DisableControlAction(2, 15, true)
        DisableControlAction(2, 16, true)
        DisableControlAction(2, 17, true)
        DisableControlAction(2, 30, true)
        DisableControlAction(2, 31, true)
        DisableControlAction(2, 32, true)
        DisableControlAction(2, 33, true)
        DisableControlAction(2, 34, true)
        DisableControlAction(2, 35, true)
        DisableControlAction(0, 25, true)
        DisableControlAction(0, 24, true)
        
        SetPlayerInvincible(lPed, true)

        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
        
        if(not DoesCamExist(cam)) then
            cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
            SetCamCoord(cam, GetEntityCoords(lPed))
            SetCamRot(cam, 0.0, 0.0, 0.0)
            SetCamActive(cam,  true)
            RenderScriptCams(true,  false,  0,  true,  true)
            SetCamCoord(cam, GetEntityCoords(lPed))
        end

        local x,y,z = table.unpack(GetEntityCoords(lPed))
        if partToZoom == "face" or partToZoom == "hair" then
            SetCamCoord(cam, x+0.2, y+0.5, z+0.7)
            SetCamRot(cam, 0.0, 0.0, 150.0)
        elseif partToZoom == "clothing" then
            SetCamCoord(cam, x+0.3, y+2.0, z+0.0)
            SetCamRot(cam, 0.0, 0.0, 170.0)
        end
    else
        FreezeEntityPosition(lPed, false)
        SetPlayerInvincible(lPed, false)
    end
end

function stopCamPosition()
	SetCamActive(cam, false)
    RenderScriptCams(false, false, 0, true, true)
    cam = -1
end

Citizen.CreateThread(function ()
	while true do
        Citizen.Wait(0)
        local lPed = GetPlayerPed(-1)
        if characterCreationEnabled == false then
            if GetDistanceBetweenCoords(GetEntityCoords(lPed), 13.016298294067,-1109.1622314453,29.797006607056, true) < 3 then
                DisplayHelpText("Klik ~g~E~s~ for at ændre din identitet")
                if IsControlJustReleased(1, 51) then
                    characterCreationEnabled = true
                    SendNUIMessage({
                        enabled = true
                    })
                    SetNuiFocus(true,true)
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local lPed = GetPlayerPed(-1)
        if characterCreationEnabled == true then
            setCamPosition(true)
            SetEntityHeading(lPed, headPosition)
        else
            setCamPosition(false)
        end
    end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
MySQL = module("vrp_mysql", "MySQL")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

MySQL.createCommand("vRP/updateUserIdentity", "UPDATE vrp_user_identities SET firstname=@fName, name=@lName, age=@pAge, gender=@pGender, mother1=@pMother1, father1=@pFather1, mother2=@pMother2, father2=@pFather2, shapemix=@pShapeMix, skinmix=@pSkinMix WHERE user_id=@userID")
MySQL.createCommand("vRP/getCharacter", "SELECT gender, mother1, father1, mother2, father2, shapemix, skinmix FROM vrp_user_identities WHERE user_id=@pUserID")


RegisterServerEvent('updateUser')
AddEventHandler('updateUser', function(userID, first, last, age, gender, mother1, mother2, father1, father2, shapemix, skinmix)
    if first ~= "" and first ~= nil and last ~= "" and last ~= nil then
        if age ~= nil and age ~= "" then
            if gender ~= nil and gender ~= "" then
                MySQL.execute("vRP/updateUserIdentity", {fName = first, lName = last, pAge = age, pGender = gender, pMother1 = mother1, pFather1 = father1, pMother2 = mother2, pFather2 = father2, pShapeMix = shapemix, pSkinMix = skinmix, userID = userID})
            end
        end
    end
end)

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    local userSource = vRP.getUserSource({user_id})
    TriggerClientEvent("saveUserID", userSource, user_id)

    MySQL.query("vRP/getCharacter", {pUserID = user_id}, function(userData, affected)
        for k,v in ipairs(userData) do
            TriggerClientEvent("setCharacterAfterSpawn", userSource, v.mother1, v.mother2, v.father1, v.father2, v.shapemix, v.skinmix)
        end
    end)
end)
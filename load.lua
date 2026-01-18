-- // Okay I just finished the key
-- // Now the loading 
-- // Lowkirkunely gotta make a repo

local root = "https://raw.githubusercontent.com/xxpwnxxx420lord/Nutho/refs/heads/main/games/"

-- // Alright we got the root link time for the mechanics

function isvaild(url)
    -- // okay we gotta make a file validation system
    local response = request ({
        Method = "GET",
        Url = url, -- //  I just did that from memory thats why they call my the goat
    })
    -- // Okay I forgot all of the response endpoints BUT Body ts bad
    -- // Synaspe X docs time
    -- // StatusCode is what we need
    if response.StatusCode ~= 200 then
        return false
    else
        return true
    end
end
-- // Just testing
-- print(tostring(isvaild(root)))
-- print(tostring(isvaild(root.."/168556275.lua")))

-- // Yay the tests work

if isvaild(root..tostring(game.PlaceId)..".lua") then
    loadstring(game:HttpGet(root..game.PlaceId..".lua"))()
else
    print("Didn't work") -- // why the fuck is it not working
end 

-- // I stared at this code for 5 minutes....
-- // oh i need .lua extension to the file
-- // yay it works

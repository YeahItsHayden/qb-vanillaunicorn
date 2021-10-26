-- Please don't read down, it's a mess
-- Still very much a WIP that i'll do later

stripperModelHash = `a_f_y_topless_01`
madeStrippers = false 

setupStrippers = function()
    for i, v in pairs(settings) do
        if v['strippers'].enabled then
            while true do 
                Wait(2500)

                if not madeStrippers then 
                    local stripperSettings = settings[i]['strippers'].coords
                    local plyCoords = GetEntityCoords(ped)

                    for i, v in pairs(stripperSettings) do
                        if #(plyCoords - vector3(v.x, v.y, v.z)) < 35 then 
                            RequestModel(stripperModelHash)

                            while not HasModelLoaded(stripperModelHash) do
                                Wait(10)
                            end

                            Wait(3000)

                            local stripper1 = CreatePed(1, stripperModelHash, v.x,  v.y,  v.z,  v.w, false, true)
                            local ad = "mini@strip_club@lap_dance_2g@ld_2g_p2"
                        
                            RequestAnimDict(ad)
                            
                            while not HasAnimDictLoaded(ad) do
                                Wait(1000)
                            end
                            
                            local scene1 = CreateSynchronizedScene( v.x,  v.y,  v.z, vec3(0.0, 0.0, 0.0), 2)

                            TaskSynchronizedScene(stripper1, scene1, ad, "ld_2g_p2_s1", 1.0, -4.0, 261, 0, 0)
                            FreezeEntityPosition(stripper1, true)	
                            SetEntityHeading(stripper1, v.w)
                            SetEntityInvincible(stripper1, true)
                            SetBlockingOfNonTemporaryEvents(stripper1, true)
                            SetSynchronizedSceneLooped(scene1, 1)
                            SetModelAsNoLongerNeeded(stripper1)
                            madeStrippers = true
                        else 
                            DeletePed(stripper1) 
                            madeStrippers = false
                        end 
                    end
                end
            end
        end 
    end
end
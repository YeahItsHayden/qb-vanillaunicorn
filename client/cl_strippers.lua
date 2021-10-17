-- Please don't read down, it's a mess

CreateThread(function()
    setupStrippers()
end)

stripperModelHash = `a_f_y_topless_01`

setupStrippers = function()
    for i, v in pairs(settings) do
        if v['strippers'].enabled then 
            RequestModel(stripperModelHash)

            while not HasModelLoaded(stripperModelHash) do
                Wait(10)
            end

            local stripperSettings = settings[i]['strippers'].coords

            for i, v in pairs(stripperSettings) do
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
                SetModelAsNoLongerNeeded(stripperModelHash)
            end
        end 
    end
end
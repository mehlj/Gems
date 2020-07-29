local NAME, db = ...
Gems = db

local score = 0

tileMap_horiz1 = {
    [1,1] = 0,
    [2] = 65,
    [3] = 130,
    [4] = 195,
    [5] = 260,
    [6] = 325,
    [7] = 390,
    [8] = 455,
    [9] = 520,
    [10] = 585,
    [11] = 650,
    [12] = 715
}

tileMap_vert1 = {
    [1] = 0,
    [2] = -66,
    [3] = -132,
    [4] = -198,
    [5] = -264,
    [6] = -330,
    [7] = -396,
    [8] = -462,
    [9] = -528,
    [10] = -594,
    [11] = -660,
    [12] = -726,
    [13] = -792,
}


local textures = {"Interface\\AddOns\\Gems\\Media\\Ability_Hunter_AimedShot",
                  "Interface\\AddOns\\Gems\\Media\\Ability_GolemStormBolt", 
                  "Interface\\AddOns\\Gems\\Media\\Ability_GolemThunderClap",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Gouge",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Hibernation",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Hunter_AspectOfTheMonkey",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Hunter_BeastCall"}


-- make frame
Gems.frame = CreateFrame("Frame", "Gems_Frame", UIParent, "BasicFrameTemplateWithInset")
Gems.frame:SetSize(700, 540) -- width, height
Gems.frame:SetPoint("CENTER") 
Gems.frame:Hide()
    
Gems.frame:EnableMouse(true)
Gems.frame:SetMovable(true)
Gems.frame:RegisterForDrag("LeftButton")
Gems.frame:SetScript("OnDragStart", Gems.frame.StartMoving)
Gems.frame:SetScript("OnDragStop", Gems.frame.StopMovingOrSizing)

Gems.frame:SetScript("OnKeyDown", function (self, key)
    if (key == "LEFT") or (key == "RIGHT") then
        Gems[key]()
    end
end)

-- set title
Gems.frame.title = Gems.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
Gems.frame.title:SetPoint("CENTER", Gems.frame.TitleBg, "CENTER", 5, 0)
Gems.frame.title:SetText("Gems")

-- UI Done button
Gems.frame.doneButton = CreateFrame("Button", nil, Gems.frame, "GameMenuButtonTemplate")
Gems.frame.doneButton:SetPoint("LEFT", Gems.frame, "BOTTOM", 165, 35)
Gems.frame.doneButton:SetSize(140, 40)
Gems.frame.doneButton:SetText("Done")
Gems.frame.doneButton:SetNormalFontObject("GameFontNormalLarge")
Gems.frame.doneButton:SetHighlightFontObject("GameFontHighlightLarge")
Gems.frame.doneButton:SetScript("OnClick", function ( ... )
    Gems:clear()
    Gems.frame:Hide()
end)

-- UI Start button
Gems.frame.startButton = CreateFrame("Button", nil, Gems.frame, "GameMenuButtonTemplate")
Gems.frame.startButton:SetPoint("LEFT", Gems.frame, "BOTTOM", 165, 95) 
Gems.frame.startButton:SetSize(140, 40)
Gems.frame.startButton:SetText("Start")
Gems.frame.startButton:SetNormalFontObject("GameFontNormalLarge")
Gems.frame.startButton:SetHighlightFontObject("GameFontHighlightLarge")
Gems.frame.startButton:SetScript("OnClick", function ( ... )
    Gems:newGame()
end)

-- score frame
Gems.scoreFrame = CreateFrame("Frame", "Gems_Score", Gems.frame, "ThinBorderTemplate")
Gems.scoreFrame:SetSize(220,517) -- width, height
Gems.scoreFrame:SetPoint("RIGHT", -5, -10) 

-- game frame
Gems.gameFrame = CreateFrame("Frame", "Gems_Game", Gems.frame, "ThinBorderTemplate")
Gems.gameFrame:SetSize(470,517) -- width, height
Gems.gameFrame:SetPoint("LEFT", 3, -10) 
Gems.gameFrame.texture = Gems.gameFrame:CreateTexture(nil, "BACKGROUND")


function Gems:gen_icon()
    -- place ability tooltip on grid
    texture_name = textures[ math.random( #textures ) ]
    Gems.gameFrame.texture:SetTexture(texture_name)
    Gems.gameFrame.texture:SetScale(0.6)
end

function Gems:leave_at_bottom()
    -- create texture
    bottom_tex = Gems.gameFrame:CreateTexture(nil, "BACKGROUND")
    texture_name = Gems.gameFrame.texture:GetTexture()
    bottom_tex:SetTexture(texture_name)
    bottom_tex:SetScale(0.6)
    
    -- set position
    before_point, before_relativeTo, before_relativePoint, before_xOfs, before_yOfs = Gems.gameFrame.texture:GetPoint()
    bottom_tex:SetPoint("TOPLEFT", before_xOfs, before_yOfs)
end

function Gems:newGame()
    self:clear()

    Gems:gen_icon()
    start_point = tileMap_horiz1[math.random(#tileMap_horiz1)]
    Gems.gameFrame.texture:SetPoint("TOPLEFT", start_point, tileMap_vert1[1])
   
    local gameLoop
    x = 1
    loop_count = 0
    
    function gameLoop()

        if x == 1 then
            Gems:gen_icon()
            start_point = tileMap_horiz1[math.random(#tileMap_horiz1)]
            Gems.gameFrame.texture:SetPoint("TOPLEFT", start_point, tileMap_vert1[1])
        end
    
        
        before_point, before_relativeTo, before_relativePoint, before_xOfs, before_yOfs = Gems.gameFrame.texture:GetPoint()
        
        -- check if texture is below us
        bottomtex1_point, bottomtex1_relativeTo, bottomtex1_relativePoint, bottomtex1_xOfs, bottomtex1_yOfs = bottom_tex1:GetPoint()
        bottomtex2_point, bottomtex2_relativeTo, bottomtex2_relativePoint, bottomtex2_xOfs, bottomtex2_yOfs = bottom_tex2:GetPoint()
        bottomtex3_point, bottomtex3_relativeTo, bottomtex3_relativePoint, bottomtex3_xOfs, bottomtex3_yOfs = bottom_tex3:GetPoint()
        bottomtex4_point, bottomtex4_relativeTo, bottomtex4_relativePoint, bottomtex4_xOfs, bottomtex4_yOfs = bottom_tex4:GetPoint()
        bottomtex5_point, bottomtex5_relativeTo, bottomtex5_relativePoint, bottomtex5_xOfs, bottomtex5_yOfs = bottom_tex5:GetPoint()
        bottomtex6_point, bottomtex6_relativeTo, bottomtex6_relativePoint, bottomtex6_xOfs, bottomtex6_yOfs = bottom_tex6:GetPoint()
        bottomtex7_point, bottomtex7_relativeTo, bottomtex7_relativePoint, bottomtex7_xOfs, bottomtex7_yOfs = bottom_tex7:GetPoint()
        bottomtex8_point, bottomtex8_relativeTo, bottomtex8_relativePoint, bottomtex8_xOfs, bottomtex8_yOfs = bottom_tex8:GetPoint()
        bottomtex9_point, bottomtex9_relativeTo, bottomtex9_relativePoint, bottomtex9_xOfs, bottomtex9_yOfs = bottom_tex9:GetPoint()
        bottomtex10_point, bottomtex10_relativeTo, bottomtex10_relativePoint, bottomtex10_xOfs, bottomtex10_yOfs = bottom_tex10:GetPoint()
        bottomtex11_point, bottomtex11_relativeTo, bottomtex11_relativePoint, bottomtex11_xOfs, bottomtex11_yOfs = bottom_tex11:GetPoint()
        bottomtex12_point, bottomtex12_relativeTo, bottomtex12_relativePoint, bottomtex12_xOfs, bottomtex12_yOfs = bottom_tex12:GetPoint()
        bottomtex13_point, bottomtex13_relativeTo, bottomtex13_relativePoint, bottomtex13_xOfs, bottomtex13_yOfs = bottom_tex13:GetPoint()

        print("before_yOfs is: ", before_yOfs)
        print("before_xOfs is: ", before_xOfs)
        print("bottomtex_yOfs is: ", bottomtex_yOfs)
        print("bottomtex_xOfs is: ", bottomtex_xOfs)

        if bottomtex_yOfs ~= nil
        then
            check_pos = bottomtex_yOfs + 66
        else
            check_pos = -726
        end

        print("check_pos is: ", check_pos)

        -- if (before_yOfs <= check_pos and bottomtex1_yOfs ~= nil) and bottomtex1_xOfs == before_xOfs
        -- else if (before_yOfs <= check_pos and bottomtex1_yOfs ~= nil) and bottomtex1_xOfs == before_xOfs


        -- below_1 = get


        if (before_yOfs <= check_pos and bottomtex1_yOfs ~= nil) and bottomtex1_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex2_yOfs ~= nil) and bottomtex2_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex3_yOfs ~= nil) and bottomtex3_xOfs == before_xOfs
            then
                print("texture is below us!") -- problem is here?
                Gems:leave_at_bottom()
                x = 1
                loop_count = loop_count+1
                print("loop counter: ", loop_count)
                check_pos = nil
    
                if loop_count < 3 then
                    C_Timer.After(0.7, gameLoop)
                end
            
                return
        else if (before_yOfs <= check_pos and bottomtex4_yOfs ~= nil) and bottomtex4_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return

        else if (before_yOfs <= check_pos and bottomtex5_yOfs ~= nil) and bottomtex5_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex6_yOfs ~= nil) and bottomtex6_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex7_yOfs ~= nil) and bottomtex7_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex8_yOfs ~= nil) and bottomtex8_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex9_yOfs ~= nil) and bottomtex9_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex10_yOfs ~= nil) and bottomtex10_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex11_yOfs ~= nil) and bottomtex11_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex12_yOfs ~= nil) and bottomtex12_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else if (before_yOfs <= check_pos and bottomtex13_yOfs ~= nil) and bottomtex13_xOfs == before_xOfs
        then
            print("texture is below us!") -- problem is here?
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return
        else
            Gems.gameFrame.texture:SetPoint("TOPLEFT", before_xOfs, tileMap_vert1[x])
            x = x+1
    
            after_point, after_relativeTo, after_relativePoint, after_xOfs, after_yOfs = Gems.gameFrame.texture:GetPoint()
        end

        if after_yOfs == -792
        then
            print("at bottom")
            Gems:leave_at_bottom()
            x = 1
            loop_count = loop_count+1
            print("loop counter: ", loop_count)
            check_pos = nil

            if loop_count < 3 then
                C_Timer.After(0.7, gameLoop)
            end
        
            return 
        else
            print("number of inside loops: ", x)

            C_Timer.After(0.7, gameLoop) --repeat in 1 sec
       end        
    end

    gameLoop()
end





function Gems:clear()
    Gems.gameFrame.texture:SetTexture(nil) -- needs fixing
end

-- key interaction functions
function Gems:LEFT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    if xOfs > 0
    then
        Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs - 65, yOfs)
    end
end

function Gems:RIGHT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    if xOfs < 715
    then
        Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs + 65, yOfs)
    end
end

-- Slash Commands
SLASH_GEMS1 = "/gems"
function SlashCmdList.GEMS(msg, editBox)
    GemsDB = GemsDB or {}
    GemsDB.scoreMax = GemsDB.scoreMax or 0
    Gems.frame:Show()
end

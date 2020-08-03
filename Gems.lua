local NAME, db = ...
Gems = db

local moves = false
local score = 0
local isPushable = {}
local tileCount = {}

local tileMap_horiz1 = {
    [1] = 0,
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

local tileMap_vert1 = {
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
                  "Interface\\AddOns\\Gems\\Media\\Ability_Rogue_Ambush",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Warrior_Charge",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Warrior_Sunder",
                  "Interface\\AddOns\\Gems\\Media\\Spell_Frost_Frostbolt",
                  "Interface\\AddOns\\Gems\\Media\\Spell_Holy_Resurrection",
                  "Interface\\AddOns\\Gems\\Media\\Spell_Holy_Resurrection",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Mount_Raptor",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Racial_Cannibalize",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Rogue_Sprint",
                  "Interface\\AddOns\\Gems\\Media\\Spell_Fire_Fireball",
                  "Interface\\AddOns\\Gems\\Media\\Ability_Hunter_BeastCall"}


score = 0
game_speed = 0.7 -- starting speed

-- 2d array of texture names
texture_names = {}
for i = 1, 12 do
    texture_names[i] = {}

    for j = 1, 13 do
        texture_names[i][j] = ""
    end
end

-- 2d array of booleans specifying if a texture exists at that coord
texture_exists = {}
for i = 1, 12 do
    texture_exists[i] = {}

    for j = 1, 13 do
        texture_exists[i][j] = false
    end
end

-- 2d array of texture objects
gems_textures = {}
for i = 1, 12 do
    gems_textures[i] = {}

    for j = 1, 13 do
        gems_textures[i][j] = nil
    end
end




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

-- score text
local score_text = CreateFrame("Frame",nil,Gems.scoreFrame)
score_text:SetWidth(1) 
score_text:SetHeight(1) 
score_text:SetAlpha(.90);
score_text:SetPoint("RIGHT", -100, 100)
score_text.text = score_text:CreateFontString(nil,"ARTWORK") 
score_text.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
score_text.text:SetPoint("CENTER",0,0)
score_text.text:SetFormattedText("Score: %d ", score)
score_text:Hide()


-- game frame
Gems.gameFrame = CreateFrame("Frame", "Gems_Game", Gems.frame, "ThinBorderTemplate")
Gems.gameFrame:SetSize(470,517) -- width, height
Gems.gameFrame:SetPoint("LEFT", 3, -10) 
Gems.gameFrame.texture = Gems.gameFrame:CreateTexture(nil, "BACKGROUND")

-- game over frame
local gameover_text = CreateFrame("Frame",nil,Gems.gameFrame)
gameover_text:SetWidth(1) 
gameover_text:SetHeight(1) 
gameover_text:SetAlpha(.90);
gameover_text:SetPoint("CENTER")
gameover_text.text = gameover_text:CreateFontString(nil,"ARTWORK") 
gameover_text.text:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE")
gameover_text.text:SetPoint("CENTER",0,0)
gameover_text.text:SetFormattedText("Game over! Final score was:  %d", score)
gameover_text:Hide()


-- bottom texture
bottom_tex = Gems.gameFrame:CreateTexture(nil, "BACKGROUND")



function round(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function Gems:gen_icon()
    -- place ability tooltip on grid
    texture_name = textures[ math.random( #textures ) ]
    Gems.gameFrame.texture:SetTexture(texture_name)
    Gems.gameFrame.texture:SetScale(0.6)
end

function Gems:leave_texture(check_x, check_y)
    -- create texture
    bottom_tex = Gems.gameFrame:CreateTexture(nil, "BACKGROUND")
    texture_name = Gems.gameFrame.texture:GetTexture()
    bottom_tex:SetTexture(texture_name)
    bottom_tex:SetScale(0.6)

    -- find position
    before_point, before_relativeTo, before_relativePoint, before_xOfs, before_yOfs = Gems.gameFrame.texture:GetPoint()

    -- after creating texture, add records in x2 two dimensional arrays for historical record
    texture_exists[check_x][check_y] = true
    texture_names[check_x][check_y] = Gems.gameFrame.texture:GetTexture()
    gems_textures[check_x][check_y] = bottom_tex


    --  set position
    bottom_tex:SetPoint("TOPLEFT", before_xOfs, before_yOfs)
end



function Gems:newGame()
    gameover_text:Hide()
    score_text:Show()

    Gems:gen_icon()
    start_point = tileMap_horiz1[math.random(#tileMap_horiz1)]
    Gems.gameFrame.texture:SetPoint("TOPLEFT", start_point, tileMap_vert1[1])
   
    local gameLoop
    x = 1
    loop_count = 0
    loop_end = false

    -- future todo:
        -- allow textures to the right and left to be x3 destroyed
        -- add buffs/debuffs on completing a x3 stack
        -- fix y=1 ending bug

    function gameLoop()

        if loop_end == true then
            return
        end

        -- update speed
        if score == 50 then
            game_speed = 0.6
        end
        if score == 100 then
            game_speed = 0.5
        end
        if score == 200 then
            game_speed = 0.4
        end
        if score == 300 then
            game_speed = 0.3
        end
        if score == 400 then
            game_speed = 0.2
        end
        if score == 700 then
            game_speed = 0.1
        end
        if score == 1000 then
            game_speed = 0.08
        end


        Gems.gameFrame.texture:Show()
        game_end = false

        for i = 1, 12 do        
            for j = 1, 13 do
                if texture_exists[i][j] ~= false then
                    if j == 1 then
                        game_end = true
                    end
                end
            end
        end

        if x == 1 and game_end == true then
            gameover_text:Show()
            Gems:clear()
            return -- ends loop
        end

        if x == 1 then
            Gems:gen_icon()
            start_point = tileMap_horiz1[math.random(#tileMap_horiz1)]
            Gems.gameFrame.texture:SetPoint("TOPLEFT", start_point, tileMap_vert1[1])
        end
    
        if (loop_over == true) then
            return
        end
        
        before_point, before_relativeTo, before_relativePoint, before_xOfs, before_yOfs = Gems.gameFrame.texture:GetPoint()

        check_x = 0
        check_y = 0

        for i,x in ipairs(tileMap_horiz1) do 
            for b,y in ipairs(tileMap_vert1) do
                if before_xOfs == x and round(before_yOfs) == y then 
                    check_x = i
                    check_y = b
                end
            end
        end

        -- check if texture is below us
        if texture_exists[check_x][check_y] == true then
            if texture_exists[check_x][check_y + 1] then
                --two textures below us
                if Gems.gameFrame.texture:GetTexture() == texture_names[check_x][check_y] and Gems.gameFrame.texture:GetTexture() == texture_names[check_x][check_y + 1] then
                    -- same three textures, remove these
                    Gems.gameFrame.texture:Hide()
                    gems_textures[check_x][check_y]:Hide()
                    gems_textures[check_x][check_y + 1]:Hide()

                    -- remove them from the arrays as well
                    Gems.gameFrame.texture:Hide()
                    gems_textures[check_x][check_y] = nil
                    texture_exists[check_x][check_y] = false
                    texture_names[check_x][check_y] = ""
                    gems_textures[check_x][check_y + 1] = nil
                    texture_exists[check_x][check_y + 1] = false
                    texture_names[check_x][check_y + 1] = ""

                    score = score + 50
                    score_text.text:SetFormattedText("Score: %d ", score)
                    score_text:Show()

                    x = 1
                    loop_count = loop_count+1
                    C_Timer.After(game_speed, gameLoop)
                    return
                else
                    --not same three textures. continue as normal
                    Gems:leave_texture(check_x, check_y - 1)
                    x = 1
                    loop_count = loop_count+1
    
                    C_Timer.After(game_speed, gameLoop)
                
                    return 
                end
            else
                Gems:leave_texture(check_x, check_y - 1)
                x = 1
                loop_count = loop_count+1

                C_Timer.After(game_speed, gameLoop)
            
                return 
            end

        else
            Gems.gameFrame.texture:SetPoint("TOPLEFT", before_xOfs, tileMap_vert1[x])
            x = x+1
    
            after_point, after_relativeTo, after_relativePoint, after_xOfs, after_yOfs = Gems.gameFrame.texture:GetPoint()
        end

        if after_yOfs == -792
        then
            Gems:leave_texture(check_x, check_y)
            x = 1
            loop_count = loop_count+1

            C_Timer.After(game_speed, gameLoop)
        
            return 
        else
            C_Timer.After(game_speed, gameLoop) --repeat in 1 sec
       end        
    end

    gameLoop()
end





function Gems:clear()
    -- clear gameFrame of all textures
    for i,x in ipairs(tileMap_horiz1) do 
        for b,y in ipairs(tileMap_vert1) do
            -- if a texture exists there
            if texture_exists[i][b] ~= false then
                Gems.gameFrame.texture:Hide()
                bottom_tex:Hide()
                gems_textures[i][b]:Hide()          
            end
        end
    end

    -- reset arrays
    for i = 1, 12 do
        for j = 1, 13 do
            texture_names[i][j] = ""
            texture_exists[i][j] = false
            gems_textures[i][j] = nil
        end
    end

    loop_end = true

end

-- key interaction functions
function Gems:LEFT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    if xOfs ~= nil then
        if xOfs > 0
        then
            Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs - 65, yOfs)
        end
    end
end

function Gems:RIGHT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    if xOfs ~= nil then
        if xOfs < 715
        then
            Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs + 65, yOfs)
        end
    end
end

-- Slash Commands
SLASH_GEMS1 = "/gems"
function SlashCmdList.GEMS(msg, editBox)
    GemsDB = GemsDB or {}
    GemsDB.scoreMax = GemsDB.scoreMax or 0
    Gems.frame:Show()
end

--Gems:clear()
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

local tileMap_horiz = {
    ["1_1"] = 0,
    ["1_2"] = 65,
    ["1_3"] = 130,
    ["1_4"] = 195,
    ["1_5"] = 260,
    ["1_6"] = 325,
    ["1_7"] = 390,
    ["1_8"] = 455,
    ["1_9"] = 520,
    ["1_10"] = 585,
    ["1_11"] = 650,
    ["1_12"] = 715,
    ["2_1"] = 0,
    ["2_2"] = 65,
    ["2_3"] = 130,
    ["2_4"] = 195,
    ["2_5"] = 260,
    ["2_6"] = 325,
    ["2_7"] = 390,
    ["2_8"] = 455,
    ["2_9"] = 520,
    ["2_10"] = 585,
    ["2_11"] = 650,
    ["2_12"] = 715,
    ["3_1"] = 0,
    ["3_2"] = 65,
    ["3_3"] = 130,
    ["3_4"] = 195,
    ["3_5"] = 260,
    ["3_6"] = 325,
    ["3_7"] = 390,
    ["3_8"] = 455,
    ["3_9"] = 520,
    ["3_10"] = 585,
    ["3_11"] = 650,
    ["3_12"] = 715,
    ["4_1"] = 0,
    ["4_2"] = 65,
    ["4_3"] = 130,
    ["4_4"] = 195,
    ["4_5"] = 260,
    ["4_6"] = 325,
    ["4_7"] = 390,
    ["4_8"] = 455,
    ["4_9"] = 520,
    ["4_10"] = 585,
    ["4_11"] = 650,
    ["4_12"] = 715,
    ["5_1"] = 0,
    ["5_2"] = 65,
    ["5_3"] = 130,
    ["5_4"] = 195,
    ["5_5"] = 260,
    ["5_6"] = 325,
    ["5_7"] = 390,
    ["5_8"] = 455,
    ["5_9"] = 520,
    ["5_10"] = 585,
    ["5_11"] = 650,
    ["5_12"] = 715,
    ["6_1"] = 0,
    ["6_2"] = 65,
    ["6_3"] = 130,
    ["6_4"] = 195,
    ["6_5"] = 260,
    ["6_6"] = 325,
    ["6_7"] = 390,
    ["6_8"] = 455,
    ["6_9"] = 520,
    ["6_10"] = 585,
    ["6_11"] = 650,
    ["6_12"] = 715,
    ["7_1"] = 0,
    ["7_2"] = 65,
    ["7_3"] = 130,
    ["7_4"] = 195,
    ["7_5"] = 260,
    ["7_6"] = 325,
    ["7_7"] = 390,
    ["7_8"] = 455,
    ["7_9"] = 520,
    ["7_10"] = 585,
    ["7_11"] = 650,
    ["7_12"] = 715,
    ["8_1"] = 0,
    ["8_2"] = 65,
    ["8_3"] = 130,
    ["8_4"] = 195,
    ["8_5"] = 260,
    ["8_6"] = 325,
    ["8_7"] = 390,
    ["8_8"] = 455,
    ["8_9"] = 520,
    ["8_10"] = 585,
    ["8_11"] = 650,
    ["8_12"] = 715,
    ["9_1"] = 0,
    ["9_2"] = 65,
    ["9_3"] = 130,
    ["9_4"] = 195,
    ["9_5"] = 260,
    ["9_6"] = 325,
    ["9_7"] = 390,
    ["9_8"] = 455,
    ["9_9"] = 520,
    ["9_10"] = 585,
    ["9_11"] = 650,
    ["9_12"] = 715,
    ["10_1"] = 0,
    ["10_2"] = 65,
    ["10_3"] = 130,
    ["10_4"] = 195,
    ["10_5"] = 260,
    ["10_6"] = 325,
    ["10_7"] = 390,
    ["10_8"] = 455,
    ["10_9"] = 520,
    ["10_10"] = 585,
    ["10_11"] = 650,
    ["10_12"] = 715,
    ["11_1"] = 0,
    ["11_2"] = 65,
    ["11_3"] = 130,
    ["11_4"] = 195,
    ["11_5"] = 260,
    ["11_6"] = 325,
    ["11_7"] = 390,
    ["11_8"] = 455,
    ["11_9"] = 520,
    ["11_10"] = 585,
    ["11_11"] = 650,
    ["11_12"] = 715,
    ["12_1"] = 0,
    ["12_2"] = 65,
    ["12_3"] = 130,
    ["12_4"] = 195,
    ["12_5"] = 260,
    ["12_6"] = 325,
    ["12_7"] = 390,
    ["12_8"] = 455,
    ["12_9"] = 520,
    ["12_10"] = 585,
    ["12_11"] = 650,
    ["12_12"] = 715,
    ["13_1"] = 0,
    ["13_2"] = 65,
    ["13_3"] = 130,
    ["13_4"] = 195,
    ["13_5"] = 260,
    ["13_6"] = 325,
    ["13_7"] = 390,
    ["13_8"] = 455,
    ["13_9"] = 520,
    ["13_10"] = 585,
    ["13_11"] = 650,
    ["13_12"] = 715,
}

local tileMap_vert = {
    ["1_1"] = 0,
    ["1_2"] = 0,
    ["1_3"] = 0,
    ["1_4"] = 0,
    ["1_5"] = 0,
    ["1_6"] = 0,
    ["1_7"] = 0,
    ["1_8"] = 0,
    ["1_9"] = 0,
    ["1_10"] = 0,
    ["1_11"] = 0,
    ["1_12"] = 0,
    ["2_1"] = -66,
    ["2_2"] = -66,
    ["2_3"] = -66,
    ["2_4"] = -66,
    ["2_5"] = -66,
    ["2_6"] = -66,
    ["2_7"] = -66,
    ["2_8"] = -66,
    ["2_9"] = -66,
    ["2_10"] = -66,
    ["2_11"] = -66,
    ["2_12"] = -66,
    ["3_1"] = -132,
    ["3_2"] = -132,
    ["3_3"] = -132,
    ["3_4"] = -132,
    ["3_5"] = -132,
    ["3_6"] = -132,
    ["3_7"] = -132,
    ["3_8"] = -132,
    ["3_9"] = -132,
    ["3_10"] = -132,
    ["3_11"] = -132,
    ["3_12"] = -132,
    ["4_1"] = -198,
    ["4_2"] = -198,
    ["4_3"] = -198,
    ["4_4"] = -198,
    ["4_5"] = -198,
    ["4_6"] = -198,
    ["4_7"] = -198,
    ["4_8"] = -198,
    ["4_9"] = -198,
    ["4_10"] = -198,
    ["4_11"] = -198,
    ["4_12"] = -198,
    ["5_1"] = -264,
    ["5_2"] = -264,
    ["5_3"] = -264,
    ["5_4"] = -264,
    ["5_5"] = -264,
    ["5_6"] = -264,
    ["5_7"] = -264,
    ["5_8"] = -264,
    ["5_9"] = -264,
    ["5_10"] = -264,
    ["5_11"] = -264,
    ["5_12"] = -264,
    ["6_1"] = -330,
    ["6_2"] = -330,
    ["6_3"] = -330,
    ["6_4"] = -330,
    ["6_5"] = -330,
    ["6_6"] = -330,
    ["6_7"] = -330,
    ["6_8"] = -330,
    ["6_9"] = -330,
    ["6_10"] = -330,
    ["6_11"] = -330,
    ["6_12"] = -330,
    ["7_1"] = -396,
    ["7_2"] = -396,
    ["7_3"] = -396,
    ["7_4"] = -396,
    ["7_5"] = -396,
    ["7_6"] = -396,
    ["7_7"] = -396,
    ["7_8"] = -396,
    ["7_9"] = -396,
    ["7_10"] = -396,
    ["7_11"] = -396,
    ["7_12"] = -396,
    ["8_1"] = -462,
    ["8_2"] = -462,
    ["8_3"] = -462,
    ["8_4"] = -462,
    ["8_5"] = -462,
    ["8_6"] = -462,
    ["8_7"] = -462,
    ["8_8"] = -462,
    ["8_9"] = -462,
    ["8_10"] = -462,
    ["8_11"] = -462,
    ["8_12"] = -462,
    ["9_1"] = -528,
    ["9_2"] = -528,
    ["9_3"] = -528,
    ["9_4"] = -528,
    ["9_5"] = -528,
    ["9_6"] = -528,
    ["9_7"] = -528,
    ["9_8"] = -528,
    ["9_9"] = -528,
    ["9_10"] = -594,
    ["9_11"] = -594,
    ["9_12"] = -594,
    ["10_1"] = -594,
    ["10_2"] = -594,
    ["10_3"] = -594,
    ["10_4"] = -594,
    ["10_5"] = -594,
    ["10_6"] = -594,
    ["10_7"] = -594,
    ["10_8"] = -594,
    ["10_9"] = -594,
    ["10_10"] = -528,
    ["10_11"] = -528,
    ["10_12"] = -528,
    ["11_1"] = -660,
    ["11_2"] = -660,
    ["11_3"] = -660,
    ["11_4"] = -660,
    ["11_5"] = -660,
    ["11_6"] = -660,
    ["11_7"] = -660,
    ["11_8"] = -660,
    ["11_9"] = -660,
    ["11_10"] = -660,
    ["11_11"] = -660,
    ["11_12"] = -660,
    ["12_1"] = -726,
    ["12_2"] = -726,
    ["12_3"] = -726,
    ["12_4"] = -726,
    ["12_5"] = -726,
    ["12_6"] = -726,
    ["12_7"] = -726,
    ["12_8"] = -726,
    ["12_9"] = -726,
    ["12_10"] = -726,
    ["12_11"] = -726,
    ["12_12"] = -726,
    ["13_1"] = -792,
    ["13_2"] = -792,
    ["13_3"] = -792,
    ["13_4"] = -792,
    ["13_5"] = -792,
    ["13_6"] = -792,
    ["13_7"] = -792,
    ["13_8"] = -792,
    ["13_9"] = -792,
    ["13_10"] = -792,
    ["13_11"] = -792,
    ["13_12"] = -792
}



-- TODO------------        
--- make keys interact with position of texture
    -- also, set limits on x coords (they can go out of bounds now)
-- allow textures to stack on one another
--- randomize texture that spawns

-- note: bug, pressing start a bunch of times keeps speeding textures up (should reset speed)



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
    print(key) 
    if (key == "DOWN") or (key == "LEFT") or (key == "RIGHT") then
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


function Gems:newGame()
    -- todo: reset score to zero

    -- reset board
    self:clear()


    Gems.gameFrame.texture:SetTexture("Interface\\AddOns\\Gems\\Media\\Ability_Hunter_AimedShot")
    Gems.gameFrame.texture:SetScale(0.6)

    start_point = tileMap_horiz1[math.random(#tileMap_horiz1)]
    Gems.gameFrame.texture:SetPoint("TOPLEFT", start_point, tileMap_vert["1_1"])


    local myFunc
    x = 1
    function myFunc()
        before_point, before_relativeTo, before_relativePoint, before_xOfs, before_yOfs = Gems.gameFrame.texture:GetPoint()

        Gems.gameFrame.texture:SetPoint("TOPLEFT", before_xOfs, tileMap_vert1[x])
        x = x+1

        after_point, after_relativeTo, after_relativePoint, after_xOfs, after_yOfs = Gems.gameFrame.texture:GetPoint()

        -- if y is > something or < something, do not let more key presses occur

        if after_yOfs == -792
        then
            print("at bottom")
            return
        else
            print("looping again")
            print(x)
            C_Timer.After(0.7, myFunc) --repeat in 1 sec
        end
    end

    myFunc()
end


function Gems:clear()
    Gems.gameFrame.texture:SetTexture(nil)
end

-- key interaction functions
function Gems:LEFT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs - 65, yOfs)
end

function Gems:RIGHT()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs + 65, yOfs)
end

function Gems:DOWN()
    point, relativeTo, relativePoint, xOfs, yOfs = Gems.gameFrame.texture:GetPoint()

    Gems.gameFrame.texture:SetPoint("TOPLEFT", xOfs, yOfs - 66)
end

-- Slash Commands
SLASH_GEMS1 = "/gems"
function SlashCmdList.GEMS(msg, editBox)
    GemsDB = GemsDB or {}
    GemsDB.scoreMax = GemsDB.scoreMax or 0
    Gems.frame:Show()
end

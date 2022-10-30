-- Plugin's name --
pluginName = "BrawlerMettleDisplay";

-- File names --
settingsFileName = "BrawlerMettleDisplay_Settings";

-- Users screen size --
screenWidth, screenHeight = Turbine.UI.Display:GetSize();

-- Get local player reference --
player = Turbine.Gameplay.LocalPlayer.GetInstance();

-- Default options --
defaultOptions = {
    xPos = screenWidth / 2,
    yPos = screenHeight / 2,
    enableMovement = true,
    displayNumber = true,
    mettleBarLenght = 30,
    mettleBarHeight = 10,
    mettleBarGap = 3,
    hideOutOfCombat = false,
    mettleUpdateFrequency = 10,
    pip_1_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_2_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_3_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_4_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_5_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_6_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_7_color = Turbine.UI.Color(0.808, 0.039, 0.094),
    pip_8_color = Turbine.UI.Color(0.808, 0.039, 0.094),
    pip_9_color = Turbine.UI.Color(0.808, 0.039, 0.094),
}

options = {
    xPos = screenWidth / 2,
    yPos = screenHeight / 2,
    enableMovement = true,
    displayNumber = true,
    mettleBarLenght = 30,
    mettleBarHeight = 10,
    mettleBarGap = 3,
    hideOutOfCombat = false,
    mettleUpdateFrequency = 10,
    pip_1_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_2_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_3_color = Turbine.UI.Color(0.996, 0.533, 0),
    pip_4_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_5_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_6_color = Turbine.UI.Color(1, 0.333, 0.012),
    pip_7_color = Turbine.UI.Color(0.808, 0.039, 0.094),
    pip_8_color = Turbine.UI.Color(0.808, 0.039, 0.094),
    pip_9_color = Turbine.UI.Color(0.808, 0.039, 0.094),
}

-- Color Picker position --
colorPickerLastPositionX = nil;
colorPickerLastPositionY = nil;

-- RGB color codes --
rgb = {
    pluginName = "<rgb=#DAA520>",
    error = "<rgb=#FF0000>",
    clear = "</rgb>",
};
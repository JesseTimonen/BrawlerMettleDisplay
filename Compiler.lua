-- Import Turbine/Lotro base libraries --
import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI.Lotro";


-- Import utility scripts --
import "BrawlerMettleDisplay.Scripts.Utility.Class";
import "BrawlerMettleDisplay.Scripts.Utility.Type";
import "BrawlerMettleDisplay.Scripts.Utility.RadioButton";


-- Import scripts that are required for other scripts to work --
import "BrawlerMettleDisplay.Scripts.Notification";
import "BrawlerMettleDisplay.Scripts.SaveLoad";
import "BrawlerMettleDisplay.Scripts.Init";


-- Make sure plugin loads only for brawlers --
if (Turbine.Gameplay.LocalPlayer.GetInstance():GetClass() ~= Turbine.Gameplay.Class.Brawler) then
    Scripts.notification("This plugin will only work for brawlers! Wrong class detected, therefore the plugin has been disabled.");
    return;
end


-- Import plugin activation --
import "BrawlerMettleDisplay.Scripts.Activation";


-- Import color picker --
import "BrawlerMettleDisplay.Scripts.ColorPicker";


-- Import main functionality --
import "BrawlerMettleDisplay.Scripts.Main";
import "BrawlerMettleDisplay.Scripts.Options";
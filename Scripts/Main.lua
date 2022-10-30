MettleWindow = class (Turbine.UI.Window)

function MettleWindow:Constructor()
	Turbine.UI.Window.Constructor(self)

	self:SetSize(options["mettleBarLenght"] * 9 + options["mettleBarGap"] * 8, options["mettleBarHeight"] + 20)
	self:SetPosition(options["xPos"], options["yPos"])
    self:SetWantsKeyEvents(true);
	self:SetVisible(true)
	if (options["hideOutOfCombat"]) then
        self:SetOpacity(0)
    else
        self:SetOpacity(1)
    end

    -- Hide the UI with F12 --
    self.KeyDown = function( sender, args)
        if (args.Action == 268435635) then
            self:SetVisible(not self:IsVisible());
        end
    end


	self.Mettle_label = Turbine.UI.Label()
	self.Mettle_label:SetParent(self)
    self.Mettle_label:SetSize(options["mettleBarHeight"] + 50, options["mettleBarHeight"] + 20)
	self.Mettle_label:SetPosition((self:GetWidth() / 2) - (self.Mettle_label:GetWidth() / 2), (self:GetHeight() / 2) - (self.Mettle_label:GetHeight() / 2))
    self.Mettle_label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter)
    self.Mettle_label:SetVisible(options["displayNumber"])
	self.Mettle_label:SetFont(Turbine.UI.Lotro.Font.TrajanProBold30)
    self.Mettle_label:SetText("0")
    self.Mettle_label:SetZOrder(2)
    self.Mettle_label:SetForeColor(Turbine.UI.Color.White)
    self.Mettle_label:SetOutlineColor(Turbine.UI.Color.Black)
    self.Mettle_label:SetFontStyle(Turbine.UI.FontStyle.Outline);
	self.Mettle_label:SetWantsUpdates(true);
	self.Mettle_label.current_mettle = 0;
	self.Mettle_label.delay = tonumber(options["mettleUpdateFrequency"]);

	-- Track mettle --
	self.Mettle_label.Update = function()

		self.Mettle_label.delay = self.Mettle_label.delay + 1;

		if (self.Mettle_label.delay > tonumber(options["mettleUpdateFrequency"])) then
			self.Mettle_label.delay = 0;

			local _battle_flow_found = false;

			for i = 1, player:GetEffects():GetCount(), 1 do

				if string.gsub(player:GetEffects():Get(i):GetName(), "%d", "") == "Battle Flow " or string.gsub(player:GetEffects():Get(i):GetName(), "%d", "") == "Kampffluss (Stufe )" or string.gsub(player:GetEffects():Get(i):GetName(), "%d", "") == "Flot de bataille " then

					local _current_mettle = tonumber(string.gsub(player:GetEffects():Get(i):GetName(), "%D", ""));
					_battle_flow_found = true;

					if (_current_mettle ~= self.Mettle_label.current_mettle) then
						self.Mettle_label.current_mettle = _current_mettle;
						self.Mettle_label:SetText(_current_mettle)
						self:UpdateMettleBars();
					end

					break;
				end
			end

			if (_battle_flow_found == false) then
				if (self.Mettle_label.current_mettle ~= 0) then
					self.Mettle_label.current_mettle = 0;
					self.Mettle_label:SetText("0")
					self:UpdateMettleBars();
				end
			end
		end
	end


	self.Mettle_1_parent = Turbine.UI.Control()
	self.Mettle_1_parent:SetParent(self)
	self.Mettle_1_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_1_parent:SetPosition(0, (self:GetHeight() / 2) - (self.Mettle_1_parent:GetHeight() / 2))
	self.Mettle_1_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_1_parent:SetVisible(true)
    self.Mettle_1_child = Turbine.UI.Control()
	self.Mettle_1_child:SetParent(self.Mettle_1_parent)
	self.Mettle_1_child:SetPosition(1, 1)
	self.Mettle_1_child:SetSize(self.Mettle_1_parent:GetWidth() - 2, self.Mettle_1_parent:GetHeight() - 2)
	self.Mettle_1_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_1_child:SetVisible(true)


    self.Mettle_2_parent = Turbine.UI.Control()
	self.Mettle_2_parent:SetParent(self)
	self.Mettle_2_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_2_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]), (self:GetHeight() / 2) - (self.Mettle_2_parent:GetHeight() / 2))
	self.Mettle_2_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_2_parent:SetVisible(true)
    self.Mettle_2_child = Turbine.UI.Control()
	self.Mettle_2_child:SetParent(self.Mettle_2_parent)
	self.Mettle_2_child:SetPosition(1, 1)
	self.Mettle_2_child:SetSize(self.Mettle_2_parent:GetWidth() - 2, self.Mettle_2_parent:GetHeight() - 2)
	self.Mettle_2_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_2_child:SetVisible(true)


    self.Mettle_3_parent = Turbine.UI.Control()
	self.Mettle_3_parent:SetParent(self)
	self.Mettle_3_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_3_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 2, (self:GetHeight() / 2) - (self.Mettle_3_parent:GetHeight() / 2))
	self.Mettle_3_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_3_parent:SetVisible(true)
    self.Mettle_3_child = Turbine.UI.Control()
	self.Mettle_3_child:SetParent(self.Mettle_3_parent)
	self.Mettle_3_child:SetPosition(1, 1)
	self.Mettle_3_child:SetSize(self.Mettle_3_parent:GetWidth() - 2, self.Mettle_3_parent:GetHeight() - 2)
	self.Mettle_3_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_3_child:SetVisible(true)


    self.Mettle_4_parent = Turbine.UI.Control()
	self.Mettle_4_parent:SetParent(self)
	self.Mettle_4_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_4_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 3, (self:GetHeight() / 2) - (self.Mettle_4_parent:GetHeight() / 2))
	self.Mettle_4_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_4_parent:SetVisible(true)
    self.Mettle_4_child = Turbine.UI.Control()
	self.Mettle_4_child:SetParent(self.Mettle_4_parent)
	self.Mettle_4_child:SetPosition(1, 1)
	self.Mettle_4_child:SetSize(self.Mettle_4_parent:GetWidth() - 2, self.Mettle_4_parent:GetHeight() - 2)
	self.Mettle_4_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_4_child:SetVisible(true)


    self.Mettle_5_parent = Turbine.UI.Control()
	self.Mettle_5_parent:SetParent(self)
	self.Mettle_5_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_5_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 4, (self:GetHeight() / 2) - (self.Mettle_5_parent:GetHeight() / 2))
	self.Mettle_5_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_5_parent:SetVisible(true)
    self.Mettle_5_child = Turbine.UI.Control()
	self.Mettle_5_child:SetParent(self.Mettle_5_parent)
	self.Mettle_5_child:SetPosition(1, 1)
	self.Mettle_5_child:SetSize(self.Mettle_5_parent:GetWidth() - 2, self.Mettle_5_parent:GetHeight() - 2)
	self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_5_child:SetVisible(true)


    self.Mettle_6_parent = Turbine.UI.Control()
	self.Mettle_6_parent:SetParent(self)
	self.Mettle_6_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_6_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 5, (self:GetHeight() / 2) - (self.Mettle_6_parent:GetHeight() / 2))
	self.Mettle_6_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_6_parent:SetVisible(true)
    self.Mettle_6_child = Turbine.UI.Control()
	self.Mettle_6_child:SetParent(self.Mettle_6_parent)
	self.Mettle_6_child:SetPosition(1, 1)
	self.Mettle_6_child:SetSize(self.Mettle_6_parent:GetWidth() - 2, self.Mettle_6_parent:GetHeight() - 2)
	self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_6_child:SetVisible(true)


    self.Mettle_7_parent = Turbine.UI.Control()
	self.Mettle_7_parent:SetParent(self)
	self.Mettle_7_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_7_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 6, (self:GetHeight() / 2) - (self.Mettle_7_parent:GetHeight() / 2))
	self.Mettle_7_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_7_parent:SetVisible(true)
    self.Mettle_7_child = Turbine.UI.Control()
	self.Mettle_7_child:SetParent(self.Mettle_7_parent)
	self.Mettle_7_child:SetPosition(1, 1)
	self.Mettle_7_child:SetSize(self.Mettle_7_parent:GetWidth() - 2, self.Mettle_7_parent:GetHeight() - 2)
	self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_7_child:SetVisible(true)


    self.Mettle_8_parent = Turbine.UI.Control()
	self.Mettle_8_parent:SetParent(self)
	self.Mettle_8_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_8_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 7, (self:GetHeight() / 2) - (self.Mettle_8_parent:GetHeight() / 2))
	self.Mettle_8_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_8_parent:SetVisible(true)
    self.Mettle_8_child = Turbine.UI.Control()
	self.Mettle_8_child:SetParent(self.Mettle_8_parent)
	self.Mettle_8_child:SetPosition(1, 1)
	self.Mettle_8_child:SetSize(self.Mettle_8_parent:GetWidth() - 2, self.Mettle_8_parent:GetHeight() - 2)
	self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_8_child:SetVisible(true)


    self.Mettle_9_parent = Turbine.UI.Control()
	self.Mettle_9_parent:SetParent(self)
	self.Mettle_9_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_9_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 8, (self:GetHeight() / 2) - (self.Mettle_9_parent:GetHeight() / 2))
	self.Mettle_9_parent:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_9_parent:SetVisible(true)
    self.Mettle_9_child = Turbine.UI.Control()
	self.Mettle_9_child:SetParent(self.Mettle_9_parent)
	self.Mettle_9_child:SetPosition(1, 1)
	self.Mettle_9_child:SetSize(self.Mettle_9_parent:GetWidth() - 2, self.Mettle_9_parent:GetHeight() - 2)
	self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
    self.Mettle_9_child:SetVisible(true)



    self.localPlayer = Turbine.Gameplay.LocalPlayer.GetInstance();
    self.localPlayer.InCombatChanged = function(sender, args)
        if (options["hideOutOfCombat"]) then
            self:SetWantsUpdates(true);
        end
    end
    self.localPlayer.InCombatChanged();

    self.Update = function()
        if (self.localPlayer:IsInCombat()) then
            self:SetOpacity(self:GetOpacity() + 0.02);
            if (self:GetOpacity() >= 1.0) then
                self:SetWantsUpdates(false);
            end
        else
            self:SetOpacity(self:GetOpacity() - 0.02);
            if (self:GetOpacity() <= 0) then
                self:SetWantsUpdates(false);
            end
        end
    end


	function MettleWindow:UpdateMettleBars()
		if (self.Mettle_label.current_mettle >= 9) then
			self.Mettle_1_child:SetBackColor(options["pip_9_color"])
			self.Mettle_2_child:SetBackColor(options["pip_9_color"])
			self.Mettle_3_child:SetBackColor(options["pip_9_color"])
			self.Mettle_4_child:SetBackColor(options["pip_9_color"])
			self.Mettle_5_child:SetBackColor(options["pip_9_color"])
			self.Mettle_6_child:SetBackColor(options["pip_9_color"])
			self.Mettle_7_child:SetBackColor(options["pip_9_color"])
			self.Mettle_8_child:SetBackColor(options["pip_9_color"])
			self.Mettle_9_child:SetBackColor(options["pip_9_color"])
		elseif (self.Mettle_label.current_mettle == 8) then
			self.Mettle_1_child:SetBackColor(options["pip_8_color"])
			self.Mettle_2_child:SetBackColor(options["pip_8_color"])
			self.Mettle_3_child:SetBackColor(options["pip_8_color"])
			self.Mettle_4_child:SetBackColor(options["pip_8_color"])
			self.Mettle_5_child:SetBackColor(options["pip_8_color"])
			self.Mettle_6_child:SetBackColor(options["pip_8_color"])
			self.Mettle_7_child:SetBackColor(options["pip_8_color"])
			self.Mettle_8_child:SetBackColor(options["pip_8_color"])
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 7) then
			self.Mettle_1_child:SetBackColor(options["pip_7_color"])
			self.Mettle_2_child:SetBackColor(options["pip_7_color"])
			self.Mettle_3_child:SetBackColor(options["pip_7_color"])
			self.Mettle_4_child:SetBackColor(options["pip_7_color"])
			self.Mettle_5_child:SetBackColor(options["pip_7_color"])
			self.Mettle_6_child:SetBackColor(options["pip_7_color"])
			self.Mettle_7_child:SetBackColor(options["pip_7_color"])
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 6) then
			self.Mettle_1_child:SetBackColor(options["pip_6_color"])
			self.Mettle_2_child:SetBackColor(options["pip_6_color"])
			self.Mettle_3_child:SetBackColor(options["pip_6_color"])
			self.Mettle_4_child:SetBackColor(options["pip_6_color"])
			self.Mettle_5_child:SetBackColor(options["pip_6_color"])
			self.Mettle_6_child:SetBackColor(options["pip_6_color"])
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 5) then
			self.Mettle_1_child:SetBackColor(options["pip_5_color"])
			self.Mettle_2_child:SetBackColor(options["pip_5_color"])
			self.Mettle_3_child:SetBackColor(options["pip_5_color"])
			self.Mettle_4_child:SetBackColor(options["pip_5_color"])
			self.Mettle_5_child:SetBackColor(options["pip_5_color"])
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 4) then
			self.Mettle_1_child:SetBackColor(options["pip_4_color"])
			self.Mettle_2_child:SetBackColor(options["pip_4_color"])
			self.Mettle_3_child:SetBackColor(options["pip_4_color"])
			self.Mettle_4_child:SetBackColor(options["pip_4_color"])
			self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 3) then
			self.Mettle_1_child:SetBackColor(options["pip_3_color"])
			self.Mettle_2_child:SetBackColor(options["pip_3_color"])
			self.Mettle_3_child:SetBackColor(options["pip_3_color"])
			self.Mettle_4_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 2) then
			self.Mettle_1_child:SetBackColor(options["pip_2_color"])
			self.Mettle_2_child:SetBackColor(options["pip_2_color"])
			self.Mettle_3_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_4_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		elseif (self.Mettle_label.current_mettle == 1) then
			self.Mettle_1_child:SetBackColor(options["pip_1_color"])
			self.Mettle_2_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_3_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_4_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		else
			self.Mettle_1_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_2_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_3_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_4_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_5_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_6_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_7_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_8_child:SetBackColor(Turbine.UI.Color.Black)
			self.Mettle_9_child:SetBackColor(Turbine.UI.Color.Black)
		end
	end


    -- Window Movement --
	self.moveControl = Turbine.UI.Control()
	self.moveControl:SetParent(self)
	self.moveControl:SetWidth(self:GetWidth())
	self.moveControl:SetHeight(self:GetHeight())
	self.moveControl:SetMouseVisible(options["enableMovement"])
	self.moveControl:SetZOrder(3)
	self.moveControl.MouseDown = function( sender, args )
		if args.Button == Turbine.UI.MouseButton.Left then
			self.dragging = true
			self.dragStartX = args.X
			self.dragStartY = args.Y
		end
	end

	self.moveControl.MouseMove = function( sender, args )
		if self.dragging then
			local x,y = self:GetPosition()
			x = x + ( args.X - self.dragStartX )
			y = y + ( args.Y - self.dragStartY )
			self:SetPosition( x, y )
		end
	end

	self.moveControl.MouseUp = function( sender, args )
		if args.Button == Turbine.UI.MouseButton.Left then
			self.dragging = false
            options["xPos"] = self:GetLeft()
			options["yPos"] = self:GetTop()
		end
	end
end


-- Update elements after options have been modified --
function MettleWindow:UpdateElements()

	self:SetSize(options["mettleBarLenght"] * 9 + options["mettleBarGap"] * 8, options["mettleBarHeight"] + 20)

    self.Mettle_label:SetSize(options["mettleBarHeight"] + 50, options["mettleBarHeight"] + 20)
	self.Mettle_label:SetPosition((self:GetWidth() / 2) - (self.Mettle_label:GetWidth() / 2), (self:GetHeight() / 2) - (self.Mettle_label:GetHeight() / 2))

	self.Mettle_1_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_1_parent:SetPosition(0, (self:GetHeight() / 2) - (self.Mettle_1_parent:GetHeight() / 2))
	self.Mettle_1_child:SetSize(self.Mettle_1_parent:GetWidth() - 2, self.Mettle_1_parent:GetHeight() - 2)

	self.Mettle_2_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_2_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]), (self:GetHeight() / 2) - (self.Mettle_2_parent:GetHeight() / 2))
	self.Mettle_2_child:SetSize(self.Mettle_2_parent:GetWidth() - 2, self.Mettle_2_parent:GetHeight() - 2)

	self.Mettle_3_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_3_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 2, (self:GetHeight() / 2) - (self.Mettle_3_parent:GetHeight() / 2))
	self.Mettle_3_child:SetSize(self.Mettle_3_parent:GetWidth() - 2, self.Mettle_3_parent:GetHeight() - 2)

	self.Mettle_4_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_4_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 3, (self:GetHeight() / 2) - (self.Mettle_4_parent:GetHeight() / 2))
	self.Mettle_4_child:SetSize(self.Mettle_4_parent:GetWidth() - 2, self.Mettle_4_parent:GetHeight() - 2)

	self.Mettle_5_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_5_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 4, (self:GetHeight() / 2) - (self.Mettle_5_parent:GetHeight() / 2))
	self.Mettle_5_child:SetSize(self.Mettle_5_parent:GetWidth() - 2, self.Mettle_5_parent:GetHeight() - 2)

	self.Mettle_6_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_6_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 5, (self:GetHeight() / 2) - (self.Mettle_6_parent:GetHeight() / 2))
	self.Mettle_6_child:SetSize(self.Mettle_6_parent:GetWidth() - 2, self.Mettle_6_parent:GetHeight() - 2)

	self.Mettle_7_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_7_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 6, (self:GetHeight() / 2) - (self.Mettle_7_parent:GetHeight() / 2))
	self.Mettle_7_child:SetSize(self.Mettle_7_parent:GetWidth() - 2, self.Mettle_7_parent:GetHeight() - 2)

	self.Mettle_8_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_8_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 7, (self:GetHeight() / 2) - (self.Mettle_8_parent:GetHeight() / 2))
	self.Mettle_8_child:SetSize(self.Mettle_8_parent:GetWidth() - 2, self.Mettle_8_parent:GetHeight() - 2)

	self.Mettle_9_parent:SetSize(options["mettleBarLenght"], options["mettleBarHeight"])
    self.Mettle_9_parent:SetPosition((options["mettleBarLenght"] + options["mettleBarGap"]) * 8, (self:GetHeight() / 2) - (self.Mettle_9_parent:GetHeight() / 2))
	self.Mettle_9_child:SetSize(self.Mettle_9_parent:GetWidth() - 2, self.Mettle_9_parent:GetHeight() - 2)

	self.moveControl:SetWidth(self:GetWidth())
	self.moveControl:SetHeight(self:GetHeight())
end


MettleWindowClass = MettleWindow();
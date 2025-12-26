-- Rewritted by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discrod Server: https://discord.gg/pY6nDej76m

-- Docs: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Properties%20and%20methods.luau
-- Example: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Example.luau
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

local function check(a, b, c)
    if not a then
        if b and b:len() > 0 then
            warn(`[!] {b}`, 2)
        end

        return c
    end

    return a
end

local cloneref = check(cloneref, "Your executor not support 'cloneref', library might be detected by Anti-Cheat!", function(o)
    return o
end)

local UserInputService = cloneref(game:GetService("UserInputService")) :: UserInputService
local TweenService = cloneref(game:GetService("TweenService")) :: TweenService
local Players = cloneref(game:GetService("Players")) :: Players
local CoreGui = cloneref(game:GetService("CoreGui")) :: CoreGui

do
    local NLibrary = CoreGui:FindFirstChild("N-Library")
    if NLibrary then
        NLibrary:Destroy()
    end
end

local library = {
    flags = {},

    toggled = true,

    dragSpeed = 0.1
}

local themes = {
	Dark = {
        Box = Color3.fromRGB(30, 30, 30),
		BoxFocused = Color3.fromRGB(40, 40, 40),

        ColorPicker = Color3.fromRGB(20, 20, 20),
		ColorPickerBoxes = Color3.fromRGB(30, 30, 30),

        Button = Color3.fromRGB(30, 30, 30),
		ButtonMouseOver = Color3.fromRGB(40, 40, 40),

        Section = Color3.fromRGB(20, 20, 20),
        MainFrame = Color3.fromRGB(30, 30, 30),

        TextColor = Color3.fromRGB(255, 255, 255),
		EnabledText = Color3.fromRGB(255, 255, 255),
		DisabledText = Color3.fromRGB(180, 180, 180),

        Dropdown = Color3.fromRGB(30, 30, 30),
        DropdownContent = Color3.fromRGB(20, 20, 20),
		DropdownMouseOver = Color3.fromRGB(40, 40, 40),

		ToggleDisabled = Color3.fromRGB(30, 30, 30),
        ToggleEnabled = Color3.fromRGB(179, 129, 148),
		ToggleDisabledMouseOver = Color3.fromRGB(40, 40, 40),
        ToggleEnabledMouseOver = Color3.fromRGB(209, 159, 178),

		Slider = Color3.fromRGB(30, 30, 30),
        SliderFill = Color3.fromRGB(179, 129, 148),
		SliderMouseOver = Color3.fromRGB(40, 40, 40),
		SliderFillSliding = Color3.fromRGB(209, 159, 178),

        Tab = Color3.fromRGB(30, 30, 30),
		TabBackground = Color3.fromRGB(20, 20, 20),
        TabToggleDisabled = Color3.fromRGB(5, 5, 5),
		TabToggleEnabled = Color3.fromRGB(30, 30, 30),
		TabToggleDisabledMouseOver = Color3.fromRGB(20, 20, 20),
	},

	Light = {
        Box = Color3.fromRGB(225, 225, 225),
        BoxFocused = Color3.fromRGB(215, 215, 215),

        ColorPicker = Color3.fromRGB(235, 235, 235),
        ColorPickerBoxes = Color3.fromRGB(225, 225, 225),

        Button = Color3.fromRGB(225, 225, 225),
        ButtonMouseOver = Color3.fromRGB(215, 215, 215),

        Section = Color3.fromRGB(235, 235, 235),
		MainFrame = Color3.fromRGB(225, 225, 225),

		TextColor = Color3.fromRGB(40, 40, 40),
        EnabledText = Color3.fromRGB(40, 40, 40),
        DisabledText = Color3.fromRGB(75, 75, 75),

        Dropdown = Color3.fromRGB(225, 225, 225),
        DropdownContent = Color3.fromRGB(235, 235, 235),
		DropdownMouseOver = Color3.fromRGB(215, 215, 215),

        ToggleEnabled = Color3.fromRGB(179, 129, 148),
		ToggleDisabled = Color3.fromRGB(225, 225, 225),
        ToggleEnabledMouseOver = Color3.fromRGB(209, 159, 178),
        ToggleDisabledMouseOver = Color3.fromRGB(215, 215, 215),

        Slider = Color3.fromRGB(225, 225, 225),
		SliderFill = Color3.fromRGB(179, 129, 148),
        SliderMouseOver = Color3.fromRGB(215, 215, 215),
        SliderFillSliding = Color3.fromRGB(209, 159, 178),

        Tab = Color3.fromRGB(225, 225, 225),
        TabBackground = Color3.fromRGB(235, 235, 235),
        TabToggleEnabled = Color3.fromRGB(225, 225, 225),
        TabToggleDisabled = Color3.fromRGB(250, 250, 250),
        TabToggleDisabledMouseOver = Color3.fromRGB(235, 235, 235),
	},

	PurpleAndBlack = {
		Box = Color3.fromRGB(83, 0, 124),
		BoxFocused = Color3.fromRGB(65, 0, 97),

		ColorPicker = Color3.fromRGB(83, 0, 124),
		ColorPickerBoxes = Color3.fromRGB(26, 4, 4),

		Button = Color3.fromRGB(83, 0, 124),
		ButtonMouseOver = Color3.fromRGB(83, 0, 124),

        Section = Color3.fromRGB(29, 29, 29),
		MainFrame = Color3.fromRGB(83, 0, 124),

		TextColor = Color3.fromRGB(255, 255, 255),
		EnabledText = Color3.fromRGB(255, 255, 255),
		DisabledText = Color3.fromRGB(255, 255, 255),

        Dropdown = Color3.fromRGB(83, 0, 124),
        DropdownContent = Color3.fromRGB(83, 0, 124),
		DropdownMouseOver = Color3.fromRGB(60, 0, 90),

		ToggleEnabled = Color3.fromRGB(85, 255, 0),
		ToggleDisabled = Color3.fromRGB(255, 0, 0),
		ToggleEnabledMouseOver = Color3.fromRGB(85, 255, 0),
		ToggleDisabledMouseOver = Color3.fromRGB(255, 0, 0),

		Slider = Color3.fromRGB(65, 0, 97),
		SliderFill = Color3.fromRGB(228, 77, 77),
		SliderMouseOver = Color3.fromRGB(65, 0, 97),
		SliderFillSliding = Color3.fromRGB(228, 77, 77),

        Tab = Color3.fromRGB(83, 0, 124),
        TabBackground = Color3.fromRGB(29, 29, 29),
        TabToggleEnabled = Color3.fromRGB(83, 0, 124),
		TabToggleDisabled = Color3.fromRGB(59, 24, 77),
		TabToggleDisabledMouseOver = Color3.fromRGB(59, 24, 77),
	},
	
	Wave = {
        Box = Color3.fromRGB(40, 55, 75),
		BoxFocused = Color3.fromRGB(50, 70, 95),

        ColorPicker = Color3.fromRGB(35, 50, 70),
		ColorPickerBoxes = Color3.fromRGB(30, 45, 65),

        Button = Color3.fromRGB(60, 140, 210),
		ButtonMouseOver = Color3.fromRGB(80, 160, 230),

        Section = Color3.fromRGB(15, 30, 50),
        MainFrame = Color3.fromRGB(25, 40, 60),

        TextColor = Color3.fromRGB(230, 240, 255),
        EnabledText = Color3.fromRGB(240, 250, 255),
		DisabledText = Color3.fromRGB(150, 180, 200),
        
        Dropdown = Color3.fromRGB(40, 55, 75),
        DropdownContent = Color3.fromRGB(25, 40, 65),
		DropdownMouseOver = Color3.fromRGB(50, 70, 95),

		ToggleEnabled = Color3.fromRGB(80, 200, 180),
		ToggleDisabled = Color3.fromRGB(220, 100, 100),
        ToggleEnabledMouseOver = Color3.fromRGB(100, 220, 200),
		ToggleDisabledMouseOver = Color3.fromRGB(240, 120, 120),

		Slider = Color3.fromRGB(45, 60, 80),
		SliderFill = Color3.fromRGB(100, 180, 255),
        SliderMouseOver = Color3.fromRGB(55, 75, 100),
		SliderFillSliding = Color3.fromRGB(120, 200, 255),

        Tab = Color3.fromRGB(30, 45, 65),
        TabBackground = Color3.fromRGB(20, 35, 55),
        TabToggleDisabled = Color3.fromRGB(35, 50, 70),
        TabToggleEnabled = Color3.fromRGB(70, 150, 220),
		TabToggleDisabledMouseOver = Color3.fromRGB(45, 60, 85),
	},

	Cosmic = {
        Box = Color3.fromRGB(35, 30, 60),
		BoxFocused = Color3.fromRGB(45, 40, 80),

        ColorPicker = Color3.fromRGB(30, 25, 50),
		ColorPickerBoxes = Color3.fromRGB(25, 20, 45),

        Button = Color3.fromRGB(100, 80, 200),
		ButtonMouseOver = Color3.fromRGB(120, 100, 220),

        Section = Color3.fromRGB(10, 5, 30),
        MainFrame = Color3.fromRGB(20, 15, 40),

		TextColor = Color3.fromRGB(230, 230, 255),
        EnabledText = Color3.fromRGB(240, 240, 255),
		DisabledText = Color3.fromRGB(140, 140, 180),

        Dropdown = Color3.fromRGB(35, 30, 60),
        DropdownContent = Color3.fromRGB(20, 15, 45),
		DropdownMouseOver = Color3.fromRGB(45, 40, 80),

        ToggleEnabled = Color3.fromRGB(80, 180, 220),
        ToggleDisabled = Color3.fromRGB(220, 80, 150),
		ToggleEnabledMouseOver = Color3.fromRGB(100, 200, 240),
		ToggleDisabledMouseOver = Color3.fromRGB(240, 100, 170),

		Slider = Color3.fromRGB(40, 35, 70),
        SliderFill = Color3.fromRGB(160, 140, 255),
		SliderMouseOver = Color3.fromRGB(50, 45, 90),
		SliderFillSliding = Color3.fromRGB(180, 160, 255),

        Tab = Color3.fromRGB(25, 20, 45),
        TabBackground = Color3.fromRGB(15, 10, 35),
        TabToggleDisabled = Color3.fromRGB(30, 25, 55),
        TabToggleEnabled = Color3.fromRGB(120, 100, 220),
		TabToggleDisabledMouseOver = Color3.fromRGB(40, 35, 75),
	},

	Sunset = {
        Box = Color3.fromRGB(75, 55, 75),
		BoxFocused = Color3.fromRGB(90, 70, 90),

        ColorPicker = Color3.fromRGB(70, 50, 70),
		ColorPickerBoxes = Color3.fromRGB(65, 45, 65),

        Button = Color3.fromRGB(255, 120, 60),
		ButtonMouseOver = Color3.fromRGB(255, 140, 80),

        Section = Color3.fromRGB(50, 30, 50),
        MainFrame = Color3.fromRGB(60, 40, 60),

        TextColor = Color3.fromRGB(255, 245, 235),
		EnabledText = Color3.fromRGB(255, 250, 240),
		DisabledText = Color3.fromRGB(180, 160, 180),

        Dropdown = Color3.fromRGB(75, 55, 75),
        DropdownContent = Color3.fromRGB(60, 40, 60),
		DropdownMouseOver = Color3.fromRGB(90, 70, 90),

        ToggleEnabled = Color3.fromRGB(255, 180, 100),
        ToggleDisabled = Color3.fromRGB(200, 100, 140),
		ToggleEnabledMouseOver = Color3.fromRGB(255, 200, 120),
		ToggleDisabledMouseOver = Color3.fromRGB(220, 120, 160),

		Slider = Color3.fromRGB(80, 60, 80),
        SliderFill = Color3.fromRGB(255, 160, 100),
		SliderMouseOver = Color3.fromRGB(95, 75, 95),
		SliderFillSliding = Color3.fromRGB(255, 180, 120),

        Tab = Color3.fromRGB(65, 45, 65),
        TabBackground = Color3.fromRGB(55, 35, 55),
        TabToggleDisabled = Color3.fromRGB(70, 50, 70),
		TabToggleEnabled = Color3.fromRGB(255, 140, 80),
		TabToggleDisabledMouseOver = Color3.fromRGB(85, 65, 85),
	},

	Metalic = {
        Box = Color3.fromRGB(32, 32, 38),
		BoxFocused = Color3.fromRGB(40, 40, 48),

        ColorPicker = Color3.fromRGB(30, 30, 38),
		ColorPickerBoxes = Color3.fromRGB(28, 28, 36),

        Button = Color3.fromRGB(60, 80, 120),
		ButtonMouseOver = Color3.fromRGB(80, 100, 140),

        Section = Color3.fromRGB(15, 15, 20),
        MainFrame = Color3.fromRGB(25, 25, 30),

		TextColor = Color3.fromRGB(200, 200, 200),
        EnabledText = Color3.fromRGB(210, 210, 210),
		DisabledText = Color3.fromRGB(120, 120, 130),

        Dropdown = Color3.fromRGB(32, 32, 38),
        DropdownContent = Color3.fromRGB(25, 25, 32),
		DropdownMouseOver = Color3.fromRGB(40, 40, 48),

        ToggleEnabled = Color3.fromRGB(100, 140, 100),
        ToggleDisabled = Color3.fromRGB(140, 80, 100),
		ToggleEnabledMouseOver = Color3.fromRGB(120, 160, 120),
		ToggleDisabledMouseOver = Color3.fromRGB(160, 100, 120),

		Slider = Color3.fromRGB(35, 35, 42),
        SliderFill = Color3.fromRGB(100, 120, 160),
		SliderMouseOver = Color3.fromRGB(45, 45, 55),
		SliderFillSliding = Color3.fromRGB(120, 140, 180),

        Tab = Color3.fromRGB(30, 30, 35),
		TabBackground = Color3.fromRGB(20, 20, 25),
        TabToggleDisabled = Color3.fromRGB(35, 35, 42),
		TabToggleEnabled = Color3.fromRGB(80, 100, 140),
		TabToggleDisabledMouseOver = Color3.fromRGB(45, 45, 55),
	}
}

local utility = {}

function utility.starts_with(str, start)
	return str:sub(1, string.len(start)) == start
end

function utility.create(class, properties)
	local obj = Instance.new(class)

	local forcedProperties = {
		BorderSizePixel = 0,
		AutoButtonColor = false
	}

	obj.Name = ""

	for i = 1, 16 do
		obj.Name = obj.Name .. string.char(math.random(48, 122))
	end

	for prop, v in next, properties do
		obj[prop] = v
	end

	for prop, v in next, forcedProperties do
		pcall(function()
			obj[prop] = v
		end)
	end

	return obj
end

function utility.tween(obj, info, properties, callback)
	local anim = TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
	anim:Play()

	if callback then
		anim.Completed:Connect(callback)
	end
end

function utility.ripple(obj)
	local ripple = Instance.new("Frame")
	Instance.new("UICorner", ripple).CornerRadius = UDim.new(0, 256)

	ripple.ZIndex = obj.ZIndex + 1
	ripple.Parent = obj
	ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
	ripple.BackgroundTransparency = 0.4

	utility.tween(ripple, {0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {BackgroundTransparency = 1, Size = UDim2.new(0, obj.AbsoluteSize.X, 0, obj.AbsoluteSize.X), Position = UDim2.new(0.5, -obj.AbsoluteSize.X / 2, 0.5, -obj.AbsoluteSize.X / 2)}, function() ripple:Destroy() end)
end

function utility.drag(obj)
	local start, objPosition, dragging

	obj.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			start = input.Position
			objPosition = obj.Position
		end
	end)

	obj.InputEnded:Connect(function(input )
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then   
			utility.tween(obj, {library.dragSpeed}, {Position = UDim2.new(objPosition.X.Scale, objPosition.X.Offset + (input.Position - start).X, objPosition.Y.Scale, objPosition.Y.Offset + (input.Position - start).Y)})
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch and dragging then   
			utility.tween(obj, {library.dragSpeed}, {Position = UDim2.new(objPosition.X.Scale, objPosition.X.Offset + (input.Position - start).X, objPosition.Y.Scale, objPosition.Y.Offset + (input.Position - start).Y)})
		end
	end)
end

function utility.get_center(sizeX, sizeY)
	return UDim2.new(0.5, -(sizeX / 2), 0.5, -(sizeY / 2))
end

function utility.hex_to_rgb(hex)
	return Color3.fromRGB(tonumber("0x" .. hex:sub(2, 3)), tonumber("0x" .. hex:sub(4, 5)), tonumber("0x"..hex:sub(6, 7)))
end

function utility.rgb_to_hex(color)
	return string.format("#%02X%02X%02X", math.clamp(color.R * 255, 0, 255), math.clamp(color.G * 255, 0, 255), math.clamp(color.B * 255, 0, 255))
end

function utility.format_table(tbl)
	if tbl then
		local oldtbl = tbl
		local newtbl = {}
		local formattedtbl = {}

		for option, v in next, oldtbl do
			newtbl[option:lower()] = v
		end

		setmetatable(formattedtbl, {
			__newindex = function(t, k, v)
				rawset(newtbl, k:lower(), v)
			end,
            
			__index = function(t, k, v)
				return newtbl[k:lower()]
			end
		})

		return formattedtbl
	else
		return {}
	end
end

local NLibrary = utility.create("ScreenGui", {})
NLibrary.Name = "N-Library"
NLibrary.Parent = CoreGui

local Mouse = Players.LocalPlayer:GetMouse()
Mouse.KeyDown:Connect(function(Key)
	if Key == "z" then
		library.toggled = not library.toggled

		NLibrary.Enabled = library.toggled
	end
end)

function library:MakeWindow(opts)
	local options = utility.format_table(opts)
	local name = options.name
	local sizeX = options.sizeX or 330
	local sizeY = options.sizeY or 360
	local theme = themes[options.theme] or themes.Dark
	local colorOverrides = options.colorOverrides or {}

	for i, v in next, colorOverrides do
		if theme[i] then
			theme[i] = v
		end
	end

	local holder = utility.create("Frame", {
		Size = UDim2.new(0, sizeX, 0, 26),
		BackgroundTransparency = 1,
		Position = utility.get_center(sizeX, sizeY),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Parent = NLibrary
	})

	utility.create("TextLabel", {
		Size = UDim2.new(0, 1, 1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		FontSize = Enum.FontSize.Size14,
		TextSize = 14,
		TextColor3 = theme.TextColor,
		Text = name,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 2,
		Parent = holder
	})

	utility.drag(holder)

	local main = utility.create("Frame", {
		Size = UDim2.new(1, 0, 0, sizeY),
		BackgroundColor3 = theme.MainFrame,
		Parent = holder
	})

	utility.create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = main
	})

	local tabs = utility.create("Frame", {
		ZIndex = 2,
		Size = UDim2.new(1, -16, 1, -34),
		Position = UDim2.new(0, 8, 0, 26),
		BackgroundColor3 = theme.TabBackground,
		Parent = main
	})


	utility.create("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = tabs
	})

	local tabToggles = utility.create("Frame", {
		Size = UDim2.new(1, -12, 0, 18),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 6, 0, 6),
		Parent = tabs
	})

	local tabFrames = utility.create("Frame", {
		ZIndex = 4,
		Size = UDim2.new(1, -12, 1, -29),
		Position = UDim2.new(0, 6, 0, 24),
		BackgroundColor3 = theme.Tab,
		Parent = tabs
	})

	utility.create("UICorner", {
		Parent = tabFrames
	})

	local tabFrameHolder = utility.create("Frame", {
		Size = UDim2.new(1, -12, 1, -12),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 6, 0, 6),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		Parent = tabFrames
	})

	utility.create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
		Parent = tabToggles
	})

	local windowTypes = {count = 0}
	windowTypes = utility.format_table(windowTypes)

	function windowTypes:Hide()
		NLibrary.Enabled = false
	end

	function windowTypes:Show()
		NLibrary.Enabled = true
	end

	function windowTypes:Destroy()
		NLibrary:Destroy()
	end

	function windowTypes:MakeTab(optss)
		windowTypes.count = windowTypes.count + 1
		local toggled = windowTypes.count == 1

		local tabToggle = utility.create("TextButton", {
			ZIndex = 4,
			BackgroundColor3 = toggled and theme.TabToggleEnabled or theme.TabToggleDisabled,
			Size = UDim2.new(0, 52, 1, 0),
			FontSize = Enum.FontSize.Size12,
			TextSize = 12,
			TextColor3 = toggled and theme.EnabledText or theme.DisabledText,
			Text = optss.Text,
			Font = Enum.Font.Gotham,
			Parent = tabToggles
		})

		if tabToggle.TextBounds.X + 16 > 52 then
			tabToggle.Size = UDim2.new(0, tabToggle.TextBounds.X + 16, 1, 0)
		end

		local noround = utility.create("Frame", {
			ZIndex = 3,
			Size = UDim2.new(1, 0, 1, 5),
			Position = UDim2.new(0, 0, 1, -10),
			BackgroundColor3 = toggled and theme.TabToggleEnabled or theme.TabToggleDisabled,
			Parent = tabToggle
		})

		tabToggle:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
			noround.BackgroundColor3 = tabToggle.BackgroundColor3
		end)

		utility.create("UICorner", {
			CornerRadius = UDim.new(0, 8),
			Parent = tabToggle
		})

		local tab = utility.create("Frame", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Visible = toggled,
			Parent = tabFrameHolder
		})

		utility.create("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			Parent = tab
		})

		local column1 = utility.create("ScrollingFrame", {
			Size = UDim2.new(0.5, -3, 1, 0),
			BackgroundTransparency = 1,
			Active = true,
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Parent = tab
		})

		local column1list = utility.create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			Parent = column1
		})

		column1list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			column1.CanvasSize = UDim2.new(0, 0, 0, column1list.AbsoluteContentSize.Y)
		end)

		local column2 = utility.create("ScrollingFrame", {
			Size = UDim2.new(0.5, -3, 1, 0),
			BackgroundTransparency = 1,
			Active = true,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			Parent = tab
		})

		local column2list = utility.create("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			Parent = column2
		})

		column2list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			column2.CanvasSize = UDim2.new(0, 0, 0, column2list.AbsoluteContentSize.Y)
		end)

		local function toggleTab()
			for i, v in next, tabFrameHolder:GetChildren() do
				if v ~= tab then
					v.Visible = false
				end
			end

			tab.Visible = true

			for i, v in next, tabToggles:GetChildren() do
				if v:IsA("TextButton") then
					if v ~= tabToggle then
						utility.tween(v, {0.2}, {TextColor3 = theme.DisabledText, BackgroundColor3 = theme.TabToggleDisabled})
					end
				end
			end

			utility.tween(tabToggle, {0.2}, {TextColor3 = theme.EnabledText, BackgroundColor3 = theme.TabToggleEnabled})
		end

		tabToggle.MouseButton1Click:Connect(toggleTab)

		tabToggle.MouseEnter:Connect(function()
			if not tab.Visible then
				utility.tween(tabToggle, {0.2}, {BackgroundColor3 = theme.TabToggleDisabledMouseOver})
			end
		end)

		tabToggle.MouseLeave:Connect(function()
			if not tab.Visible then
				utility.tween(tabToggle, {0.2}, {BackgroundColor3 = theme.TabToggleDisabled})
			end
		end)

		local tabTypes = {}
		tabTypes = utility.format_table(tabTypes)

		function tabTypes:Open()
			toggleTab()
		end

		function tabTypes:Hide()
			tab.Visible = false
		end

		function tabTypes:Show()
			tab.Visible = true
		end

		function tabTypes:Destroy()
			tab:Destroy()

			if column2 then
				column2:Destroy()
			end

			if column1 then
				column1:Destroy()
			end

			if noround then
				noround:Destroy()
			end

			if tabToggle then
				tabToggle:Destroy()
			end
		end

		function tabTypes:MakeSection(optssss)
			local Text = optssss.Text
			local column = optssss.Column or 1
			column = column == 1 and column1 or column == 2 and column2

			local section = utility.create("Frame", {
				ZIndex = 5,
				Size = UDim2.new(1, 0, 0, 24),
				BackgroundColor3 = theme.Section,
				Parent = column
			})

			utility.create("UICorner", {
				Parent = section
			})

			utility.create("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 16),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 8, 0, 4),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = theme.TextColor,
				Text = Text,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = section
			})

			local sectionContent = utility.create("Frame", {
				Size = UDim2.new(1, -10, 1, -24),
				Position = UDim2.new(0, 5, 0, 22),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = section
			})

			local sectionContentList = utility.create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
				Parent = sectionContent
			})

			sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				section.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 27)
			end)

			local sectionTypes = {}
			sectionTypes = utility.format_table(sectionTypes)

			function sectionTypes:Hide()
				section.Visible = false
			end

			function sectionTypes:Show()
				section.Visible = true
			end

			function sectionTypes:Destroy()
				section:Destroy()
			end

			function sectionTypes:MakeLabel(opt)
				local label = utility.create("TextLabel", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 5, 0, 0),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					Text = opt.Text,
					TextColor3 = theme.TextColor,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sectionContent
				})

				local labelTypes = {}
				labelTypes = utility.format_table(labelTypes)

				function labelTypes:Hide()
					label.Visible = false
				end

				function labelTypes:Show()
					label.Visible = true
				end

				function labelTypes:Destroy()
					label:Destroy()
				end

				function labelTypes:GetText()
					return label.Text
				end

				function labelTypes:SetText(newText: string)
					label.Text = newText
				end

				return labelTypes
			end

			function sectionTypes:MakeButton(opts)
				local options = utility.format_table(opts)
				local name = options.name
				local callback = options.callback

				local button = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundColor3 = theme.Button,
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					Text = name,
					TextColor3 = theme.TextColor,
					Font = Enum.Font.Gotham,
					ClipsDescendants = true,
					Parent = sectionContent
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = button
				})

				local function click()
					task.spawn(callback)
					task.spawn(utility.ripple, button)
				end

				button.MouseButton1Click:Connect(click)

				button.MouseEnter:Connect(function()
					utility.tween(button, {0.2}, {BackgroundColor3 = theme.ButtonMouseOver})
				end)

				button.MouseLeave:Connect(function()
					utility.tween(button, {0.2}, {BackgroundColor3 = theme.Button})
				end)

				local buttonTypes = {}
				buttonTypes = utility.format_table(buttonTypes)

				function buttonTypes:Fire()
					click()
				end

				function buttonTypes:Hide()
					button.Visible = false
				end

				function buttonTypes:Show()
					button.Visible = true
				end

				function buttonTypes:Destroy()
					button:Destroy()
				end

				return buttonTypes
			end

			function sectionTypes:MakeToggle(opts)
				local options = utility.format_table(opts)
				local name = options.Text
				local flag = options.Flag or nil
				local callback = options.callback or function() end

				local toggled = false
				local mouseOver = false

				local toggle = utility.create("TextButton", {
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					FontSize = Enum.FontSize.Size14,
					TextSize = 14,
					Text = "",
					Font = Enum.Font.SourceSans,
					Parent = sectionContent
				})

				local icon = utility.create("Frame", {
					ZIndex = 6,
					Size = UDim2.new(0, 10, 0, 10),
					BackgroundColor3 = theme.ToggleDisabled,
					Parent = toggle
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 12),
					Parent = icon
				})

				local title = utility.create("TextLabel", {
					ZIndex = 6,
					Size = UDim2.new(0, 1, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 5, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.DisabledText,
					Text = name,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = icon
				})

				local function toggleToggle()
					toggled = not toggled

					utility.tween(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

					if not mouseOver then
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
					else
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
					end

					task.spawn(callback, toggled)

					if flag then
						library.flags[flag] = toggled
					end
				end

				toggle.MouseButton1Click:connect(toggleToggle)

				toggle.MouseEnter:Connect(function()
					mouseOver = true
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
				end)

				toggle.MouseLeave:Connect(function()
					mouseOver = false
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
				end)

				local toggleTypes = {}
				toggleTypes = utility.format_table(toggleTypes)

				function toggleTypes:Toggle(bool: boolean)
					if toggled ~= bool then
						toggleToggle()
					end
				end

				function toggleTypes:Click()
					toggled = not toggled

					toggleToggle()
				end

				function toggleTypes:Hide()
					toggle.Visible = false
				end

				function toggleTypes:Show()
					toggle.Visible = true
				end

				function toggleTypes:Destroy()
					toggle:Destroy()
				end

				return toggleTypes
			end

			function sectionTypes:MakeTextBox(opts)
				local options = utility.format_table(opts)
				local placeholder = options.Text or options.placeholder
				local flag = options.Flag or nil
				local callback = options.callback or nil

				local mouseOver = false
				local focused = false

				local box = utility.create("TextBox", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundColor3 = theme.Box,
					PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = "",
					Font = Enum.Font.Gotham,
					PlaceholderText = placeholder,
					Parent = sectionContent
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = box
				})

				local function boxFinished()
					focused = false

					if not mouseOver then
						utility.tween(box, {0.2}, {BackgroundColor3 = theme.Box})
					end

					if flag then
						library.flags[flag] = box.Text
					end

					task.spawn(callback, box.Text)
				end

				box.Focused:Connect(function()
					focused = true
					utility.tween(box, {0.2}, {BackgroundColor3 = theme.BoxFocused})
				end)

				box.MouseEnter:Connect(function()
					mouseOver = true
					utility.tween(box, {0.2}, {BackgroundColor3 = theme.BoxFocused})
				end)

				box.MouseLeave:Connect(function()
					mouseOver = false
					if not focused then
						utility.tween(box, {0.2}, {BackgroundColor3 = theme.Box})
					end
				end)

				box.FocusLost:Connect(boxFinished)

				local boxTypes = {}
				boxTypes = utility.format_table(boxTypes)

				function boxTypes:Set(text)
					box.Text = tostring(text)
				end

				function boxTypes:Get()
					return tostring(box.Text)
				end

				function boxTypes:Hide()
					box.Visible = false
				end

				function boxTypes:Show()
					box.Visible = true
				end

				function boxTypes:Clear()
					box.Text = ""
				end

				function boxTypes:ClearAfterClick(Bool: boolean)
					box.ClearTextOnFocus = Bool
				end

				function boxTypes:ChangePlaceHolder(Text: string)
					box.PlaceholderText = Text
				end

				function boxTypes:Destroy()
					box:Destroy()
				end

				return boxTypes
			end

			function sectionTypes:MakeSlider(opts)
				local options = utility.format_table(opts)
				local name = options.Text
				local min = options.Min or 1
				local max = options.Max or 100
				local decimals = options.Decimals or 0.1
				local default = options.Default and math.clamp(options.default, min, max) or min
				local valueType = options.ValueType or "/" .. tostring(max)
				local flag = options.flag or nil
				local callback = options.callback or function() end

				local mouseOver = false
				local sliding = false

				local slider = utility.create("Frame", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 16),
					ClipsDescendants = true,
					BackgroundColor3 = theme.Slider,
					Parent = sectionContent
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = slider
				})

				local fill = utility.create("Frame", {
					ZIndex = 7,
					Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
					BackgroundColor3 = theme.SliderFill,
					Parent = slider
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = fill
				})

				local title = utility.create("TextLabel", {
					ZIndex = 8,
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = name .. ": " .. default .. valueType .. max,
					Font = Enum.Font.Gotham,
					Parent = slider
				})

				local function slide(input)
					local sizeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
					utility.tween(fill, {0.3}, {Size = UDim2.new(sizeX, 0, 1, 0)})

					local value = math.floor((((max - min) * sizeX) + min) * (decimals * 10)) / (decimals * 10)
					title.Text = name .. ": " .. value .. valueType .. max

					if flag then 
						library.flags[flag] = value
					end

					task.spawn(callback, value)
				end

				slider.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						sliding = true
						utility.tween(fill, {0.2}, {BackgroundColor3 = theme.SliderFillSliding})
						slide(input)
					end
				end)

				slider.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						utility.tween(fill, {0.2}, {BackgroundColor3 = theme.SliderFill})
						sliding = false
						if not mouseOver then
							utility.tween(slider, {0.2}, {BackgroundColor3 = theme.Slider})
						end
					end
				end)

				slider.MouseEnter:Connect(function()
					mouseOver = true
					utility.tween(slider, {0.2}, {BackgroundColor3 = theme.SliderMouseOver})
				end)

				slider.MouseLeave:Connect(function()
					mouseOver = false
					if not sliding then
						utility.tween(slider, {0.2}, {BackgroundColor3 = theme.Slider})
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if sliding then
							slide(input)
						end
					end
				end)

				local sliderTypes = {}
				sliderTypes = utility.format_table(sliderTypes)

				function sliderTypes:Set(value)
					if value > max then
						value = max
					end

					value = math.floor(value * (decimals * 10)) / (decimals * 10)
					value = math.clamp(value, min, max)

					fill.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
					title.Text = name .. ": " .. value .. valueType .. max
				end

				function sliderTypes:SetMax(newMax: number)
					max = newMax

					title = name .. ": " .. default .. valueType .. max
				end

				function sliderTypes:Hide()
					slider.Visible = false
				end

				function sliderTypes:Show()
					slider.Visible = true
				end

				function sliderTypes:Destroy()
					slider:Destroy()
				end

				return sliderTypes
			end

			function sectionTypes:MakeDropdown(opts)
				local options = utility.format_table(opts)
				local default = options.Default or nil
				local contentTable = options.Content or {}
				local multiChoice = options.multiChoice or false
				local flag = options.flag or nil
				local callback = options.callback or function() end

				local chosen = {}
				local curValue = default
				local open = false
				local optionInstances = {}

				local defaultInContent = false

				for i, v in next, contentTable do
					if v == default then
						defaultInContent = true
					end
				end

				default = defaultInContent and default or nil

				local dropdown = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundColor3 = theme.Dropdown,
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = "",
					Font = Enum.Font.Gotham,
					Parent = sectionContent
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = dropdown
				})

				local value = utility.create("TextLabel", {
					ZIndex = 7,
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 5, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = default and theme.EnabledText or theme.DisabledText,
					Text = default or "NONE",
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = dropdown
				})

				local icon = utility.create("ImageLabel", {
					ZIndex = 7,
					Size = UDim2.new(0, 10, 0, 11),
					Rotation = 180,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -16, 0, 3),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Image = "http://www.roblox.com/asset/?id=8233647312",
					Parent = dropdown
				})

				local content = utility.create("Frame", {
					ZIndex = 10,
					Visible = false,
					Size = UDim2.new(1, 0, 0, 0),
					ClipsDescendants = true,
					Position = UDim2.new(0, 0, 1, 6),
					BackgroundColor3 = theme.DropdownContent,
					Parent = dropdown
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = content
				})

				local contentHolder = utility.create("Frame", {
					Size = UDim2.new(1, -6, 1, 0),
					Position = UDim2.new(0, 6, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = content
				})

				local contentList = utility.create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = contentHolder
				})

				local function toggleDropdown()
					open = not open
					local sizeX = UDim2.new(1, 0, 0, open and contentList.AbsoluteContentSize.Y or 0)
					local rotation = open and 0 or 180

					if open then
						content.Visible = open
					end

					utility.tween(content, {#contentTable * 0.1}, {Size = sizeX}, function() content.Visible = open end)
					utility.tween(icon, {0.2}, {Rotation = rotation})
				end

				dropdown.MouseButton1Click:connect(toggleDropdown)

				dropdown.MouseEnter:Connect(function()
					utility.tween(dropdown, {0.2}, {BackgroundColor3 = theme.DropdownMouseOver})
				end)

				dropdown.MouseLeave:Connect(function()
					utility.tween(dropdown, {0.2}, {BackgroundColor3 = theme.Dropdown})
				end)

				for i, v in next, contentTable do
					local option = utility.create("TextButton", {
						ZIndex = 11,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontSize = Enum.FontSize.Size12,
						TextSize = 12,
						TextColor3 = v == default and theme.EnabledText or theme.DisabledText,
						Text = v,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						Parent = contentHolder
					})

					optionInstances[v] = option

					if v == default then
						if not multiChoice then
							if flag then
								library.flags[flag] = v
							end

							task.spawn(callback, v)
						else
							table.insert(chosen, v)

							if flag then
								library.flags[flag] = chosen
							end

							task.spawn(callback, chosen)
						end
					end

					option.MouseButton1Click:connect(function()
						if not multiChoice then
							if curValue ~= v then
								curValue = v

								for i2, v2 in next, contentHolder:GetChildren() do
									if v2:IsA("TextButton") then
										utility.tween(v2, {0.2}, {TextColor3 = theme.DisabledText})
									end
								end

								utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.EnabledText
									value.Text = v
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = v
								end
								callback(v)
							else
								curValue = nil
								utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.DisabledText
									value.Text = "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = nil
								end

								callback(nil)
							end
						else
							if table.find(chosen, v) then
								for i, v2 in next, chosen do
									if v2 == v then
										table.remove(chosen, i)
									end
								end

								utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = chosen
								end

								callback(chosen)
							else
								table.insert(chosen, v)

								utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = chosen
								end

								callback(chosen)
							end
						end
					end)
				end

				local dropdownTypes = {}
				dropdownTypes = utility.format_table(dropdownTypes)

				function dropdownTypes:Set(opt)
					if opt ~= nil then
						if not multiChoice then
							local optionExists = false

							for i, v in next, contentTable do
								if v == opt then
									optionExists = true
								end
							end

							local option = optionInstances[opt]

							if optionExists then
								curValue = opt

								for i2, v2 in next, contentHolder:GetChildren() do
									if v2:IsA("TextButton") then
										v2.TextColor3 = theme.DisabledText
									end
								end

								utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.EnabledText
									value.Text = opt
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = opt
								end

								callback(opt)
							end
						else
							if typeof(opt) == "table" then
								chosen = opt

								for i,v in next, chosen do
									utility.tween(optionInstances[v], {0.2}, {TextColor3 = theme.EnabledText})
								end
							else 
								if not table.find(chosen, opt) then
									table.insert(chosen, opt)

									utility.tween(optionInstances[opt], {0.2}, {TextColor3 = theme.EnabledText})
								end
							end

							utility.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = theme.EnabledText
								value.Text = table.concat(chosen, ", ")
								utility.tween(value, {0.2}, {TextTransparency = 0})
							end)

							if flag then
								library.flags[flag] = chosen
							end

							callback(chosen)
						end
					else
						if not multiChoice then
							curValue = nil
							for i2, v2 in next, contentHolder:GetChildren() do
								if v2:IsA("TextButton") then
									utility.tween(v2, {0.2}, {TextColor3 = theme.DisabledText})
								end
							end

							utility.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = theme.DisabledText
								value.Text = "NONE"
								utility.tween(value, {0.2}, {TextTransparency = 0})
							end)

							if flag then
								library.flags[flag] = nil
							end

							callback(nil)
						else
							chosen = {}

							for i2, v2 in next, contentHolder:GetChildren() do
								if v2:IsA("TextButton") then
									v2.TextColor3 = theme.DisabledText
								end
							end

							utility.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = theme.DisabledText
								value.Text = "NONE"
								utility.tween(value, {0.2}, {TextTransparency = 0})
							end)

							if flag then
								library.flags[flag] = chosen
							end

							callback(chosen)
						end
					end
				end

				function dropdownTypes:Add(opt)
					table.insert(contentTable, opt)

					local option = utility.create("TextButton", {
						ZIndex = 11,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontSize = Enum.FontSize.Size12,
						TextSize = 12,
						TextColor3 = theme.DisabledText,
						Text = opt,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						Parent = contentHolder
					})

					optionInstances[opt] = option

					option.MouseButton1Click:connect(function()
						if not multiChoice then
							if curValue ~= opt then
								curValue = opt

								for i, v in next, contentHolder:GetChildren() do
									if v:IsA("TextButton") then
										utility.tween(v, {0.2}, {TextColor3 = theme.DisabledText})
									end
								end

								utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.EnabledText
									value.Text = opt
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = opt
								end
								callback(opt)
							else
								curValue = nil
								utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.DisabledText
									value.Text = "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = nil
								end

								callback(nil)
							end
						else
							if table.find(chosen, opt) then
								for i, v in next, chosen do
									if v == opt then
										table.remove(chosen, i)
									end
								end

								utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = chosen
								end

								callback(chosen)
							else
								table.insert(chosen, opt)

								utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = chosen
								end

								callback(chosen)
							end
						end
					end)

					if content.Visible then
						local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
						utility.tween(content, {#contentTable * 0.1}, {Size = sizeX})
					end
				end

				function dropdownTypes:Remove(opt)
					if table.find(contentTable, opt) then
						utility.tween(optionInstances[opt], {0.2}, {TextTransparency = 1}, function()
							table.remove(contentTable, table.find(contentTable, opt))
							optionInstances[opt]:Destroy()
							table.remove(optionInstances, table.find(optionInstances, opt))
						end)

						table.remove(contentTable, table.find(contentTable, opt))

						if content.Visible then
							local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y - 16)
							utility.tween(content, {#contentTable * 0.1}, {Size = sizeX})
						end

						if not multiChoice then
							if curValue == opt then
								curValue = nil
								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = theme.DisabledText
									value.Text = "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)

								if flag then
									library.flags[flag] = nil
								end

								callback(nil)
							end
						else
							if table.find(chosen, opt) then
								table.remove(chosen, table.find(chosen, opt))

								utility.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									utility.tween(value, {0.2}, {TextTransparency = 0})
								end)
							end
						end
					end
				end

				function dropdownTypes:Refresh(tbl)
					contentTable = tbl

					for i, v in next, optionInstances do
						v:Destroy()
					end

					utility.tween(value, {0.2}, {TextTransparency = 1}, function()
						value.TextColor3 = theme.DisabledText
						value.Text = "NONE"
						utility.tween(value, {0.2}, {TextTransparency = 0})
					end)

					for i, v in next, contentTable do
						local option = utility.create("TextButton", {
							ZIndex = 11,
							Size = UDim2.new(1, 0, 0, 16),
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							FontSize = Enum.FontSize.Size12,
							TextSize = 12,
							TextColor3 = v == default and theme.EnabledText or theme.DisabledText,
							Text = v,
							Font = Enum.Font.Gotham,
							TextXAlignment = Enum.TextXAlignment.Left,
							Parent = contentHolder
						})

						optionInstances[v] = option

						if v == default then
							if not multiChoice then
								if flag then
									library.flags[flag] = v
								end

								callback(v)
							else
								table.insert(chosen, v)

								if flag then
									library.flags[flag] = chosen
								end

								callback(chosen)
							end
						end

						option.MouseButton1Click:connect(function()
							if not multiChoice then
								if curValue ~= v then
									curValue = v

									for i2, v2 in next, contentHolder:GetChildren() do
										if v2:IsA("TextButton") then
											utility.tween(v2, {0.2}, {TextColor3 = theme.DisabledText})
										end
									end

									utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

									utility.tween(value, {0.2}, {TextTransparency = 1}, function()
										value.TextColor3 = theme.EnabledText
										value.Text = v
										utility.tween(value, {0.2}, {TextTransparency = 0})
									end)

									if flag then
										library.flags[flag] = v
									end
									callback(v)
								else
									curValue = nil
									utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

									utility.tween(value, {0.2}, {TextTransparency = 1}, function()
										value.TextColor3 = theme.DisabledText
										value.Text = "NONE"
										utility.tween(value, {0.2}, {TextTransparency = 0})
									end)

									if flag then
										library.flags[flag] = nil
									end

									callback(nil)
								end
							else
								if table.find(chosen, v) then
									for i, v2 in next, chosen do
										if v2 == v then
											table.remove(chosen, i)
										end
									end

									utility.tween(option, {0.2}, {TextColor3 = theme.DisabledText})

									utility.tween(value, {0.2}, {TextTransparency = 1}, function()
										value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
										value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
										utility.tween(value, {0.2}, {TextTransparency = 0})
									end)

									if flag then
										library.flags[flag] = chosen
									end

									callback(chosen)
								else
									table.insert(chosen, v)

									utility.tween(option, {0.2}, {TextColor3 = theme.EnabledText})

									utility.tween(value, {0.2}, {TextTransparency = 1}, function()
										value.TextColor3 = table.concat(chosen) ~= "" and theme.EnabledText or theme.DisabledText
										value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
										utility.tween(value, {0.2}, {TextTransparency = 0})
									end)

									if flag then
										library.flags[flag] = chosen
									end

									callback(chosen)
								end
							end
						end)
					end

					if content.Visible then
						local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
						utility.tween(content, {#contentTable * 0.1}, {Size = sizeX})
					end
				end

				function dropdownTypes:Hide()
					dropdown.Visible = false
				end

				function dropdownTypes:Show()
					dropdown.Visible = true
				end

				function dropdownTypes:Destroy()
					dropdown:Destroy()
				end

				return dropdownTypes
			end

			function sectionTypes:MakeKeybind(opts)
				local options = utility.format_table(opts)
				local name = options.Text
				local default = options.Default
				local flag = options.Flag or nil
				local callback = options.callback or function() end

				local keyChosen = default

				if flag then
					library.flags[flag] = default
				end

				local keys = {
					[Enum.KeyCode.LeftShift] = "L-SHIFT";
					[Enum.KeyCode.RightShift] = "R-SHIFT";
					[Enum.KeyCode.LeftControl] = "L-CTRL";
					[Enum.KeyCode.RightControl] = "R-CTRL";
					[Enum.KeyCode.LeftAlt] = "L-ALT";
					[Enum.KeyCode.RightAlt] = "R-ALT";
					[Enum.KeyCode.CapsLock] = "CAPSLOCK";
					[Enum.KeyCode.One] = "1";
					[Enum.KeyCode.Two] = "2";
					[Enum.KeyCode.Three] = "3";
					[Enum.KeyCode.Four] = "4";
					[Enum.KeyCode.Five] = "5";
					[Enum.KeyCode.Six] = "6";
					[Enum.KeyCode.Seven] = "7";
					[Enum.KeyCode.Eight] = "8";
					[Enum.KeyCode.Nine] = "9";
					[Enum.KeyCode.Zero] = "0";
					[Enum.KeyCode.KeypadOne] = "NUM-1";
					[Enum.KeyCode.KeypadTwo] = "NUM-2";
					[Enum.KeyCode.KeypadThree] = "NUM-3";
					[Enum.KeyCode.KeypadFour] = "NUM-4";
					[Enum.KeyCode.KeypadFive] = "NUM-5";
					[Enum.KeyCode.KeypadSix] = "NUM-6";
					[Enum.KeyCode.KeypadSeven] = "NUM-7";
					[Enum.KeyCode.KeypadEight] = "NUM-8";
					[Enum.KeyCode.KeypadNine] = "NUM-9";
					[Enum.KeyCode.KeypadZero] = "NUM-0";
					[Enum.KeyCode.Minus] = "-";
					[Enum.KeyCode.Equals] = "=";
					[Enum.KeyCode.Tilde] = "~";
					[Enum.KeyCode.LeftBracket] = "[";
					[Enum.KeyCode.RightBracket] = "]";
					[Enum.KeyCode.RightParenthesis] = ")";
					[Enum.KeyCode.LeftParenthesis] = "(";
					[Enum.KeyCode.Semicolon] = ";";
					[Enum.KeyCode.Quote] = "'";
					[Enum.KeyCode.BackSlash] = "\\";
					[Enum.KeyCode.Comma] = ";";
					[Enum.KeyCode.Period] = ".";
					[Enum.KeyCode.Slash] = "/";
					[Enum.KeyCode.Asterisk] = "*";
					[Enum.KeyCode.Plus] = "+";
					[Enum.KeyCode.Period] = ".";
					[Enum.KeyCode.Backquote] = "`";
					[Enum.UserInputType.MouseButton1] = "MOUSE-1";
					[Enum.UserInputType.MouseButton2] = "MOUSE-2";
					[Enum.UserInputType.MouseButton3] = "MOUSE-3"
				}

				local keybind = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = "Keybind",
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sectionContent
				})

				local value = utility.create("TextLabel", {
					ZIndex = 6,
					Size = UDim2.new(0, 1, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -1, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = default and theme.EnabledText or theme.DisabledText,
					Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Right,
					Parent = keybind
				})

				keybind.MouseButton1Click:Connect(function()
					value.Text = "..."
					utility.tween(value, {0.2}, {TextColor3 = theme.DisabledText})

					local binding
					binding = UserInputService.InputBegan:Connect(function(input)
						local key = keys[input.KeyCode] or keys[input.UserInputType]
						value.Text = (keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
						utility.tween(value, {0.2}, {TextColor3 = theme.EnabledText})

						if input.UserInputType == Enum.UserInputType.Keyboard then
							keyChosen = input.KeyCode

							if flag then
								library.flags[flag] = input.KeyCode
							end

							task.spawn(callback, input.KeyCode)

							binding:Disconnect()
						else
							keyChosen = input.UserInputType

							if flag then
								library.flags[flag] = input.UserInputType
							end

							task.spawn(callback, input.UserInputType)

							binding:Disconnect()
						end
					end)
				end)

				UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keyChosen then
							callback(keyChosen)
						end
					else
						if input.UserInputType == keyChosen then
							callback(keyChosen)
						end
					end
				end)

				local keybindTypes = {}
				keybindTypes = utility.format_table(keybindTypes)

				function keybindTypes:Set(newKey)
					local key = keys[newKey]
					value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
					utility.tween(value, {0.2}, {TextColor3 = theme.EnabledText})

					keyChosen = newKey

					if flag then
						library.flags[flag] = newKey
					end

					callback(newKey)
				end

				function keybindTypes:Get()
					return keyChosen
				end

				function keybindTypes:Hide()
					keybind.Visible = false
				end

				function keybindTypes:Show()
					keybind.Visible = true
				end

				function keybindTypes:Destroy()
					keybind:Destroy()
				end

				return keybindTypes
			end

			function sectionTypes:MakeToggleKeybind(opts)
				local options = utility.format_table(opts)
				local name = options.name
				local default = options.default
				local keybindFlag = options.keybindFlag or nil
				local toggleFlag = options.toggleFlag or nil
				local keybindCallback = options.keybindCallback or function() end
				local toggleCallback = options.toggleCallback or function() end

				local keyChosen = default
				local mouseOver = false
				local toggled = false

				if keybindFlag then
					library.flags[keybindFlag] = default
				end

				local keys = {
					[Enum.KeyCode.LeftShift] = "L-SHIFT";
					[Enum.KeyCode.RightShift] = "R-SHIFT";
					[Enum.KeyCode.LeftControl] = "L-CTRL";
					[Enum.KeyCode.RightControl] = "R-CTRL";
					[Enum.KeyCode.LeftAlt] = "L-ALT";
					[Enum.KeyCode.RightAlt] = "R-ALT";
					[Enum.KeyCode.CapsLock] = "CAPSLOCK";
					[Enum.KeyCode.One] = "1";
					[Enum.KeyCode.Two] = "2";
					[Enum.KeyCode.Three] = "3";
					[Enum.KeyCode.Four] = "4";
					[Enum.KeyCode.Five] = "5";
					[Enum.KeyCode.Six] = "6";
					[Enum.KeyCode.Seven] = "7";
					[Enum.KeyCode.Eight] = "8";
					[Enum.KeyCode.Nine] = "9";
					[Enum.KeyCode.Zero] = "0";
					[Enum.KeyCode.KeypadOne] = "NUM-1";
					[Enum.KeyCode.KeypadTwo] = "NUM-2";
					[Enum.KeyCode.KeypadThree] = "NUM-3";
					[Enum.KeyCode.KeypadFour] = "NUM-4";
					[Enum.KeyCode.KeypadFive] = "NUM-5";
					[Enum.KeyCode.KeypadSix] = "NUM-6";
					[Enum.KeyCode.KeypadSeven] = "NUM-7";
					[Enum.KeyCode.KeypadEight] = "NUM-8";
					[Enum.KeyCode.KeypadNine] = "NUM-9";
					[Enum.KeyCode.KeypadZero] = "NUM-0";
					[Enum.KeyCode.Minus] = "-";
					[Enum.KeyCode.Equals] = "=";
					[Enum.KeyCode.Tilde] = "~";
					[Enum.KeyCode.LeftBracket] = "[";
					[Enum.KeyCode.RightBracket] = "]";
					[Enum.KeyCode.RightParenthesis] = ")";
					[Enum.KeyCode.LeftParenthesis] = "(";
					[Enum.KeyCode.Semicolon] = ";";
					[Enum.KeyCode.Quote] = "'";
					[Enum.KeyCode.BackSlash] = "\\";
					[Enum.KeyCode.Comma] = ";";
					[Enum.KeyCode.Period] = ".";
					[Enum.KeyCode.Slash] = "/";
					[Enum.KeyCode.Asterisk] = "*";
					[Enum.KeyCode.Plus] = "+";
					[Enum.KeyCode.Period] = ".";
					[Enum.KeyCode.Backquote] = "`";
					[Enum.UserInputType.MouseButton1] = "MOUSE-1";
					[Enum.UserInputType.MouseButton2] = "MOUSE-2";
					[Enum.UserInputType.MouseButton3] = "MOUSE-3"
				}

				local toggleKeybind = utility.create("TextButton", {
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					Parent = sectionContent
				})

				local icon = utility.create("Frame", {
					ZIndex = 6,
					Size = UDim2.new(0, 10, 0, 10),
					BackgroundColor3 = theme.ToggleDisabled,
					Parent = toggleKeybind
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 12),
					Parent = icon
				})

				local title = utility.create("TextLabel", {
					ZIndex = 6,
					Size = UDim2.new(0, 1, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 5, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.DisabledText,
					Text = name,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = icon
				})

				local value = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(0, 1, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -1, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = default and theme.EnabledText or theme.DisabledText,
					Text = default and (keys[default] or tostring(default):gsub("Enum.KeyCode.", "")) or "NONE",
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Right,
					Parent = toggleKeybind
				})

				value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
				value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)

				local function toggleToggle()
					toggled = not toggled

					utility.tween(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

					if not mouseOver then
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
					else
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
					end

					toggleCallback(toggled)
					if toggleFlag then
						library.flags[toggleFlag] = toggled
					end
				end

				toggleKeybind.MouseButton1Click:connect(toggleToggle)

				toggleKeybind.MouseEnter:Connect(function()
					mouseOver = true
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
				end)

				toggleKeybind.MouseLeave:Connect(function()
					mouseOver = false
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
				end)

				value.MouseButton1Click:Connect(function()
					value.Text = "..."
					utility.tween(value, {0.2}, {TextColor3 = theme.DisabledText})

					local binding
					binding = UserInputService.InputBegan:Connect(function(input)
						local key = keys[input.KeyCode] or keys[input.UserInputType]
						value.Text = key or (tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
						value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
						value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)
						utility.tween(value, {0.2}, {TextColor3 = theme.EnabledText})

						if input.UserInputType == Enum.UserInputType.Keyboard then
							keyChosen = input.KeyCode

							if keybindFlag then
								library.flags[keybindFlag] = input.KeyCode
							end

							keybindCallback(input.KeyCode)
							binding:Disconnect()
						else
							keyChosen = input.UserInputType

							if keybindFlag then
								library.flags[keybindFlag] = input.UserInputType
							end

							keybindCallback(input.UserInputType)
							binding:Disconnect()
						end
					end)
				end)

				UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == keyChosen then
							toggleToggle()
							keybindCallback(keyChosen)
						end
					else
						if input.UserInputType == keyChosen then
							toggleToggle()
							keybindCallback(keyChosen)
						end
					end
				end)

				local toggleKeybindTypes = {}
				toggleKeybindTypes = utility.format_table(toggleKeybindTypes)

				function toggleKeybindTypes:Toggle(bool)
					if toggled ~= bool then
						toggleToggle()
					end
				end

				function toggleKeybindTypes:Click()
					toggled = not toggled

					toggleToggle()
				end

				function toggleKeybindTypes:Set(newKey)
					local key = keys[newKey]
					value.Text = (keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
					utility.tween(value, {0.2}, {TextColor3 = theme.EnabledText})

					keyChosen = newKey

					if keybindFlag then
						library.flags[keybindFlag] = newKey
					end

					keybindCallback(newKey)
				end

				function toggleKeybindTypes:Hide()
					toggleKeybind.Visible = false
				end

				function toggleKeybindTypes:Show()
					toggleKeybind.Visible = true
				end

				function toggleKeybindTypes:Destroy(args)
					toggleKeybind:Destroy()
				end

				return toggleKeybindTypes
			end

			function sectionTypes:MakeColorPicker(opts)
				local options = utility.format_table(opts)
				local name = options.Text
				local default = options.Default
				local flag = options.flag or nil
				local callback = options.callback or function() end

				local open = false
				local hue, sat, val = default:ToHSV()

				local slidingHue
				local slidingSaturation

				local hsv = Color3.fromHSV(hue, sat, val)

				if flag then
					library.flags[flag] = default
				end

				local colorPicker = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = name,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = sectionContent
				})

				local icon = utility.create("Frame", {
					ZIndex = 6,
					Size = UDim2.new(0, 10, 0, 10),
					Position = UDim2.new(1, -10, 0, 0),
					BackgroundColor3 = default,
					Parent = colorPicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 12),
					Parent = icon
				})

				local picker = utility.create("Frame", {
					ZIndex = 12,
					Size = UDim2.new(1, -8, 0, 0),
					ClipsDescendants = true,
					Visible = false,
					Position = UDim2.new(0, 12, 1, 6),
					BackgroundColor3 = theme.ColorPicker,
					Parent = colorPicker
				})

				picker.Size = UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24)

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = picker
				})

				local saturation = utility.create("ImageLabel", {
					ZIndex = 13,
					Size = UDim2.new(1, -29, 0, picker.AbsoluteSize.X - 29),
					Position = UDim2.new(0, 5, 0, 5),
					BackgroundColor3 = Color3.fromHSV(hue, sat, val),
					Image = "http://www.roblox.com/asset/?id=8630797271",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = saturation
				})

				local saturationPicker = utility.create("Frame", {
					ZIndex = 15,
					Size = UDim2.new(0, 4, 0, 4),
					Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = saturation
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = saturationPicker
				})

				local outline = utility.create("Frame", {
					ZIndex = 14,
					Size = UDim2.new(1, 2, 1, 2),
					Position = UDim2.new(0, -1, 0, -1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = saturationPicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = outline
				})

				local hueFrame = utility.create("ImageLabel", {
					ZIndex = 13,
					Size = UDim2.new(0, 14, 0, picker.AbsoluteSize.X - 29),
					ClipsDescendants = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -19, 0, 5),
					BackgroundColor3 = Color3.fromRGB(255, 0, 4),
					ScaleType = Enum.ScaleType.Crop,
					Image = "http://www.roblox.com/asset/?id=8630799159",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = hueFrame
				})

				local huePicker = utility.create("Frame", {
					ZIndex = 15,
					Size = UDim2.new(1, 0, 0, 2),
					Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4)),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = hueFrame
				})

				local outline = utility.create("Frame", {
					ZIndex = 14,
					Size = UDim2.new(1, 2, 1, 2),
					Position = UDim2.new(0, -1, 0, -1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = huePicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = outline
				})

				local rgb = utility.create("TextBox", {
					ZIndex = 14,
					Size = UDim2.new(1, -10, 0, 16),
					Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 42),
					BackgroundColor3 = theme.ColorPickerBoxes,
					PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = tostring(math.floor(default.R * 255)) .. ", " .. tostring(math.floor(default.G * 255)) .. ", " .. tostring(math.floor(default.B * 255)),
					ClearTextOnFocus = false,
					Font = Enum.Font.Gotham,
					PlaceholderText = "R,  G,  B",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = rgb
				})

				local hex = utility.create("TextBox", {
					ZIndex = 14,
					Size = UDim2.new(1, -10, 0, 16),
					Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 21),
					BackgroundColor3 = theme.ColorPickerBoxes,
					PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = utility.rgb_to_hex(default),
					ClearTextOnFocus = false,
					Font = Enum.Font.Gotham,
					PlaceholderText = "#FFFFFF",
					Parent = picker
				})

				picker.Size = UDim2.new(1, -8, 0, 0)

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = hex
				})

				local function openPicker()
					open = not open

					if open then
						picker.Visible = open
					end

					utility.tween(picker, {0.5}, {Size = open and UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24) or UDim2.new(1, -8, 0, 0)}, function() picker.Visible = open end)
				end

				colorPicker.MouseButton1Click:connect(openPicker)

				local function updateHue(input)
					local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
					utility.tween(huePicker, {0.1}, {Position = UDim2.new(0, 0, 0, posY)})

					hue = sizeY

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					hsv = Color3.fromHSV(hue, sat, val)
					saturation.BackgroundColor3 = hsv
					icon.BackgroundColor3 = hsv

					if flag then 
						library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					end

					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				hueFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = true
						updateHue(input)
					end
				end)

				hueFrame.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingHue then
							updateHue(input)
						end
					end
				end)

				local function updateSatVal(input)
					local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
					local sizeY = 1 - math.clamp((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)
					local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)

					utility.tween(saturationPicker, {0.1}, {Position = UDim2.new(0, posX, 0, posY)})

					sat = sizeX
					val = sizeY

					hsv = Color3.fromHSV(hue, sat, val)

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					saturation.BackgroundColor3 = hsv
					icon.BackgroundColor3 = hsv

					if flag then 
						library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					end

					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				saturation.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = true
						updateSatVal(input)
					end
				end)

				saturation.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingSaturation then
							updateSatVal(input)
						end
					end
				end)

				local colorPickerTypes = {}
				colorPickerTypes = utility.format_table(colorPickerTypes)

				function colorPickerTypes:SetRGB(color)
					hue, sat, val = color:ToHSV()
					hsv = Color3.fromHSV(hue, sat, val)

					saturation.BackgroundColor3 = hsv
					icon.BackgroundColor3 = hsv
					saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
					huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					if flag then 
						library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					end

					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				function colorPickerTypes:SetHex(hex)
					local color = utility.hex_to_rgb(hex)

					hue, sat, val = color:ToHSV()
					hsv = Color3.fromHSV(hue, sat, val)

					saturation.BackgroundColor3 = hsv
					icon.BackgroundColor3 = hsv
					saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
					huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

					if flag then 
						library.flags[flag] = Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255)
					end

					callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				rgb.FocusLost:Connect(function()
					local _, amount = rgb.Text:gsub(", ", "")
					if amount == 2 then
						local values = rgb.Text:split(", ")
						local r, g, b = math.clamp(values[1], 0, 255), math.clamp(values[2], 0, 255), math.clamp(values[3], 0, 255)
						colorPickerTypes:SetRGB(Color3.fromRGB(r, g, b))
					else
						rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					end
				end)

				hex.FocusLost:Connect(function()
					if hex.Text:find("#") and hex.Text:len() == 7 then
						colorPickerTypes:SetHex(hex.Text)
					else
						hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
					end
				end)

				hex:GetPropertyChangedSignal("Text"):Connect(function()
					if hex.Text == "" then
						hex.Text = "#"
					end
				end)

				function colorPickerTypes:Hide()
					colorPicker.Visible = false
				end

				function colorPickerTypes:Show()
					colorPicker.Visible = true
				end

				function colorPickerTypes:Destroy()
					colorPicker:Destroy()
				end

				return colorPickerTypes
			end

			function sectionTypes:MakeToggleColorPicker(opts)
				local options = utility.format_table(opts)
				local name = options.Text
				local default = options.Default
				local colorPickerFlag = options.colorPickerFlag or nil
				local toggleFlag = options.toggleFlag or nil
				local colorPickerCallback = options.colorPickerCallback or function() end
				local toggleCallback = options.toggleCallback or function() end

				local open = false
				local hue, sat, val = default:ToHSV()

				local slidingHue
				local slidingSaturation

				local hsv = Color3.fromHSV(hue, sat, val)

				if colorPickerFlag then
					library.flags[colorPickerFlag] = default
				end

				local toggled = false
				local mouseOver = false

				local toggleColorPicker = utility.create("TextButton", {
					Size = UDim2.new(1, 0, 0, 10),
					BackgroundTransparency = 1,
					FontSize = Enum.FontSize.Size14,
					TextSize = 14,
					Text = "",
					Font = Enum.Font.SourceSans,
					Parent = sectionContent
				})

				local icon = utility.create("Frame", {
					ZIndex = 6,
					Size = UDim2.new(0, 10, 0, 10),
					BackgroundColor3 = theme.ToggleDisabled,
					Parent = toggleColorPicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 12),
					Parent = icon
				})

				local title = utility.create("TextLabel", {
					ZIndex = 6,
					Size = UDim2.new(0, 1, 0, 10),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 5, 0, 0),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.DisabledText,
					Text = name,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = icon
				})

				local function toggleToggle()
					toggled = not toggled

					utility.tween(title, {0.2}, {TextColor3 = toggled and theme.EnabledText or theme.DisabledText})

					if not mouseOver then
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
					else
						utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
					end

					toggleCallback(toggled)
					if toggleFlag then
						library.flags[toggleFlag] = toggled
					end
				end

				toggleColorPicker.MouseButton1Click:connect(toggleToggle)

				toggleColorPicker.MouseEnter:Connect(function()
					mouseOver = true
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabledMouseOver or theme.ToggleDisabledMouseOver})
				end)

				toggleColorPicker.MouseLeave:Connect(function()
					mouseOver = false
					utility.tween(icon, {0.2}, {BackgroundColor3 = toggled and theme.ToggleEnabled or theme.ToggleDisabled})
				end)

				local colorPickerIcon = utility.create("TextButton", {
					ZIndex = 6,
					Size = UDim2.new(0, 10, 0, 10),
					Position = UDim2.new(1, -10, 0, 0),
					BackgroundColor3 = default,
					Text = "",
					Parent = toggleColorPicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 12),
					Parent = colorPickerIcon
				})

				local picker = utility.create("Frame", {
					ZIndex = 12,
					Size = UDim2.new(1, -8, 0, 0),
					ClipsDescendants = true,
					Visible = false,
					Position = UDim2.new(0, 12, 1, 6),
					BackgroundColor3 = theme.ColorPicker,
					Parent = toggleColorPicker
				})

				picker.Size = UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24)

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = picker
				})

				local saturation = utility.create("ImageLabel", {
					ZIndex = 13,
					Size = UDim2.new(1, -29, 0, picker.AbsoluteSize.X - 29),
					Position = UDim2.new(0, 5, 0, 5),
					BackgroundColor3 = Color3.fromHSV(hue, sat, val),
					Image = "http://www.roblox.com/asset/?id=8630797271",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = saturation
				})

				local saturationPicker = utility.create("Frame", {
					ZIndex = 15,
					Size = UDim2.new(0, 4, 0, 4),
					Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = saturation
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = saturationPicker
				})

				local outline = utility.create("Frame", {
					ZIndex = 14,
					Size = UDim2.new(1, 2, 1, 2),
					Position = UDim2.new(0, -1, 0, -1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = saturationPicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = outline
				})

				local hueFrame = utility.create("ImageLabel", {
					ZIndex = 13,
					Size = UDim2.new(0, 14, 0, picker.AbsoluteSize.X - 29),
					ClipsDescendants = true,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -19, 0, 5),
					BackgroundColor3 = Color3.fromRGB(255, 0, 4),
					ScaleType = Enum.ScaleType.Crop,
					Image = "http://www.roblox.com/asset/?id=8630799159",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 4),
					Parent = hueFrame
				})

				local huePicker = utility.create("Frame", {
					ZIndex = 15,
					Size = UDim2.new(1, 0, 0, 2),
					Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4)),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = hueFrame
				})

				local outline = utility.create("Frame", {
					ZIndex = 14,
					Size = UDim2.new(1, 2, 1, 2),
					Position = UDim2.new(0, -1, 0, -1),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = huePicker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = outline
				})

				local rgb = utility.create("TextBox", {
					ZIndex = 14,
					Size = UDim2.new(1, -10, 0, 16),
					Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 42),
					BackgroundColor3 = theme.ColorPickerBoxes,
					PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = tostring(math.floor(default.R * 255)) .. ", " .. tostring(math.floor(default.G * 255)) .. ", " .. tostring(math.floor(default.B * 255)),
					ClearTextOnFocus = false,
					Font = Enum.Font.Gotham,
					PlaceholderText = "R,  G,  B",
					Parent = picker
				})

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = rgb
				})

				local hex = utility.create("TextBox", {
					ZIndex = 14,
					Size = UDim2.new(1, -10, 0, 16),
					Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 21),
					BackgroundColor3 = theme.ColorPickerBoxes,
					PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = theme.TextColor,
					Text = utility.rgb_to_hex(default),
					ClearTextOnFocus = false,
					Font = Enum.Font.Gotham,
					PlaceholderText = "#FFFFFF",
					Parent = picker
				})

				picker.Size = UDim2.new(1, -8, 0, 0)

				utility.create("UICorner", {
					CornerRadius = UDim.new(0, 6),
					Parent = hex
				})

				local function openPicker()
					open = not open

					if open then
						picker.Visible = open
					end

					utility.tween(picker, {0.5}, {Size = open and UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24) or UDim2.new(1, -8, 0, 0)}, function() picker.Visible = open end)
				end

				colorPickerIcon.MouseButton1Click:connect(openPicker)

				local function updateHue(input)
					local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
					utility.tween(huePicker, {0.1}, {Position = UDim2.new(0, 0, 0, posY)})

					hue = sizeY

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					hsv = Color3.fromHSV(hue, sat, val)
					saturation.BackgroundColor3 = hsv
					colorPickerIcon.BackgroundColor3 = hsv

					colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				hueFrame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = true
						updateHue(input)
					end
				end)

				hueFrame.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingHue = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingHue then
							updateHue(input)
						end
					end
				end)

				local function updateSatVal(input)
					local sizeX = math.clamp((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X, 0, 1)
					local sizeY = 1 - math.clamp((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y, 0, 1)
					local posY = math.clamp(((input.Position.Y - saturation.AbsolutePosition.Y) / saturation.AbsoluteSize.Y) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)
					local posX = math.clamp(((input.Position.X - saturation.AbsolutePosition.X) / saturation.AbsoluteSize.X) * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)

					utility.tween(saturationPicker, {0.1}, {Position = UDim2.new(0, posX, 0, posY)})

					sat = sizeX
					val = sizeY

					hsv = Color3.fromHSV(hue, sat, val)

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					saturation.BackgroundColor3 = hsv
					colorPickerIcon.BackgroundColor3 = hsv

					colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				saturation.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = true
						updateSatVal(input)
					end
				end)

				saturation.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						slidingSaturation = false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement then
						if slidingSaturation then
							updateSatVal(input)
						end
					end
				end)

				local toggleColorPickerTypes = {}
				toggleColorPickerTypes = utility.format_table(toggleColorPickerTypes)

				function toggleColorPickerTypes:Toggle(bool)
					if toggled ~= bool then
						toggleColorPickerTypes()
					end
				end

				function toggleColorPickerTypes:SetRGB(color)
					hue, sat, val = color:ToHSV()
					hsv = Color3.fromHSV(hue, sat, val)

					saturation.BackgroundColor3 = hsv
					colorPickerIcon.BackgroundColor3 = hsv
					saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
					huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

					rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

					colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				function toggleColorPickerTypes:SetHex(hex)
					local color = utility.hex_to_rgb(hex)

					hue, sat, val = color:ToHSV()
					hsv = Color3.fromHSV(hue, sat, val)

					saturation.BackgroundColor3 = hsv
					colorPickerIcon.BackgroundColor3 = hsv
					saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
					huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

					colorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
				end

				rgb.FocusLost:Connect(function()
					local _, amount = rgb.Text:gsub(", ", "")
					if amount == 2 then
						local values = rgb.Text:split(", ")
						local r, g, b = math.clamp(values[1], 0, 255), math.clamp(values[2], 0, 255), math.clamp(values[3], 0, 255)
						toggleColorPickerTypes:SetRGB(Color3.fromRGB(r, g, b))
					else
						rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
					end
				end)

				hex.FocusLost:Connect(function()
					if hex.Text:find("#") and hex.Text:len() == 7 then
						toggleColorPickerTypes:SetHex(hex.Text)
					else
						hex.Text = utility.rgb_to_hex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
					end
				end)

				hex:GetPropertyChangedSignal("Text"):Connect(function()
					if hex.Text == "" then
						hex.Text = "#"
					end
				end)

				function toggleColorPickerTypes:Hide()
					toggleColorPicker.Visible = false
				end

				function toggleColorPickerTypes:Show()
					toggleColorPicker.Visible = true
				end

				function toggleColorPickerTypes:Destroy(args)
					toggleColorPicker:Destroy()
				end

				return toggleColorPickerTypes
			end

			return sectionTypes
		end

		return tabTypes
	end

	return windowTypes
end

return library

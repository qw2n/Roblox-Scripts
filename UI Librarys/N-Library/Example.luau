-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discrod Server: https://discord.gg/pY6nDej76m

-- Example: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Example.luau
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

local NLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

--[[

Themes:
	+ Dark
	+ Light
	+ PurpleAndBlack
	+ Cosmic
	+ Sunset
	+ Wave
	+ Metalic

]]

--[[

.new()
    :Hide()
    :Show()
    :Destroy()
    
]]
local wind = NLib.new({
	Name = "Name Hub",

	SizeX = 330,
	SizeY = 360,
	
	Theme = "Dark",
	
	--// You can remove it if u dont need for it
	OpenGuiKeyCode = Enum.KeyCode.Z
	
	--// Example with CustomTheme property
	--CustomTheme = {
	--	Box = Color3.fromRGB(35, 30, 60),
	--	BoxFocused = Color3.fromRGB(45, 40, 80),

	--	ColorPicker = Color3.fromRGB(30, 25, 50),
	--	ColorPickerBoxes = Color3.fromRGB(25, 20, 45),

	--	Button = Color3.fromRGB(100, 80, 200),
	--	ButtonMouseOver = Color3.fromRGB(120, 100, 220),

	--	Section = Color3.fromRGB(10, 5, 30),
	--	MainFrame = Color3.fromRGB(20, 15, 40),

	--	TextColor = Color3.fromRGB(230, 230, 255),
	--	EnabledText = Color3.fromRGB(240, 240, 255),
	--	DisabledText = Color3.fromRGB(140, 140, 180),

	--	Dropdown = Color3.fromRGB(35, 30, 60),
	--	DropdownContent = Color3.fromRGB(20, 15, 45),
	--	DropdownMouseOver = Color3.fromRGB(45, 40, 80),

	--	ToggleEnabled = Color3.fromRGB(80, 180, 220),
	--	ToggleDisabled = Color3.fromRGB(220, 80, 150),
	--	ToggleEnabledMouseOver = Color3.fromRGB(100, 200, 240),
	--	ToggleDisabledMouseOver = Color3.fromRGB(240, 100, 170),

	--	Slider = Color3.fromRGB(40, 35, 70),
	--	SliderFill = Color3.fromRGB(160, 140, 255),
	--	SliderMouseOver = Color3.fromRGB(50, 45, 90),
	--	SliderFillSliding = Color3.fromRGB(180, 160, 255),

	--	Tab = Color3.fromRGB(25, 20, 45),
	--	TabBackground = Color3.fromRGB(15, 10, 35),
	--	TabToggleDisabled = Color3.fromRGB(30, 25, 55),
	--	TabToggleEnabled = Color3.fromRGB(120, 100, 220),
	--	TabToggleDisabledMouseOver = Color3.fromRGB(40, 35, 75),
	--}
})

--[[

:MakeTab()
    :Open()
    :Show()
    :Hide()
    :Destroy()

]]
local tab = wind:MakeTab({
	Text = "Tab 1"
})

local _tab = wind:MakeTab({
	Text = "Tab 2"
})

--[[

:MakeSection()
    :Show()
    :Hide()
    :Destroy()

]]
local section = tab:MakeSection({
	Text = "Section 1",

	Column = 1 -- 1 - Left, 2 - Right
})

--[[

:MakeLabel()
    :Show()
    :Hide()
    :Destroy()
    :GetText(): string
    :SetText(Text: string)

]]
section:MakeLabel({
	Text = "Name Label"
})

--[[

:MakeButton()
    :Hide()
    :Show()
    :Fire()
    :Destroy()

]]
section:MakeButton({
	Text = "Button",

	Callback = function()
		print("123")
	end
})

--[[

:MakeToggle()
    :Hide()
    :Show()
    :Click()
    :Destroy()
    :Toggle(bool: boolean)

]]
section:MakeToggle({
	Text = "Toggle",

	Flag = false,

	Callback = function(v: boolean)
		print(v)
	end
})

--[[

:MakeTextBox()
    :Show()
    :Hide()
    :Fire()
    :Clear()
    :GetText()
    :Destroy()
    :SetText(Text: string)
    :ClearAfterClick(Bool: boolean)
    :ChangePlaceHolder(Text: string)

]]
section:MakeTextBox({
	Text = "TextBox",

	Callback = function(v: string)
		print(v)
	end
})

--[[

:MakeSlider()
    :Hide()
    :Show()
    :Destroy()
    :SetValue(Value: number)
    :SetMaxValue(newMax: number)
]]
section:MakeSlider({
	Text = "Slider",
	ValueType = "/",
	
	Min = 1,
	Max = 16,
	
	Decimals = 1,
	Default = 16,

	Callback = function(v: number)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
	end
})

--[[

:MakeDropdown()
    :Hide()
    :Show()
    :Destroy()
    :Set(Table: {})
    :Add(Table: {})
    :Remove(Table: {})
    :Refresh(Table: {})

]]
section:MakeDropdown({
	Content = {"Dropdown", "1", "2", "3"},

	MultiChoise = false,

	Default = "1",

	Callback = function(v: string)
		print(v)
	end
})

-----------------------------

local section = tab:MakeSection({
	Text = "Section 2",

	Column = 2 -- 1 - Left, 2 - Right
})

--[[

:MakeKeybind()
    :Get()
    :Hide()
    :Show()
    :Destroy()
    :Set(newKey: Enum.KeyCode)

]]
section:MakeKeybind({
	Text = "Keybind",

	Default = Enum.KeyCode.B,

	Callback = function(Input: Enum.KeyCode)
		print(Input)
	end
})

--[[

:MakeToggleKeybind()
    :Hide()
    :Show()
    :Click()
    :Destroy()
    :Toggle(bool: boolean)
    :Set(newKey: Enum.KeyCode)

]]
section:MakeToggleKeybind({
	Text = "ToggleKeybind";

	Default = Enum.KeyCode.B;

	ToggleFlag = true;

	KeybindCallback = function(Input: Enum.KeyCode)
		print("keybindCallback", Input)
	end;

	ToggleCallback = function(v: boolean)
		print("toggleCallback")
	end
})

--[[

:MakeColorPicker()
    :Hide()
    :Show()
    :Destroy()
    :SetHex(hex)
    :SetRGB(color)

]]
section:MakeColorPicker({
	Text = "ColorPicker",

	Default = Color3.fromRGB(255,255,255),

	Callback = function(v)
		print(v)
	end
})

--[[

:MakeToggleColorPicker()
    :Hide()
    :Show()
    :Destroy()
    :SetHex(hex)
    :SetRGB(color)
    :Toggle(bool: boolean)
]]

section:MakeToggleColorPicker({
	Text = "ToggleColorPicker",

	Default = Color3.fromRGB(255,255,255),

	ColorPickerCallback = function(v)
		print(v)
	end,

	ToggleCallback = function(v)
		print(v)
	end
})

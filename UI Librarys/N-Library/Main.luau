-- Rewritten by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discrod Server: https://discord.gg/pY6nDej76m

-- Example: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Example.luau
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

local module = {}
module.__index = module

type ThemeType = {
	Box: Color3?,
	BoxFocused: Color3?,

	ColorPicker: Color3?,
	ColorPickerBoxes: Color3?,

	Button: Color3?,
	ButtonMouseOver: Color3?,

	Section: Color3?,
	MainFrame: Color3?,

	TextColor: Color3?,
	EnabledText: Color3?,
	DisabledText: Color3?,

	Dropdown: Color3?,
	DropdownContent: Color3?,
	DropdownMouseOver: Color3?,

	ToggleDisabled: Color3?,
	ToggleEnabled: Color3?,
	ToggleDisabledMouseOver: Color3?,
	ToggleEnabledMouseOver: Color3?,

	Slider: Color3?,
	SliderFill: Color3?,
	SliderMouseOver: Color3?,
	SliderFillSliding: Color3?,

	Tab: Color3?,
	TabBackground: Color3?,
	TabToggleDisabled: Color3?,
	TabToggleEnabled: Color3?,
	TabToggleDisabledMouseOver: Color3?
}

type WindowType = {
	Name: string?, --// Default is 'Name of window'

	Theme: "Metalic" | "Sunset" | "Cosmic" | "Wave" | "PurpleAndBlack" | "Light" | "Dark", --// Default is 'Dark'

	SizeX: number?, --// Default is '330'
	SizeY: number?, --// Default is '360'

	CustomTheme: ThemeType?, --// Default is nil

	OpenGuiKeyCode: Enum.KeyCode? --// Default is nil
}

type TabType = {
	Text: string? --// Default is 'Tab Name'
}

type SectionType = {
	Text: string?, --// Default is 'Section Name'

	Column: number? --// Default is 1
}

type LabelType = {
	Text: string? --// Default is 'Label Name'
}

type ButtonType = {
	Text: string?, --// Default is 'Button Name',

	Callback: () -> nil, --// Default is nil
}

type ToggleType = {
	Text: string?, --// Default is 'Toggle Name'

	Flag: boolean?, --// Default is false

	Callback: (Toggled: boolean) -> nil --// Default is nil
}

type TextBoxType = {
	Text: string?, --// Default is 'TextBox Name'
	Callback: (Text: string) -> nil --// Default is nil
}

type SliderType = {
	Text: string?, --// Default is 'Slider Name'
	ValueType: string?, --// Default is '/'

	Min: number?, --// Default is 1
	Max: number?, --// Default is 100
	Default: number?, --// Default is min
	Decimals: number?, --// Default is 0.1

	Callback: (Value: number) -> nil --// Default is nil
}

type DropdownType = {
	Default: string?, --// Default is nil
	
	Content: {}?, --// Default is {}
	
	MultiChoice: boolean, --// Default is false
	
	Callback: (Choice: string) -> nil --// Default is nil
}

type KeybindType = {
	Text: string?, --// Default is 'Keybind Name'
	
	Default: Enum.KeyCode?, --// Default is Enum.KeyCode.B,
	
	Callback: (Input: InputObject) -> nil --// Default is nil
}

type ToggleKeybind = {
	Text: string?, --// Default is 'ToggleKeybind Name'
	
	Default: Enum.KeyCode?, --// Default is Enum.KeyCode.B,
	
	ToggleFlag: boolean?, --// Default is false
	
	ToggleCallback: (Toggled: boolean) -> nil, --// Default is nil
	KeybindCallback: (Input: InputObject) -> nil --// Default is nil
}

type ColorPickerType = {
	Text: string?, --// Default is 'ColorPicker Name'
	
	Default: Color3?, --// Default is Color3.fromRGB(255, 255, 255)
	
	Callback: (Color: Color3) -> nil --// Default is nil
}

type ToggleColorPickerType = {
	Text: string?, --// Default is 'ToggleColorPicker Name'
	
	Default: Color3?, --// Default is Color3.fromRGB(255, 255, 255)
	
	ToggleFlag: boolean?, --// Default is false
	
	ColorPickerCallback: (Color: Color3) -> nil, --// Default is nil
	ToggleCallback: (Toggled: boolean) -> nil --// Default is nil
}

local Settings = {
	DragSpeed = 0.1,

	Open_Menu_On_Execute = true,
}

local function check(a, b, c)
	if not a then
		-- if b and b:len() > 0 then
		-- 	warn(`[!] {b}`)
		-- end

		return c
	end

	return a
end

-----------------------------------------------------------------------------------------

--// Instance Library
local CloneRef = check(cloneref, "Your executor not support 'cloneref', library might be detected by Anti-Cheat!", function(o)
	return o
end)

--// File System
local GetCustomAsset = check(getcustomasset, "Your executor not support 'getcustomasset', library might be detected by Anti-Cheat!", nil)
local WriteFile = check(writefile, "Your executor not support 'writefile', library might be detected by Anti-Cheat!", nil)
local ReadFile = check(readfile, "Your executor not support 'readfile', library might be detected by Anti-Cheat!", nil)
local MakeFolder = check(makefolder, "Your executor not support 'makefolder', library might be detected by Anti-Cheat!", nil)

-----------------------------------------------------------------------------------------

local UserInputService = CloneRef(game:GetService("UserInputService")) :: UserInputService
local TweenService = CloneRef(game:GetService("TweenService")) :: TweenService
local Players = CloneRef(game:GetService("Players")) :: Players
local CoreGui = CloneRef(game:GetService("CoreGui")) :: CoreGui

if not CoreGui then
	CoreGui = Players.LocalPlayer.PlayerGui
end

local Themes = {
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
} do
	table.freeze(Themes)
end

local Base64 = {} do
	local Chracters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	
	local decode_chars = {}
	for i = 1, #Chracters do
		decode_chars[Chracters:sub(i, i)] = i - 1
	end
	
	function Base64.encode(data: string): string
		local bytes = {}
		for i = 1, #data do
			bytes[#bytes + 1] = string.byte(data, i)
		end

		local result = {}
		local temp

		for i = 1, #bytes, 3 do
			local b1, b2, b3 = bytes[i], bytes[i + 1], bytes[i + 2]

			local n = (b1 or 0) * 0x10000 + (b2 or 0) * 0x100 + (b3 or 0)

			local c1 = math.floor(n / 0x40000) % 64 + 1
			local c2 = math.floor(n / 0x1000) % 64 + 1
			local c3 = math.floor(n / 0x40) % 64 + 1
			local c4 = n % 64 + 1

			result[#result + 1] = Chracters:sub(c1, c1)
			result[#result + 1] = Chracters:sub(c2, c2)
			result[#result + 1] = b2 and Chracters:sub(c3, c3) or '='
			result[#result + 1] = b3 and Chracters:sub(c4, c4) or '='
		end

		return table.concat(result)
	end
	
	function Base64.decode(data: string): string
		data = data:gsub('%s', '')

		local result = {}
		local temp = {}

		for i = 1, #data, 4 do
			local c1 = decode_chars[data:sub(i, i)] or 0
			local c2 = decode_chars[data:sub(i + 1, i + 1)] or 0
			local c3 = data:sub(i + 2, i + 2) == '=' and -1 or decode_chars[data:sub(i + 2, i + 2)] or 0
			local c4 = data:sub(i + 3, i + 3) == '=' and -1 or decode_chars[data:sub(i + 3, i + 3)] or 0

			local n = c1 * 0x40000 + c2 * 0x1000 + math.max(c3, 0) * 0x40 + math.max(c4, 0)

			local b1 = math.floor(n / 0x10000) % 0x100
			local b2 = math.floor(n / 0x100) % 0x100
			local b3 = n % 0x100

			temp[#temp + 1] = string.char(b1)
			
			if c3 ~= -1 then
				temp[#temp + 1] = string.char(b2)
			end
			
			if c4 ~= -1 then
				temp[#temp + 1] = string.char(b3)
			end
		end

		return table.concat(temp)
	end
end

local Utils = {} do
	local forcedProperties = {
		BorderSizePixel = 0,
		AutoButtonColor = false
	}
	
	local Assets = {
		Triangel = {
			Base64 = "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",
			Asset = "rbxassetid://8233647312"
		},

		BlackWhite = {
			Base64 = "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",
			Asset = "rbxassetid://8630797271"
		},

		ColorPick = {
			Base64 = "iVBORw0KGgoAAAANSUhEUgAAAaQAAAGkCAYAAAB+TFE1AAApuElEQVR42u2d25LjuI5FBbmqI+b/P3YmqtLCPJSdSdsUCV4F2WtFnNPdKYsEQZCboG6ywDfbsurRNojIsizLoqrm47lzets2uq5Z9RzZvzPbVlPnCDvP0q+z7FyXTZh1H/mFCx5C8XgTVMqPq/iw7Wz1eOxfL3WOsPMs/aroBILkgtWRKGrB8dw5IwRb36Ceoxc96rjOEXaepV9n2XllyvWXEnhaGP2PLqq3IJRlkVg2osYgDc43nxOeHoijbr32InbaYzzHun0h8hNa3WzfWSykyn+wI+gDa5tq2j5t5Ha0Lebb6DjQirpy4yA8vvXxSdTGxvE4oO9E/4/5lwwppUiXZVmCQaGxSbBg0HyfXzHQNJhMe60bolsRWnCOHmy7RGwX4zlbeZvU8Yq+p225OP8+XjmRJ8eBBG2RTj7R/uNxWN8BgrTLevtfaqJb7RlS8Tl75/cK4ApBat7uqWl7STKvFXZIxfnetph62iaJv0lhvJTGcc84TwnSiPHUO5YBQXrg0jHItCAIS64Hpa4hZZdmFQO5ZCD1srmXP7RywloqfFzTHyWTvBjrq/FxTUxY+7Tk+NIp/qRz/5TGp3TobwQJvt2hhQNoRIDn6modYFpYX22ZMyd3nXTOiMnOmqml6j3Kx70m+9YF0Yx+Gu0DZmC4h5TI43UHiew1aySLksaLpN9l6q2sZf+ayffxyDk1dYa2t7YtVmY4SO97+Lkyq9oWXIuQbeA5e+WsDf0hmesKkTKjcVpgh67pOLf6KzdeqsbBXvWtfdTbznA8VviTRAlBSgfI77IBMiKwtOK4Tq5vZpnaMmEMPmfmRKMVtutkf/X04cg+Gt3Xo/2AIH0GsvxaVF7vLpLcKi1YJVbtmAcrXLmt4lTSdyRJcFxjdubqvp0vmRWuBselpszIKj9bpuTudExnEZI5R6MZ55rcIMpuZj5kKVK4aRT4Jnpcbj4LNmyDLDP0t8ZiKWb7Q2a8GrUs4q+HciTao+YrlGFMx/ogsNN6NdDa17n4lmh8xrMuMfsTEKTURCWXp2Ddbn8P0vHYjQ+PoyYoL/bczzU4SV4GyPc50UHzM/h1+fUyLKP1LXHb7uU/nnNJT9/R9mzBhPTLZke2zNc+2N2GCZ2vS6EfwudqMv0eebZl13fJ3be7v+RW/n4f/ZS/BX18CX4XszMQsXv5eo30wCVYiCzpfg19o0/9Em5V7Y6rmA8ji5/ld9AvsbGnpjIf/XGNLBRi8bVG4mbHDo3EX8zv0XEPCJI5Q/rvaS0TrISWgpX67sykwcQlS/o2WE0K0j97JLGOs+4vtF78jk1crWVqnSAVt0kjtuuTP9cG38W4mhcAj89Q6dM5246d18Tfnm1fjXamnlMSgx/E2K+5tqXubtOMP5ad9qTGuMXHkefcov2KICFIpRnSy96vBv+oeR9YxWSsxgK19NwSG0t+u762p+s1ooo7r7Sm8sikmev3qn2YNd2H0fJj56w7dmZ+a21brF+LFhUl48DattTpmvdHfEsj0R8GH0fjRjL+BATJND1xMRIAAEFygCy/cQIAAILkATIkAAAEiQwJAABBgjsIEgAAgoQ7AACYgeHOf7gAAABBwh0AAMzAcGPmNaRen4+oPb93ObXlH/Hafuv3ls74GYHWb/UcabN8iB282Q5BQpAQJAQJQUKQEKTzDGWeQwIAQJAcwHNIAAAIkhMQJAAABMkF3PYNAIAgkSEBACBI8I8NdwAAIEge4KYGAAAEyQkIEgAAguQCbmoAAECQyJAAABAk+IfgDgAABIkMCQAAQQIECQAAQfIFNzUAACBIZEgAAAgSIEgAAAiSK/geEgAAguQCriEBACBIDlC27AAAECTcAQDADAw3eNs3AACC5AK27AAAECQnGRLuAABAkFwoEu4AgEkoLkCQUvGhuAMAAEHykCDxHBIAAILkI4MWnAAAgCB5gLvsAAAQJAe8btlpt5Jrc7b9srSyHu1kW6m9e7+VRn+L0R4psF2M9khFe6TCh7nzNWNTyflLQ/0yoE0l8dN73I4aJ4AgVbnj2qnctSKgtx3xWBPHc/XUnFNCzF+XjB2XYBLZKiaJNTO5bwk7YrbnfBzzXVhP6E+rP3J9ZPVnaHvMn3v+ujbE8V7bF2O/tpZ5qfDhrDEMCFJz0JVMHi2ZQ45LpqxLRT2XTra1ln/ZOf6rs2+l0jdq7P8923v3UU9/akWd1gxbK6cZTZyTK7O1PSPHMCBIuAPgSSwU24EZ+HzwPSR4J3Qn88d2QJBOAMEP7yhIgu2AIJEhAQAAgoQgAQAgSOeFLTsAAASJDAkAAEECBAkAAEFyBXf0AAAgSA7gETwAAATJBVdcAACAIHlgwwUAAAgSggQAgCDBXZC4pwEAZsFFawQpxZUAAQBAkFwIEi4AAECQPAqS9X3DJR/KPmI3QBzbuTj215nrOZPfWt7r7cWfjC0EqX9QPUXSdouyNRNhWxCNq5No1MgI8Winm76fNKO8Wx/0aI91nB3Zb0P8wCUCBCnF107EbAU50uZkfaSBTRLJkTbWcQZ/jV1Lb2+WI22NOVLN+fP67dP6FUE6nNebGsS4khGHq56YTR7t9OyvM9dzJr9Jw/le/MnYQpB6p91PkSQit22BeITdj+9vJ+juOeGxXDmxMkvqjv02V07suNXmPX/FzrX+Nve7Vh+XlN80bRW0vVfM1Zyfi4uS9qTirzY+R/RbS6yVjB1AkEx8PafascwinqXnV02F2YrsVrO/mpSHIl/Lfywztyr9d1w0Xaa53eHRvTKTPi7YBinICMVqRy/U7qduMVd0/uvvonFT0h6tySikT3urfGsv8x7L+THKNh6CVIin275rrtU+rDojZ1WVOWBIebojSZ3Y4Qdx3V/eIH4QpHGC5Ciqarb0NLhNMHZK6xZWydZi77bN8LMXm1J2jrbt7o6HbLtiq7bVzlntPbRf2MVDkFJ8Fa9/1HDUssWQ3n+T4Hhya0kykR8t87H05/pFdWelrBF71GaU5DwmxaM6ua30YlHQJhGTHXF/leQRtrbt9nVywtOC+JLSBOnpb7p/sFk7IvGXjf3cE3dLhW9s/pLdUjRSCzkUglSaIal5hu+cqI+uR/r8TWvO7+mHWefIgD4SZ+0Z4eNZcdozDjudz/UiBKm7IO2u/rTjADRmETsrQ6nK82W3TNldDWp2HVi+Oi+3s25C0YJz1GhHSSxoQ9ukwnclWWpL/JRkZ631aEPbpHLsaUU7RowDBAmWZbm+BFJNgJcP7seH+17/7THUyy4661M75KVO2a3JMuHkxbJ8+63unJyP97ZUJFHaq2+et14k6mmJeFB3+8/em3tH9xYvLWVa41x24ri1npqJPrbweu3NfCyU3MZRI5yAIBn4M30r5B9rMFA0enypPi5PA1GTdZZsX0hQ/j82x1t2a/DvW+a6gET9KcXHt0gfbI3tWRN1W44vFfFl9bEEMrRl+8BaT9uWXaxt+ViYueUHCNJuhnRMWr1l1lYtx/dyvlyZLZssHrG2VzK5QclxHeCj1lhZOp1TEwvbAbGyDYx9QJCG8sXKBgAAQfIhSAAAgCA5YCOBBwBAkDzwly07AAAEyQN8whwAAEFyAdeQAAAQJBf8xQUAAAiSB7ipAQAAQXKSIXFTAwAAguRCkOqpeS0o+PHhGfvPo82zbbK+8lYry10Y1wjSUXwtupR9T+bnhZk/7/DSypBfjEOg5QWQOTtavylb3+bYO+Bs5fd54/rju/3K38je703Xtvbuv1PP+oZyqfTx/suS9vtwxLQut35L+yDer+m2S+TVsLrzCuS2t5IDgpTMkGTnS6vxL7He/17zgtHcBybDOmPn5b4Oaylrrz2WMi1ll7ZZbuNUxV5+1Yc6I2U+TmxiqicXF0XTq5S1V4I5TTN9GCtTKn38/Nvw2J5NLX6p8UNYT6xfc21fo1IafKIxNgdkymyNDwTpA7laFi+9Fjfa8TwdYMeIRZwO8I127PuWevRA39T0YS8fz4yfCj9cK2y7jhiDJEUIUilfDVFT8yUf8OPDs/VfzebqO9rU58Pxee1gXCNI0/lD2AEAIEge4DkkAAAEyUeGJGRIADAJ1r8IUoorAQIAgCB54IslCwAAguQBXq4KAIAgueDKJSQAmAUbMghSij+4AAAAQfLAF6/0AABAkDzAJ8wBABAkF3BTAwAAguSCL1wAAIAgIUgAAAgSIEgAAAiSJ7ipAQAAQXIBzyEBACBIH5MhBR9CPsWD2v+ezNLb/4vbMkf0kRfbevprZNtydoYR78e3/cejJH3w4yNAkBwI0nKqkHycRPyW+e591MumkW3L9Ws4Paszvy6Ldl5w7beRx+8RJBMztuzWIFjPkiHdB9DmuMwR7fXSR738NbptOTvX4N+99PuI8ZgqUxAkBMnKtugtgKQoiQ/fOCSZU/RhRdYHLbS35JzHVa2a/JDzQUmZo3m2WZ68pAYfPjdaOjdJIhO5pa+b2lYQ09Z+1dzxknEk5b6OxbxGxKN18277tu2nld/2DogPBOlNuX6n7VomSHpsOq4Pdeuwc6x+ONMKsMXmf9PNLV4mxUBJvzW17YCYLqmzvG0SLDe14nhbTB09RyBIJ+RrWW/BeL8oub4MezFOGHu/1cagjJ+/BSvANblyrTkndz2gxR9Lx3LU2AYxnGvzwRYcWZN9pEbb8z7agl+u1T4efX0jZpNmfCsVdtpj83VcP/5Wo33ZO44BQSoaROE2zBYLxsxIyq2ExgjSWjHJrMkBvQY+mCFIuesPPgVpNfdRN0G6B6BKvG3GOwfeWZDWaCxJNK+UaASOW1gBgmTmz1PIiXUkv+Ge8NcBg08Z8AYnSV3q80FcEQ8E6Z0m4Z9gbl3XauHazkJuvVk2S8kSX2nnxUEL7c2fk77RwlKOGNe1Vt+1btZqQb9b46JX/0tjv9b0e03OWjf24jcoyJQ4tueEgCAl2Io3MFqOS8cB3/O3I8uUTr9rLUcm+VgOaNtZYkUOjoEj45i8DUEqTPU/BfbGAQBBcghv+wYAQJDIkAAAECS4s+ECAAAEiQwJAABBAgQJAABBQpAAAABBQpAAABAkj2w8QQ0AgCD5ECQeDQUAQJAccCVDAgBAkFxkSCRIADAL1r8IUlKQ2LIDAECQXAiSsmQBAECQnCBClgRgRYNFXOvY6VnWOXxH/LzMv7ggYFV99MjIb5jy4Yd9n8gb+/hom7TTNHArJ/yCrfR0TU0s6AhDxtV5ZfVLhpTigjYAHKavn7ZG40l8BCmdIc1MIFG+8T6RD2jjUfVL/+ZIq51ygI8YxwjSsAyJTV0AAATJhSCx2gEAQJBcCNKy+HxaLRRKsrgxvsWv7f4iTgFB6ixIXua/3BXe1uOtjLgDceRdjRY/H2mHF45s+xnvarD6i7tqEaRS1gmrOrMg5VabUnD+6KzNc5lntsNj27Xy2Lv6XYgpBGlQaE3whhKeALCwqYkg5QLkQjACACBIHuAuOwAABAlvAAAwBcMNObk3Pu3llACnHq+4AEFKBsjl7C0Qgh0AEKS3yJB+n30a58HEw5a4JKRAhoQgdQ2QXzMm+tyDSC1vDtAKO3IzrDa08b2HnWxBK1frc2Nn8YcMiAsWYaxeECR7mOCNNkG/zQfeL1+FH0ZL2Wr93YwppuX5tZJ2tPRhST0j20uGhCC9B5eGRZhYF5Nafrwmss3n7tSnCTs0XtfPN9X05481rzyrfVlAy2vWInVKZktu97AWJqGGc2SpLzP7VYdYV1f0gbSq9V7IiTF+G+s0bx5Y54jdmEOKECRLbP7aCcbwb1vsuPz8ZgtmgfsyMRw0mjhnr8wcW2TmCZeoqWWv7pyz6b4d+lSmlA74SD0hq9jau9fmu226U2bQH9opdYjON7Hfbhmb9vrofjzmm73UxJruZFObTDus46BkcaTGcdBr7OTiTzW9aMj5PdY2QJCS/BaDIEkmFoMPl32v2CW+epL9MsPj4UpdY/ZtkY+lhdlCzKZYgbJTZlSQ9o8/2LtImz9T7d1tcyQ7W5d0obktuav8nLrmJtbEx+tC21fjOaG/14yPxVimJQaSE3k6ZmPxk43j3DipsSMSl5qJv2j/qmQEKeP3WNsAQUp7wxApa3k2X1NmUfnZCbJwsrGU2WJvqz/XA2JDfsRSB/b1EB+XNPO2GlDVtnask2xeG312RCwBgmTOkAAmCoDfdjIWAEE6WJBwAXw4fK8QECS8AdA/3TnJffgATMFkSPDugmS8qQEAQfIHD8YCwLT1Ai5AkJIBgjcAABAkF7BlBwCAIHng/G/7BoCzwGyDIKUD5D+u/gIAIEgeuOACAAAECW8AADAFww1uagAAQJA8wE0NADALZhsEKZMhcVMDAACC5GHFwpYdAACC5CNDIokGAECQXAgSLgAAQJBceINrSAAACBLeAABgCoYbv5fHb8fcLyn1TJxyl6nEeL4UlB1+BVQi54jR3lg5mmnD3vnLAN+W9ltr20v6WhrtKO23Hr7pEacl/a6V5fc6R4193RrTXKpGkCzIr59vmi3LssgtcLTjpCmZYMzV9XO+BudIsuzv77Rp7JzXv+3ba6sz5sNHO9Ltzdlk9bEaJga5tSms56d+MfnQ1tepejJlBXb+/EmqBCkVP2PiNK6C8X63+yvW+DKbUrFq9401pqPxyZSLIL1NhrRkVmm54zWrVmudrRlSawZVkwVIZXulsq9KM6iaWGnJLEbE6TIg1kZkSEtFfJIhIUjdd3qeBEkHCJI2Dqrv88Nl2JopW+7H5WcwrPt/27U3/CS2JOqUnfNl/28PdW6vbavysWFi0Hub1sjfJONDSdcR9d0aaafkBUmfl91SF5ep+BkSp89xk+r3XKyFcSGNNqViVdP9UhPTRb5FkABvOOJCOwF/MQV/Or/HXGMHgDNskfTfEbFUBwhSlPWXLnpwoIy4kcKLnflzxMVQzV389uT/V9tyF0VKyppl83H11Ny8YS+/vC8QJPgJmV+3e5kOjJ2zhK0OPEfW4G6sjT6ot1FctddjPTqtHey9IEilgfb7acWk82Pp+3rqlollzSzEej0rs3M8drtrc9v0LkgFo7/ljrrKVbGLWN25tb7mDsXdsgYKhfQqTNrak3vMw3yreMWdd+RMCFLGG/rv+Y7p67fXWVlPsqLSol9IkcZ4mgL11H1g980xWcy4lV9ZthR5XipjG6KCIA32Rk3KkEtXRk935WmC3JZ5j9nArAeAerZ9hL+lsa9LX//Q6g8p6I8aH0lF2TUP42hFm3MxXdP/Ncel8TggSC/ekMrBL4UTRW+k/HdR7ZABdkgn2wf5YXpfH+2PkXbKgL5qjekRdYujPkaQ3hb5oOcclKEBxLQLewFB+nhvIERATANTsOcVC0+CAwAgSHgDAIApGL69wa4uAACC5IELu9AAAAiSC0HCBQAACBKCBACAIAGCBACAIHnzRs/7Gnx8TWGs7Z/yRpQz9qVnm61xMzO+evmr1xvFEKQPZ++z0K1v1i4p03p8qbCjdeLo+Vsrnh+/b3ndX21Z2tgvvf3Z4/21xrdjN/u75a1JNf129BvFEKSTs2rBiG5dUvV8GeOZU7GzLfNbl7q5F6H29Id0jtnRKcyINKJXma39BghSKZfUMqv3siZX5og6YXy/taYZ+GOMP3RAOxEjD5sO78umRBgAzGEV5l8ypIQ6y7aj17mtvNrj1nNqvi1jLbNkc7zis5jZ7ciaFad1u7N2feFlm7DX95JG9OvSyce5MkZsXbd+r6tP/LH6JUPKZEhfxAgATMqQfjH/kiGxZgEAQJDc54sbPgAAQJA8cMUFAAAIkgfIkAAAECQECQAAQQIECQAAQXIF15AAABAkN4I04t1cre+q60XP9+f18kfuzZ81Dznm3iA6632EvWLlHfm011/zum8EqRi27AAAECQ3GVKP9+lbVuo96ym15yibchlQr9cmlbwWqeV7DLNi5R05Iv5pL4J0qqT6CycAwHSJAgQpEiDc1AAAgCC5yJAQJAAgQ0KQXIAgAQAgSC5WLAgSAACC5IDXmxpqPmIXS8pb72g78g6dmrpHfPRPO/k9ZV9p/9b6MVVXa1/3PD9WjlbYW1qmz+Vqb9vZskOQMhHCXXYAAAiSC66Fq83WTypLp3LG547l9Uth1pRbgfb0V2um1+LDmtX36L4akcW2lultp6C27YAg1YZb8gN9NQGnjce9JPc68BwtOFcn+/0IH+oBfdXqO/3gcaCH9RSC9Obo8hcnAPhdMjKVI0gfJEhcQwI4gSAhSgjSR8Q7GRIAAILkAjIkAAAEyQV8fgIAAEFyAVt2AAAIkgP4/AQAzILbMhCkDLzLDgAAQXKxYvmDEwAAEKTj4XtIADBvAQwIUhIECQAAQXIBd9kBACBIDmDLDgBmwZYdgpQJEG5qAABAkFwoEhkSAACC5AIejAUAQJA8JEinuqnh6K9naqRuPcCeGj8c7TsvceMhfnrWr477lCtGCFIhvDoIAJAoBMmJIp0nQ1L9CWcROaz+sO7Y3zz64WjfeYkbD/HTs/4j4q/F74AgZThPhnT0mIvVf4RNNXWKfG6Ee2n7CDs892vMNiQKQUoHDXfZAcCsrAkXIEjpAOFNDQAACJKLFImbGgAAECQXGRKCBACAILmAVwcBACBIDhAuMwLAJJhtEKRMgHBTAwAAguQhQ1KuIQEAGRKC5AKeQwIAQJA8rFiEmxoAABAkB8iy4QQAmLMAxgUIUjJAlJsaAAAQJBcpEjc1AAAgSB706OlNDdbPfe19aiz1KbSSz5PlPqmmmbqlwvbFaJM0ltnzc3HaycdS2N5aP2pjXLT4u5ePezKzHdZYXIz9Lp3qQZAgCJS/zQGkFce10+DRxgGgnQfxqDKXwT7WRtv0AJtn9PXMSVWd2DEyzgFByrA1rH96fdK7ZC3emlP0LrvG9hHtaM1jZ9jjKR/p1d6cj0ePjSP96UnOEaQ34YogHSZIMnESQJDibZdBNiNICBKCVMHTc0i63uJX00Gk8hPksv0EvYrt/HBCSJ4THH/4c6fb1e/tfShb7QMo6a8d28NBKgMHati2WB9Fu0OPnTy+bR7gmzBme/VBdhxsbW1r8seOHdPJjQMECb5DZSuc6Nfgd9pngS2Nx5scsI09/8hxuGdbsU01tx2Ek//WyZ9hmRXCKUMGkP3vNbHWHJ9uJhryJATJMtWUvjpoIw3/0Egpn+Gkc5wIsQcI0nuzVf5eHC2/YLwYaWG/h+esB9oBgCCdBuGLseBu0QPvnmcDgrQbIlo0YQih9aFLl/J+HxErxB8gSG88zfxlcAMAGRKC5IGvRdiLBwAECUE6PkCuUUHSndDJidf9POvvwt/G/lbfLk1khZK0o6TsmO0l/mrxYa0/Rvo75tu9slPntPqwxh8lx60xV9L2Wf02skwWtwhS28DUa9f31tWshHq906y1DV7eazfaByP9rQN8dPQ75NRJ2SP6TU8SswjSx8AdUAAACJIHBEECAECQXHDFBQAACBKCBACAIMGyLMsiXIYEgEkw2yBIGbiGBACAILlZsxyxbuEVMOf1nTTUTb+P63cvvqWPEaRqOdoOFiQC91wDPhQjPZnt79zvrf3iJT4+t1dhWRbRRTXjkpKPMKtxGIXXrrRTl0ihPZYhYy1z7jrY5jsp8IPdH+mP9eU/5Vfe7zk7W/tdCsusif2SOjW5m1HrkdZ+t7Y33r/fbRM+HYsgJbjooiXB2E+Q+k/wnyNINlvGCFIu4677LYI0L3ccK0jp9l55t9ALbNkFrLgAACbBQyYIUjpDwgUAMIm/uABBIkOqp2QLCgAAQXKeId0vUomMK/uZVF3hOTmbtgrxLim/l796+bjV9pFxU2tbzDexuNkrM+Xb3AXY0f0xcmx5jQsECUHqkmXIwLJfJoJOWY/oz++sA7E1q6rxVy8fe8oIn9tUa1vMN1oQM9Z720rjsEd/6KS+YqcAQZrCOvMuzJmPJXT6cNPaav/sj8voSfur1I4jPl7luT88ji3XQYUg+RQk1jsA8JarUgTpdFyEAAEAQJA8CBIrFgAABMmFIKFHAAAIkm9nlLwgJUf6Pqmf23rtZcvtpL1zttvxVWO2v9YdliXBH2Plq/y8sWvN2Jyz8/l3/34bs83WB7JzK2DuNue4fa/9tuebn3a+2pnzZ+743Y4af5TUEzuut/629HXrmNi61WMfW+n4lIJY2R+DsiyLKCtfBMmSIclaKDw1j9KGQpAQp5oHHCR+M+yvb/GI2b5zE2usrMjfHl4gKWuDnXu/jflG2/pAMjc6ixj7LdOmnJ05P4jxzXXN/rDaocGLQXs9Rq7RmPwVLHjabq6uGFtS8MZAYyz/io4Tvr+GICXYX42VZyv5LEOCVfPSuGrOrQ810xLNrLoTPgvO2Yas/F791X53knayo62eun5N+6MlVvbn5NfA0CF9HItZWXTS8wKxh45b5oDQ/+PHCYL0hs7Q5mCXyOQvUUEIJpFgwKuxzN6TQG09oe3r0JtC2hcLfSYuPdTfOTskWHW3eEZ2RHBEJKbbNO9hMvsbxnPlaCSnmjVOEKS34b/ejyGJ8W9hgEpFmSOQikHOY1wT/H1kmfoZfSwjymGcIEiF8HJVAAAECWcAADAHw53fbO0CACBIHljZ2wUAQJA88B8ZEgAAguSBCxkSAACC5MMZKBIAzIItGQQpwW8CBAAAQfLABRcAACBIHvgPFwAAIEg+MiT/15Ds79uaa48nm+CzY/I8djJiEKQTOyN8Ef+GTeCs/9X5FMtHH5iDT8VvVqNkSPC2/S/EKYKEM/om+NyYDsQnMAeTIQEAAII0yRl8yREAAEFykSGx3wAAgCC5ECRcAACAIHmANzUAACBICBIAAIIEd3h1EAAAguSC38pdDQAwC+7qRZBSzhACBAAAQfKQIe08Z74nU7l8So2/q1lTjc7ltKCdZ2ubF3+0lDmzfzzbeWSc7tWpiblCyZAQJLsg7QdgLHTWTNCGE6x0GghqqLsHW2fbPbXNiz9ayhwRX6PtXN8gTi11bom5wvsLaBEkT4K086aGvUtLuR2++3k9dwJHlHlkPUfXeaRtYVyVltty7kw7R/frTD9Y64zNF+HvuFSNIJm4SD5FfwgysaX20jEAR5SZbLMcsGXncMCO8IcWxFLPc9/Jzpl+sNapibmC7AhBwhkAAMzBOAMAAJiDK5zB5i4AzIINPAQp6QwCBD4bvqoKCJITfpMhAQAZEoJEhgRw/PTo+VkwQJA+LEMCQJSWZWGvABCko7ksMiRHkookveYcOA7JTOr0oR9/+amHqECQks4gQAAAECScAQDAHAw/znjnlx+GL4Pc6G4YCC8TBQSpkUswcb8jSsfDAbHGDRKAIFUKUphF1KzsrN9HWQz1pG7B3SLlSGZCKLmtV43tVKMPauvJ+Vgzfm+9a0wME2xt/454CDX2SYqa73lpgb9jf9uM9eQu/FuPn7UPAEHKOsOLIKXKlEpBsorG2QSp1PfvKkjWibyXIO39bm308ZkFqaQPAEHKZki9JsuWld+6pK/3XIyr1iMEqUSURgrS8zUz7VCPFLSjdfVfG8PP2WHNosEaP9qhPTLQh7P7QJb49TMECUGqcIbP3e7LG6/IRtgcm+AuE+1omWBH+HVEuXrimPLTB8gUgpTg7K9LOeNXKUfYfC+zpLyedqTqP/uXQ2t86y2m+HorgoQzAACAOdjK5ewptGBzdZkyqf6zr8jlDWwkK0KQTiFIbOkCACBILgSJlRMAAILkAb4BAwCAIPkQJLbsAAAQJA+wZQcAgCA5cQaKBACzYEsGQUrQ4xqSdApBL29d8Pj2h5FvdxjVznd7yWZJe3q+ZggQpI+hxwfMpZMkiZMhKw6njhE2jW6nvJkklbQn9ltBkqBiQf9ZCbQKIwMA5ky+wouLyJBSbOgRAACC5IHryxLmnjqVLHvClGv2kqt/3bkyW4+32mEtX2QvLfa8hLbZO6sPYmOiR9mpcdazbS3jWVmsIkjTM6TnYLwHesngCieP2RPYgLq9fHDG8hEkNZ6/HNhHtW320AexMdGjbJnUtpbxjB4dFvIfi/7vU9jVfP9aD/RyzRf4pLHMnsetE4JUtFkHjAAdPLqssTSrD2Jxox3aqxW2t3x1UAqOt4znjG/kf5h/yZBSXAcJhMew82JbqyCNFu4jBclbH3iMG5lUZk3M6AljAUFyxNY5ajQS4V4CM3YN4Eg7difDyB5+q829yrLafoRYjmqHt7jpaUeqzJqYyZ7DPiCClOKrc4B8T6YOg9DLxdrc4O558Tw1wY60vazQ+bFS0g5vcdPTjpabK0bGGYL0oVwHrfoe5hhvubv3vQQZbLP48q3LWBHHcXPEFx57fQESkUKQUgvBKwECAIAgeeALFwAAIEgekv8rPgAAQJA8gCABACBIHtDqLbuax8lrHjG3/HZGObX1eHnsveUVCJZXPoiTtovjPpjVh8vgtkvFGF7epA8QpLEhXi1IWnFcO5Y/u5zaerwMQG34nQ48b0Y732USVCfxr87GHoL0PrBlBwCAILmAu+wAABAkF/wdU2z4fGPsE4C54yOeEr/XufdJwtzxEU/KJ+vkqfcp/jii3z3bYe4HYhJB6j4IBmVI0UvjwYQiQTDH52Kt0KP0OblLsdnjt/JrxmHYdlU11Vnig3v5+saTRE1MtPZBSb/vlV88ZvbsbIi/Ef2AHiFI/am9hpR5IaZGjmt4UuYmKC35RITxHM3cNJY93uKPnbNTdWpBXdHydWeyTd38VHJzZOsbogvfXq0lP+rUB9F6d9qojRfxf+zQ+vYPW7kWjE1AkKpXO1/HBHXzN4l6nVNjvwxu+4DJ/S3mkNb+rT1fB8ZsSZ3v/BkMBAmWZVmWP5UxmbsGNLjM2CpNDlxCjvBHa117K9nUNT1R299y5ZT0YU9/jSjzyL52sxb4wDYjSEdQuWV3xPuGPa/4xWFdrf6sed+1nCiGztDXnxjfCBIZEgAAIEgH88XaBwBmwX4fgpQKD97UAACAIHlA/rBiAQBAkDzAlh0ATIMFMIKU4i8uAABAkDysV/6yYgEAQJAcIGzZAcC8JTAuQJASfBEgAAAIkge4hgQAgCD5ECS27ABgFuzIIEhJQSJAAAAQJA/rFTIkACBDQpDIkAAAECS4MfUDfQAAgCDtJtB/l0Wc79rdP+0s1k+UL/PbdGTdUB4rnm1/WDAK/kKQPglu+wYAQJA8cIYtuxFfSD3KRqAfPNlO3CJIvuDVQQAwDW6iQpBS8D0kAAAEycV6xfLFWF2DHH+bZNj6+rdpdcvyvZnRq84RZcb8JfqzCm3tt2iZ93bo7e/Lv//WRNuq7MiU6bkPQt8cMXZqxnDU9sBfYYYjLGIRpEEINzUAwNNa4K49gCDNxXRTwxGRefRo0JO1SSN16IAyLf/do916wrhSh3Fc0UcaChOqhCDNDNO/Rw9ij4KkJ2zPiMmwpEwd0HalDw4QpJ8ECTFCkGZn52zZAcDDpHD7B3qEIE3nKnWLOGlchErBObP2tGP1WO+K14511virl4+koG3S0Q81sdarH6RTHEonP+yVU+PvEeeI8W+HZKkI0rm5vVxVO80RvfVIJoZyrK6Rc6FUzhE6aS5MtU06+eBoPfLeB9rg7xFj1KKVSA6C1CBIP3fXFqGNs4cxC9Hl8e7ioYR3uxaOrhofFrXNuFJW6eODXNsebK9VjxEqI+P7QKUtprM2aXC61Pu7uY8i7dn1V6/4Q5A+nGvfOUQGnjMr1mX0ORKM7ttIlk51ycH+OHo+ktI+uCtA5ziU1lZ8X8fRY2M1cY447H8E6eQon584wuu4gD4gPgBBelnR8C47AEBsESQXkCEBACBILtYrV1YsAAAIkgPkelDFne5IcmnHWdpmPS6N9Zfcf/xuffBpMf3JfkeQOvD1RoMGQUKQmBgRJATpxFwPipzTCFLFrOmybTsPlRQLkpb7YVeQNONaOX8fnFKQIh1nFqTghzLrVR4I0vvE7tdjkEjjA26x81N/s9Ql7h660yZ/lJ7b+/z7sy3t/hw7uaTtnNMHteeL8QHjmj7sOXbSx7VL//kauwjSuTKkEds0Je8dqVlpTxcfafPHrJWu5ma2o1PbzISnqbd8TuqD2vN7bUda3yFXnaWmsuBGgx9WQWRICJJZkI4LknOGp06rRVzbrwf6+bMmtmM+bNHn8yVIEIJkT6uv4xeT1r+5TJA6DWk54Pzcyy/lzX33TgnSqLEzMhbOPG4RpEMzpLZBkzu/9Z1XZw5oOfB8Obk/5cR9MNL2nmNHTtB/CNInseECAAAECUECAECQ4MaVxBoAZsEtDs/8P1VRN5zsTdMBAAAAAElFTkSuQmCC",
			Asset = "rbxassetid://8630799159"
		}
	}
	
	if GetCustomAsset and ReadFile and WriteFile and MakeFolder then
		local path = "N-Library"
		MakeFolder(path)

		for Name: string, Data: {Base64: string, Asset: string} in Assets do
			local CurrentPath = `{path}/{Name}.png`
			WriteFile(CurrentPath, Base64.decode(Data.Base64))

			Data.Asset = GetCustomAsset(CurrentPath)
			Data.Base64 = nil
		end
	end

	Utils.GetAsset = function(Name: string): string
		return Assets[Name].Asset
	end
	
	Utils.keys = {
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

	function Utils.generateRandomString(Count: number): string
		local Result = ""

		for i = 1, Count do
			Result = Result .. tostring(math.random(10000000, 99999999))
		end

		return Result
	end
	
	function Utils.HexToRGB(hex: string): Color3
		return Color3.fromRGB(tonumber("0x" .. hex:sub(2, 3)), tonumber("0x" .. hex:sub(4, 5)), tonumber("0x"..hex:sub(6, 7)))
	end
	
	function Utils.RGBToHex(color: Color3): string
		return string.format("#%02X%02X%02X", math.clamp(color.R * 255, 0, 255), math.clamp(color.G * 255, 0, 255), math.clamp(color.B * 255, 0, 255))
	end

	function Utils.getCenter(SizeX: number, SizeY: number): UDim2
		return UDim2.new(0.5, -(SizeX / 2), 0.5, -(SizeY / 2))
	end

	function Utils.make(Class: string, Props: {})
		local obj = Instance.new(Class)

		if Props.Name == nil or Props.Name == "" then
			obj.Name = ""
			obj.Name = Utils.generateRandomString(16)
		end

		for prop, v in next, Props do
			obj[prop] = v
		end

		for prop, v in next, forcedProperties do
			pcall(function()
				obj[prop] = v
			end)
		end

		return obj :: typeof(obj)
	end

	function Utils.tween(obj, info, properties, callback)
		local anim = TweenService:Create(obj, TweenInfo.new(unpack(info)), properties)
		anim:Play()

		if callback then
			anim.Completed:Connect(callback)
		end
	end

	function Utils.drag(obj: Instance)
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
				Utils.tween(
					obj,
					{Settings.DragSpeed},
					{
						Position = UDim2.new(
							objPosition.X.Scale,
							objPosition.X.Offset + (input.Position - start).X,
							objPosition.Y.Scale,
							objPosition.Y.Offset + (input.Position - start).Y
						)
					}
				)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch and dragging then   
				Utils.tween(
					obj,
					{Settings.DragSpeed},
					{
						Position = UDim2.new(
							objPosition.X.Scale,
							objPosition.X.Offset + (input.Position - start).X,
							objPosition.Y.Scale,
							objPosition.Y.Offset + (input.Position - start).Y
						)
					}
				)
			end
		end)
	end

	function Utils.ripple(obj)
		local ripple = Instance.new("Frame")
		Instance.new("UICorner", ripple).CornerRadius = UDim.new(0, 256)

		ripple.ZIndex = obj.ZIndex + 1
		ripple.Parent = obj
		ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
		ripple.BackgroundTransparency = 0.4

		Utils.tween(ripple, {0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {BackgroundTransparency = 1, Size = UDim2.new(0, obj.AbsoluteSize.X, 0, obj.AbsoluteSize.X), Position = UDim2.new(0.5, -obj.AbsoluteSize.X / 2, 0.5, -obj.AbsoluteSize.X / 2)}, function() ripple:Destroy() end)
	end

	table.freeze(Utils)
end

function module.new(opts: WindowType)
	local Name = opts.Name or "Name of window"

	local SizeX = opts.SizeX or 330
	local SizeY = opts.SizeY or 360

	local Theme = Themes[opts.Theme] or Themes.Dark

	local CustomTheme = opts.CustomTheme

	if typeof(CustomTheme) == "table" then
		Theme = CustomTheme
	end

	do
		local Gui = CoreGui:FindFirstChild(Name)
		if Gui then
			Gui:Destroy()
		end
	end

	local ScreenGui = Utils.make("ScreenGui", {
		Name = Name,
		Enabled = Settings.Open_Menu_On_Execute,
		Parent = CoreGui
	})

	local holder = Utils.make("Frame", {
		Size = UDim2.new(0, SizeX, 0, 26),
		BackgroundTransparency = 1,
		Position = Utils.getCenter(SizeX, SizeY),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Parent = ScreenGui
	})

	Utils.make("TextLabel", {
		Size = UDim2.new(0, 1, 1, 0),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		FontSize = Enum.FontSize.Size14,
		TextSize = 14,
		TextColor3 = Theme.TextColor,
		Text = Name,
		Font = Enum.Font.Gotham,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 2,
		Parent = holder
	})

	local main = Utils.make("Frame", {
		Size = UDim2.new(1, 0, 0, SizeY),
		BackgroundColor3 = Theme.MainFrame,
		Parent = holder
	})

	Utils.make("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = main
	})

	local tabs = Utils.make("Frame", {
		ZIndex = 2,
		Size = UDim2.new(1, -16, 1, -34),
		Position = UDim2.new(0, 8, 0, 26),
		BackgroundColor3 = Theme.TabBackground,
		Parent = main
	})

	Utils.make("UICorner", {
		CornerRadius = UDim.new(0, 12),
		Parent = tabs
	})

	local tabToggles = Utils.make("Frame", {
		Size = UDim2.new(1, -12, 0, 18),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 6, 0, 6),
		Parent = tabs
	})

	local tabFrames = Utils.make("Frame", {
		ZIndex = 4,
		Size = UDim2.new(1, -12, 1, -29),
		Position = UDim2.new(0, 6, 0, 24),
		BackgroundColor3 = Theme.Tab,
		Parent = tabs
	})

	Utils.make("UICorner", {
		Parent = tabFrames
	})

	local tabFrameHolder = Utils.make("Frame", {
		Size = UDim2.new(1, -12, 1, -12),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 6, 0, 6),
		BackgroundColor3 = Color3.fromRGB(20, 20, 20),
		Parent = tabFrames
	})

	Utils.make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
		Parent = tabToggles
	})

	Utils.drag(holder)

	if opts.OpenGuiKeyCode then
		UserInputService.InputBegan:Connect(function(InputObject: InputObject, gpe: boolean)
			if gpe then return end

			if InputObject.KeyCode == opts.OpenGuiKeyCode then
				ScreenGui.Enabled = not ScreenGui.Enabled
			end
		end)
	end

	return setmetatable({
		Count = 0,

		Window = ScreenGui,
		CurrentTheme = Theme,
		TabToggles = tabToggles,
		TabFrameHolder = tabFrameHolder,
	}, module)
end

function module:Hide()
	self.Window.Enabled = false
end

function module:Show()
	self.Window.Enabled = true
end

function module:Destroy()
	self.Window:Destroy()

	table.clear(self)
end

function module:MakeTab(opts: TabType)
	local __class = self
	__class.Count += 1

	local Text = opts.Text or "Tab Name"
	local toggled = __class.Count == 1

	local tabToggle = Utils.make("TextButton", {
		ZIndex = 4,
		BackgroundColor3 = toggled and __class.CurrentTheme.TabToggleEnabled or __class.CurrentTheme.TabToggleDisabled,
		Size = UDim2.new(0, 52, 1, 0),
		FontSize = Enum.FontSize.Size12,
		TextSize = 12,
		TextColor3 = toggled and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
		Text = Text,
		Font = Enum.Font.Gotham,
		Parent = __class.TabToggles
	})

	if tabToggle.TextBounds.X + 16 > 52 then
		tabToggle.Size = UDim2.new(0, tabToggle.TextBounds.X + 16, 1, 0)
	end

	local noround = Utils.make("Frame", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 5),
		Position = UDim2.new(0, 0, 1, -10),
		BackgroundColor3 = toggled and __class.CurrentTheme.TabToggleEnabled or __class.CurrentTheme.TabToggleDisabled,
		Parent = tabToggle
	})

	local tab = Utils.make("Frame", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		Visible = toggled,
		Parent = __class.TabFrameHolder
	})

	local column1 = Utils.make("ScrollingFrame", {
		Size = UDim2.new(0.5, -3, 1, 0),
		BackgroundTransparency = 1,
		LayoutOrder = 0,
		Active = true,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = tab
	})

	local column1list = Utils.make("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
		Parent = column1
	})

	column1list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		column1.CanvasSize = UDim2.new(0, 0, 0, column1list.AbsoluteContentSize.Y)
	end)

	local column2 = Utils.make("ScrollingFrame", {
		Size = UDim2.new(0.5, -3, 1, 0),
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		Parent = tab
	})

	local column2list = Utils.make("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
		Parent = column2
	})

	column2list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		column2.CanvasSize = UDim2.new(0, 0, 0, column2list.AbsoluteContentSize.Y)
	end)

	Utils.make("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
		Parent = tab
	})

	tabToggle:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
		noround.BackgroundColor3 = tabToggle.BackgroundColor3
	end)

	Utils.make("UICorner", {
		CornerRadius = UDim.new(0, 8),
		Parent = tabToggle
	})

	local function toggleTab()
		for i, v in next, __class.TabFrameHolder:GetChildren() do
			if v ~= tab then
				v.Visible = false
			end
		end

		tab.Visible = true

		for i, v in next, __class.TabToggles:GetChildren() do
			if v:IsA("TextButton") then
				if v ~= tabToggle then
					Utils.tween(v, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText, BackgroundColor3 = __class.CurrentTheme.TabToggleDisabled})
				end
			end
		end

		Utils.tween(tabToggle, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText, BackgroundColor3 = __class.CurrentTheme.TabToggleEnabled})
	end

	tabToggle.MouseButton1Click:Connect(toggleTab)

	tabToggle.MouseEnter:Connect(function()
		if not tab.Visible then
			Utils.tween(tabToggle, {0.2}, {BackgroundColor3 = __class.CurrentTheme.TabToggleDisabledMouseOver})
		end
	end)

	tabToggle.MouseLeave:Connect(function()
		if not tab.Visible then
			Utils.tween(tabToggle, {0.2}, {BackgroundColor3 = __class.CurrentTheme.TabToggleDisabled})
		end
	end)

	local tabTypes = {}

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
		if tab then
			tab:Destroy()
		end
	end

	function tabTypes:MakeSection(opts: SectionType)
		local Text = opts.Text or "Section Name"
		local column = opts.Column or 1

		column = (column == 1) and column1 or column2

		local section = Utils.make("Frame", {
			ZIndex = 5,
			Size = UDim2.new(1, 0, 0, 24),
			BackgroundColor3 = __class.CurrentTheme.Section,
			Parent = column
		})

		local sectionContent = Utils.make("Frame", {
			Size = UDim2.new(1, -10, 1, -24),
			Position = UDim2.new(0, 5, 0, 22),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = section
		})

		local sectionContentList = Utils.make("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
			Parent = sectionContent
		})

		Utils.make("UICorner", {
			Parent = section
		})

		Utils.make("TextLabel", {
			ZIndex = 6,
			Size = UDim2.new(0, 1, 0, 16),
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 8, 0, 4),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			FontSize = Enum.FontSize.Size12,
			TextSize = 12,
			TextColor3 = __class.CurrentTheme.TextColor,
			Text = Text,
			Font = Enum.Font.Gotham,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = section
		})

		sectionContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			section.Size = UDim2.new(1, 0, 0, sectionContentList.AbsoluteContentSize.Y + 27)
		end)

		local sectionTypes = {}

		function sectionTypes:Hide()
			section.Visible = false
		end

		function sectionTypes:Show()
			section.Visible = true
		end

		function sectionTypes:Destroy()
			if section then
				section:Destroy()
			end
		end

		function sectionTypes:MakeLabel(opts: LabelType)
			local Text = opts.Text or "Label Name"

			local label = Utils.make("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 5, 0, 0),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				Text = Text,
				TextColor3 = __class.CurrentTheme.TextColor,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = sectionContent
			})

			local labelTypes = {}

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

			table.freeze(labelTypes)

			return labelTypes
		end

		function sectionTypes:MakeButton(opts: ButtonType)
			local Text = opts.Text or "Button Name"
			local Callback = opts.Callback or function() end

			local button = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 16),
				BackgroundColor3 = __class.CurrentTheme.Button,
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				Text = Text,
				TextColor3 = __class.CurrentTheme.TextColor,
				Font = Enum.Font.Gotham,
				ClipsDescendants = true,
				Parent = sectionContent
			})

			local function click()
				Utils.ripple(button)

				Callback()
			end

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = button
			})

			button.MouseButton1Click:Connect(click)

			button.MouseEnter:Connect(function()
				Utils.tween(button, {0.2}, {BackgroundColor3 = __class.CurrentTheme.ButtonMouseOver})
			end)

			button.MouseLeave:Connect(function()
				Utils.tween(button, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Button})
			end)

			local buttonTypes = {}

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

			table.freeze(buttonTypes)

			return buttonTypes
		end

		function sectionTypes:MakeToggle(opts: ToggleType)
			local Text = opts.Text or "Toggle Name"
			local Flag = opts.Flag or false
			local Callback = opts.Callback or function() end

			local toggled = false
			local mouseOver = false

			local toggle = Utils.make("TextButton", {
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				FontSize = Enum.FontSize.Size14,
				TextSize = 14,
				Text = "",
				Font = Enum.Font.SourceSans,
				Parent = sectionContent
			})

			local icon = Utils.make("Frame", {
				ZIndex = 6,
				Size = UDim2.new(0, 10, 0, 10),
				BackgroundColor3 = __class.CurrentTheme.ToggleDisabled,
				Parent = toggle
			})

			local title = Utils.make("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 5, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.DisabledText,
				Text = Text,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = icon
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 12),
				Parent = icon
			})

			local function toggleToggle()
				toggled = not toggled

				Utils.tween(title, {0.2}, {TextColor3 = toggled and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText})

				if not mouseOver then
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
				else
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
				end

				Callback(toggled)
			end

			if Flag then
				task.spawn(toggleToggle)
			end

			toggle.MouseButton1Click:connect(toggleToggle)

			toggle.MouseEnter:Connect(function()
				mouseOver = true

				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
			end)

			toggle.MouseLeave:Connect(function()
				mouseOver = false

				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
			end)

			local toggleTypes = {}

			function toggleTypes:Toggle(Bool: boolean)
				if toggled == Bool then return end

				toggleToggle()
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

			table.freeze(toggleTypes)

			return toggleTypes
		end

		function sectionTypes:MakeTextBox(opts: TextBoxType)
			local Text = opts.Text or "TextBox Name"
			local Callback = opts.Callback or function() end

			local mouseOver = false
			local focused = false

			local box = Utils.make("TextBox", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 16),
				BackgroundColor3 = __class.CurrentTheme.Box,
				PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = "",
				Font = Enum.Font.Gotham,
				PlaceholderText = Text,
				Parent = sectionContent
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = box
			})

			local function boxFinished()
				focused = false

				if not mouseOver then
					Utils.tween(box, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Box})
				end

				Callback(box.Text)
			end

			box.Focused:Connect(function()
				focused = true

				Utils.tween(box, {0.2}, {BackgroundColor3 = __class.CurrentTheme.BoxFocused})
			end)

			box.MouseEnter:Connect(function()
				mouseOver = true

				Utils.tween(box, {0.2}, {BackgroundColor3 = __class.CurrentTheme.BoxFocused})
			end)

			box.MouseLeave:Connect(function()
				mouseOver = false

				if not focused then
					Utils.tween(box, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Box})
				end
			end)

			box.FocusLost:Connect(boxFinished)

			local boxTypes = {}

			function boxTypes:SetText(Text: string)
				box.Text = Text
			end

			function boxTypes:Fire()
				boxFinished()
			end

			function boxTypes:GetText()
				return box.Text
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

			table.freeze(boxTypes)

			return boxTypes
		end

		function sectionTypes:MakeSlider(opts: SliderType)
			local Text = opts.Text or "Slider Name"

			local Min = opts.Min or 1
			local Max = opts.Max or 100

			local Decimals = opts.Decimals or 0.1
			local Default = opts.Default and math.clamp(opts.Default, Min, Max) or Min
			local ValueType = opts.ValueType or "/" .. tostring(Max)

			local Callback = opts.Callback or function() end

			local mouseOver = false
			local sliding = false

			local slider = Utils.make("Frame", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 16),
				ClipsDescendants = true,
				BackgroundColor3 = __class.CurrentTheme.Slider,
				Parent = sectionContent
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = slider
			})

			local fill = Utils.make("Frame", {
				ZIndex = 7,
				Size = UDim2.new((Default - Min) / (Max - Min), 0, 1, 0),
				BackgroundColor3 = __class.CurrentTheme.SliderFill,
				Parent = slider
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = fill
			})

			local title = Utils.make("TextLabel", {
				ZIndex = 8,
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = Text .. ": " .. Default .. ValueType .. Max,
				Font = Enum.Font.Gotham,
				Parent = slider
			})

			local function slide(input)
				local sizeX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
				Utils.tween(fill, {0.3}, {Size = UDim2.new(sizeX, 0, 1, 0)})

				local rawValue = ((Max - Min) * sizeX) + Min
				local value = math.floor(rawValue / Decimals + 0.5) * Decimals
				value = math.clamp(value, Min, Max)

				local decimalPlaces = 0
				if Decimals < 1 then
					decimalPlaces = math.ceil(-math.log10(Decimals))
				end

				title.Text = Text .. ": " .. string.format("%." .. tostring(decimalPlaces) .. "f", value) .. ValueType .. Max

				Callback(value)
			end

			slider.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					sliding = true

					Utils.tween(fill, {0.2}, {BackgroundColor3 = __class.CurrentTheme.SliderFillSliding})

					slide(input)
				end
			end)

			slider.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Utils.tween(fill, {0.2}, {BackgroundColor3 = __class.CurrentTheme.SliderFill})

					sliding = false

					if not mouseOver then
						Utils.tween(slider, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Slider})
					end
				end
			end)

			slider.MouseEnter:Connect(function()
				mouseOver = true

				Utils.tween(slider, {0.2}, {BackgroundColor3 = __class.CurrentTheme.SliderMouseOver})
			end)

			slider.MouseLeave:Connect(function()
				mouseOver = false

				if not sliding then
					Utils.tween(slider, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Slider})
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

			function sliderTypes:SetValue(value: number)
				if value > Max then
					value = Max
				end

				value = math.floor(value * (Decimals)) / (Decimals)
				value = math.clamp(value, Min, Max)

				fill.Size = UDim2.new((value - Min) / (Max - Min), 0, 1, 0)
				title.Text = Text .. ": " .. value .. ValueType .. Max
			end

			function sliderTypes:SetMaxValue(newMax: number)
				Max = newMax

				title = Text .. ": " .. Default .. ValueType .. Max
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

			table.freeze(sliderTypes)

			return sliderTypes
		end
		
		function sectionTypes:MakeDropdown(opts: DropdownType)
			local Default = opts.Default or nil
			local contentTable = opts.Content or {}
			local MultiChoice = opts.MultiChoice or false
			local Callback = opts.Callback or function() end

			local chosen = {}
			local curValue = Default
			local open = false
			local optionInstances = {}

			local defaultInContent = false

			for i, v in next, contentTable do
				if v == Default then
					defaultInContent = true
				end
			end

			Default = defaultInContent and Default or nil

			local dropdown = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 16),
				BackgroundColor3 = __class.CurrentTheme.Dropdown,
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = "",
				Font = Enum.Font.Gotham,
				Parent = sectionContent
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = dropdown
			})

			local value = Utils.make("TextLabel", {
				ZIndex = 7,
				Size = UDim2.new(0, 0, 1, 0),
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 5, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = Default and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
				Text = Default or "NONE",
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = dropdown
			})

			local icon = Utils.make("ImageLabel", {
				ZIndex = 7,
				Size = UDim2.new(0, 10, 0, 11),
				Rotation = 180,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -16, 0, 3),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Image = Utils.GetAsset("Triangel"),
				Parent = dropdown
			})

			local content = Utils.make("Frame", {
				ZIndex = 10,
				Visible = false,
				Size = UDim2.new(1, 0, 0, 0),
				ClipsDescendants = true,
				Position = UDim2.new(0, 0, 1, 6),
				BackgroundColor3 = __class.CurrentTheme.DropdownContent,
				Parent = dropdown
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = content
			})

			local contentHolder = Utils.make("Frame", {
				Size = UDim2.new(1, -6, 1, 0),
				Position = UDim2.new(0, 6, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = content
			})

			local contentList = Utils.make("UIListLayout", {
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

				Utils.tween(content, {#contentTable * 0.1}, {Size = sizeX}, function() content.Visible = open end)
				Utils.tween(icon, {0.2}, {Rotation = rotation})
			end

			dropdown.MouseButton1Click:connect(toggleDropdown)

			dropdown.MouseEnter:Connect(function()
				Utils.tween(dropdown, {0.2}, {BackgroundColor3 = __class.CurrentTheme.DropdownMouseOver})
			end)

			dropdown.MouseLeave:Connect(function()
				Utils.tween(dropdown, {0.2}, {BackgroundColor3 = __class.CurrentTheme.Dropdown})
			end)

			for i, v in next, contentTable do
				local option = Utils.make("TextButton", {
					ZIndex = 11,
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = v == Default and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
					Text = v,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = contentHolder
				})

				optionInstances[v] = option

				if v == Default then
					if not MultiChoice then
						task.spawn(Callback, v)
					else
						table.insert(chosen, v)

						task.spawn(Callback, chosen)
					end
				end

				option.MouseButton1Click:connect(function()
					if not MultiChoice then
						if curValue ~= v then
							curValue = v

							for i2, v2 in next, contentHolder:GetChildren() do
								if v2:IsA("TextButton") then
									Utils.tween(v2, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})
								end
							end

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.EnabledText
								value.Text = v
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(v)
						else
							curValue = nil
							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.DisabledText
								value.Text = "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(nil)
						end
					else
						if table.find(chosen, v) then
							for i, v2 in next, chosen do
								if v2 == v then
									table.remove(chosen, i)
								end
							end

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
								value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(chosen)
						else
							table.insert(chosen, v)

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
								value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(chosen)
						end
					end
				end)
			end

			local dropdownTypes = {}

			function dropdownTypes:Set(opt)
				if opt ~= nil then
					if not MultiChoice then
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
									v2.TextColor3 = __class.CurrentTheme.DisabledText
								end
							end

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.EnabledText
								value.Text = opt
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(opt)
						end
					else
						if typeof(opt) == "table" then
							chosen = opt

							for i,v in next, chosen do
								Utils.tween(optionInstances[v], {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})
							end
						else 
							if not table.find(chosen, opt) then
								table.insert(chosen, opt)

								Utils.tween(optionInstances[opt], {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})
							end
						end

						Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
							value.TextColor3 = __class.CurrentTheme.EnabledText
							value.Text = table.concat(chosen, ", ")
							Utils.tween(value, {0.2}, {TextTransparency = 0})
						end)

						Callback(chosen)
					end
				else
					if not MultiChoice then
						curValue = nil
						for i2, v2 in next, contentHolder:GetChildren() do
							if v2:IsA("TextButton") then
								Utils.tween(v2, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})
							end
						end

						Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
							value.TextColor3 = __class.CurrentTheme.DisabledText
							value.Text = "NONE"
							Utils.tween(value, {0.2}, {TextTransparency = 0})
						end)

						Callback(nil)
					else
						chosen = {}

						for i2, v2 in next, contentHolder:GetChildren() do
							if v2:IsA("TextButton") then
								v2.TextColor3 = __class.CurrentTheme.DisabledText
							end
						end

						Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
							value.TextColor3 = __class.CurrentTheme.DisabledText
							value.Text = "NONE"
							Utils.tween(value, {0.2}, {TextTransparency = 0})
						end)

						Callback(chosen)
					end
				end
			end

			function dropdownTypes:Add(opt)
				table.insert(contentTable, opt)

				local option = Utils.make("TextButton", {
					ZIndex = 11,
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundTransparency = 1,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					FontSize = Enum.FontSize.Size12,
					TextSize = 12,
					TextColor3 = __class.CurrentTheme.DisabledText,
					Text = opt,
					Font = Enum.Font.Gotham,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = contentHolder
				})

				optionInstances[opt] = option

				option.MouseButton1Click:connect(function()
					if not MultiChoice then
						if curValue ~= opt then
							curValue = opt

							for i, v in next, contentHolder:GetChildren() do
								if v:IsA("TextButton") then
									Utils.tween(v, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})
								end
							end

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.EnabledText
								value.Text = opt
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(opt)
						else
							curValue = nil
							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.DisabledText
								value.Text = "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(nil)
						end
					else
						if table.find(chosen, opt) then
							for i, v in next, chosen do
								if v == opt then
									table.remove(chosen, i)
								end
							end

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
								value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(chosen)
						else
							table.insert(chosen, opt)

							Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
								value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(chosen)
						end
					end
				end)

				if content.Visible then
					local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
					Utils.tween(content, {#contentTable * 0.1}, {Size = sizeX})
				end
			end

			function dropdownTypes:Remove(opt)
				if table.find(contentTable, opt) then
					Utils.tween(optionInstances[opt], {0.2}, {TextTransparency = 1}, function()
						table.remove(contentTable, table.find(contentTable, opt))
						optionInstances[opt]:Destroy()
						table.remove(optionInstances, table.find(optionInstances, opt))
					end)

					table.remove(contentTable, table.find(contentTable, opt))

					if content.Visible then
						local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y - 16)
						Utils.tween(content, {#contentTable * 0.1}, {Size = sizeX})
					end

					if not MultiChoice then
						if curValue == opt then
							curValue = nil
							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = __class.CurrentTheme.DisabledText
								value.Text = "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
							end)

							Callback(nil)
						end
					else
						if table.find(chosen, opt) then
							table.remove(chosen, table.find(chosen, opt))

							Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
								value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
								value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
								Utils.tween(value, {0.2}, {TextTransparency = 0})
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

				Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
					value.TextColor3 = __class.CurrentTheme.DisabledText
					value.Text = "NONE"
					Utils.tween(value, {0.2}, {TextTransparency = 0})
				end)

				for i, v in next, contentTable do
					local option = Utils.make("TextButton", {
						ZIndex = 11,
						Size = UDim2.new(1, 0, 0, 16),
						BackgroundTransparency = 1,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						FontSize = Enum.FontSize.Size12,
						TextSize = 12,
						TextColor3 = v == Default and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
						Text = v,
						Font = Enum.Font.Gotham,
						TextXAlignment = Enum.TextXAlignment.Left,
						Parent = contentHolder
					})

					optionInstances[v] = option

					if v == Default then
						if not MultiChoice then
							Callback(v)
						else
							table.insert(chosen, v)

							Callback(chosen)
						end
					end

					option.MouseButton1Click:connect(function()
						if not MultiChoice then
							if curValue ~= v then
								curValue = v

								for i2, v2 in next, contentHolder:GetChildren() do
									if v2:IsA("TextButton") then
										Utils.tween(v2, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})
									end
								end

								Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

								Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = __class.CurrentTheme.EnabledText
									value.Text = v
									Utils.tween(value, {0.2}, {TextTransparency = 0})
								end)

								Callback(v)
							else
								curValue = nil
								Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

								Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = __class.CurrentTheme.DisabledText
									value.Text = "NONE"
									Utils.tween(value, {0.2}, {TextTransparency = 0})
								end)

								Callback(nil)
							end
						else
							if table.find(chosen, v) then
								for i, v2 in next, chosen do
									if v2 == v then
										table.remove(chosen, i)
									end
								end

								Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

								Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									Utils.tween(value, {0.2}, {TextTransparency = 0})
								end)

								Callback(chosen)
							else
								table.insert(chosen, v)

								Utils.tween(option, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

								Utils.tween(value, {0.2}, {TextTransparency = 1}, function()
									value.TextColor3 = table.concat(chosen) ~= "" and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText
									value.Text = table.concat(chosen) ~= "" and table.concat(chosen, ", ") or "NONE"
									Utils.tween(value, {0.2}, {TextTransparency = 0})
								end)

								Callback(chosen)
							end
						end
					end)
				end

				if content.Visible then
					local sizeX = UDim2.new(1, 0, 0, contentList.AbsoluteContentSize.Y)
					Utils.tween(content, {#contentTable * 0.1}, {Size = sizeX})
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
			
			table.freeze(dropdownTypes)

			return dropdownTypes
		end
		
		function sectionTypes:MakeKeybind(opts: KeybindType)
			local Text = opts.Text or "Keybind Name"
			local Default = opts.Default or Enum.KeyCode.B
			local Callback = opts.Callback or function() end

			local keyChosen = Default

			local keybind = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = "Keybind",
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = sectionContent
			})

			local value = Utils.make("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -1, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = Default and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
				Text = Default and (Utils.keys[Default] or tostring(Default):gsub("Enum.KeyCode.", "")) or "NONE",
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = keybind
			})

			keybind.MouseButton1Click:Connect(function()
				value.Text = "..."
				Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

				local binding; binding = UserInputService.InputBegan:Connect(function(input)
					local key = Utils.keys[input.KeyCode] or Utils.keys[input.UserInputType]
					value.Text = (Utils.keys[key] or tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
					Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

					if input.UserInputType == Enum.UserInputType.Keyboard then
						keyChosen = input.KeyCode

						task.spawn(Callback, input.KeyCode)

						binding:Disconnect()
					else
						keyChosen = input.UserInputType

						task.spawn(Callback, input.UserInputType)

						binding:Disconnect()
					end
				end)
			end)

			UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					if input.KeyCode == keyChosen then
						Callback(keyChosen)
					end
				else
					if input.UserInputType == keyChosen then
						Callback(keyChosen)
					end
				end
			end)

			local keybindTypes = {}

			function keybindTypes:SetKeycode(newKey)
				local key = Utils.keys[newKey]
				value.Text = (Utils.keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
				Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})
				
				keyChosen = newKey

				Callback(newKey)
			end

			function keybindTypes:GetKeycode()
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
			
			table.freeze(keybindTypes)

			return keybindTypes
		end
		
		function sectionTypes:MakeToggleKeybind(opts: ToggleKeybind)
			local Text = opts.Text or "ToggleKeybind Name"
			local Default = opts.Default or Enum.KeyCode.B
			local ToggleFlag = opts.ToggleFlag or false
			local KeybindCallback = opts.KeybindCallback or function() end
			local ToggleCallback = opts.ToggleCallback or function() end

			local keyChosen = Default
			
			local mouseOver = false
			local toggled = false

			local toggleKeybind = Utils.make("TextButton", {
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				Parent = sectionContent
			})

			local icon = Utils.make("Frame", {
				ZIndex = 6,
				Size = UDim2.new(0, 10, 0, 10),
				BackgroundColor3 = __class.CurrentTheme.ToggleDisabled,
				Parent = toggleKeybind
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 12),
				Parent = icon
			})

			local title = Utils.make("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 5, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.DisabledText,
				Text = Text,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = icon
			})

			local value = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -1, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = Default and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText,
				Text = Default and (Utils.keys[Default] or tostring(Default):gsub("Enum.KeyCode.", "")) or "NONE",
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = toggleKeybind
			})

			value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
			value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)

			local function toggleToggle()
				toggled = not toggled

				Utils.tween(title, {0.2}, {TextColor3 = toggled and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText})

				if not mouseOver then
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
				else
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
				end

				ToggleCallback(toggled)
			end
			
			if ToggleFlag then
				toggleToggle()
			end

			toggleKeybind.MouseButton1Click:connect(toggleToggle)

			toggleKeybind.MouseEnter:Connect(function()
				mouseOver = true
				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
			end)

			toggleKeybind.MouseLeave:Connect(function()
				mouseOver = false
				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
			end)

			value.MouseButton1Click:Connect(function()
				value.Text = "..."
				Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.DisabledText})

				local binding; binding = UserInputService.InputBegan:Connect(function(input)
					local key = Utils.keys[input.KeyCode] or Utils.keys[input.UserInputType]
					value.Text = key or (tostring(input.KeyCode):gsub("Enum.KeyCode.", ""))
					value.Size = UDim2.new(0, value.TextBounds.X, 0, 10)
					value.Position = UDim2.new(1, -(value.TextBounds.X), 0, 0)
					Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

					if input.UserInputType == Enum.UserInputType.Keyboard then
						keyChosen = input.KeyCode

						KeybindCallback(input.KeyCode)
						
						binding:Disconnect()
					else
						keyChosen = input.UserInputType

						KeybindCallback(input.UserInputType)
						
						binding:Disconnect()
					end
				end)
			end)

			UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					if input.KeyCode == keyChosen then
						toggleToggle()
						
						KeybindCallback(keyChosen)
					end
				else
					if input.UserInputType == keyChosen then
						toggleToggle()
						
						KeybindCallback(keyChosen)
					end
				end
			end)

			local toggleKeybindTypes = {}

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
				local key = Utils.keys[newKey]
				value.Text = (Utils.keys[key] or tostring(newKey):gsub("Enum.KeyCode.", ""))
				Utils.tween(value, {0.2}, {TextColor3 = __class.CurrentTheme.EnabledText})

				keyChosen = newKey

				KeybindCallback(newKey)
			end

			function toggleKeybindTypes:Hide()
				toggleKeybind.Visible = false
			end

			function toggleKeybindTypes:Show()
				toggleKeybind.Visible = true
			end

			function toggleKeybindTypes:Destroy()
				toggleKeybind:Destroy()
			end
			
			table.freeze(toggleKeybindTypes)

			return toggleKeybindTypes
		end
		
		function sectionTypes:MakeColorPicker(opts: ColorPickerType)
			local Text = opts.Text or "ColorPicker Name"
			local Default = opts.Default or Color3.fromRGB(255, 255, 255)
			local Callback = opts.Callback or function() end

			local open = false
			local hue, sat, val = Default:ToHSV()

			local slidingHue
			local slidingSaturation

			local hsv = Color3.fromHSV(hue, sat, val)

			local colorPicker = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = Text,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = sectionContent
			})

			local icon = Utils.make("Frame", {
				ZIndex = 6,
				Size = UDim2.new(0, 10, 0, 10),
				Position = UDim2.new(1, -10, 0, 0),
				BackgroundColor3 = Default,
				Parent = colorPicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 12),
				Parent = icon
			})

			local picker = Utils.make("Frame", {
				ZIndex = 12,
				Size = UDim2.new(1, -8, 0, 0),
				ClipsDescendants = true,
				Visible = false,
				Position = UDim2.new(0, 12, 1, 6),
				BackgroundColor3 = __class.CurrentTheme.ColorPicker,
				Parent = colorPicker
			})

			picker.Size = UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24)

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = picker
			})

			local saturation = Utils.make("ImageLabel", {
				ZIndex = 13,
				Size = UDim2.new(1, -29, 0, picker.AbsoluteSize.X - 29),
				Position = UDim2.new(0, 5, 0, 5),
				BackgroundColor3 = Color3.fromHSV(hue, sat, val),
				Image = Utils.GetAsset("BlackWhite"),
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = saturation
			})

			local saturationPicker = Utils.make("Frame", {
				ZIndex = 15,
				Size = UDim2.new(0, 4, 0, 4),
				Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = saturation
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = saturationPicker
			})

			local outline = Utils.make("Frame", {
				ZIndex = 14,
				Size = UDim2.new(1, 2, 1, 2),
				Position = UDim2.new(0, -1, 0, -1),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Parent = saturationPicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = outline
			})

			local hueFrame = Utils.make("ImageLabel", {
				ZIndex = 13,
				Size = UDim2.new(0, 14, 0, picker.AbsoluteSize.X - 29),
				ClipsDescendants = true,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -19, 0, 5),
				BackgroundColor3 = Color3.fromRGB(255, 0, 4),
				ScaleType = Enum.ScaleType.Crop,
				Image = Utils.GetAsset("ColorPick"),
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = hueFrame
			})

			local huePicker = Utils.make("Frame", {
				ZIndex = 15,
				Size = UDim2.new(1, 0, 0, 2),
				Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4)),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = hueFrame
			})

			local outline = Utils.make("Frame", {
				ZIndex = 14,
				Size = UDim2.new(1, 2, 1, 2),
				Position = UDim2.new(0, -1, 0, -1),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Parent = huePicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = outline
			})

			local rgb = Utils.make("TextBox", {
				ZIndex = 14,
				Size = UDim2.new(1, -10, 0, 16),
				Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 42),
				BackgroundColor3 = __class.CurrentTheme.ColorPickerBoxes,
				PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = tostring(math.floor(Default.R * 255)) .. ", " .. tostring(math.floor(Default.G * 255)) .. ", " .. tostring(math.floor(Default.B * 255)),
				ClearTextOnFocus = false,
				Font = Enum.Font.Gotham,
				PlaceholderText = "R,  G,  B",
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = rgb
			})

			local hex = Utils.make("TextBox", {
				ZIndex = 14,
				Size = UDim2.new(1, -10, 0, 16),
				Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 21),
				BackgroundColor3 = __class.CurrentTheme.ColorPickerBoxes,
				PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = Utils.RGBToHex(Default),
				ClearTextOnFocus = false,
				Font = Enum.Font.Gotham,
				PlaceholderText = "#FFFFFF",
				Parent = picker
			})

			picker.Size = UDim2.new(1, -8, 0, 0)

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = hex
			})

			local function openPicker()
				open = not open

				if open then
					picker.Visible = open
				end

				Utils.tween(picker, {0.5}, {Size = open and UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24) or UDim2.new(1, -8, 0, 0)}, function() picker.Visible = open end)
			end

			colorPicker.MouseButton1Click:connect(openPicker)

			local function updateHue(input)
				local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
				local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
				Utils.tween(huePicker, {0.1}, {Position = UDim2.new(0, 0, 0, posY)})

				hue = sizeY

				rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				hsv = Color3.fromHSV(hue, sat, val)
				saturation.BackgroundColor3 = hsv
				icon.BackgroundColor3 = hsv

				Callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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

				Utils.tween(saturationPicker, {0.1}, {Position = UDim2.new(0, posX, 0, posY)})

				sat = sizeX
				val = sizeY

				hsv = Color3.fromHSV(hue, sat, val)

				rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				saturation.BackgroundColor3 = hsv
				icon.BackgroundColor3 = hsv

				Callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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

			function colorPickerTypes:SetRGB(color)
				hue, sat, val = color:ToHSV()
				hsv = Color3.fromHSV(hue, sat, val)

				saturation.BackgroundColor3 = hsv
				icon.BackgroundColor3 = hsv
				saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
				huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

				rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				Callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
			end

			function colorPickerTypes:SetHex(hex)
				local color = Utils.HexToRGB(hex)

				hue, sat, val = color:ToHSV()
				hsv = Color3.fromHSV(hue, sat, val)

				saturation.BackgroundColor3 = hsv
				icon.BackgroundColor3 = hsv
				saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
				huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

				Callback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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
					hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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
			
			table.freeze(colorPickerTypes)

			return colorPickerTypes
		end
		
		function sectionTypes:MakeToggleColorPicker(opts: ToggleColorPickerType)
			local Text = opts.Text or "ToggleColorPicker Name"
			local Default = opts.Default or Color3.fromRGB(255, 255, 255)
			local ToggleFlag = opts.ToggleFlag or false
			local ColorPickerCallback = opts.ColorPickerCallback or function() end
			local ToggleCallback = opts.ToggleCallback or function() end

			local open = false
			local hue, sat, val = Default:ToHSV()

			local slidingHue
			local slidingSaturation

			local hsv = Color3.fromHSV(hue, sat, val)

			local toggled = false
			local mouseOver = false

			local toggleColorPicker = Utils.make("TextButton", {
				Size = UDim2.new(1, 0, 0, 10),
				BackgroundTransparency = 1,
				FontSize = Enum.FontSize.Size14,
				TextSize = 14,
				Text = "",
				Font = Enum.Font.SourceSans,
				Parent = sectionContent
			})
			
			local icon = Utils.make("Frame", {
				ZIndex = 6,
				Size = UDim2.new(0, 10, 0, 10),
				BackgroundColor3 = __class.CurrentTheme.ToggleDisabled,
				Parent = toggleColorPicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 12),
				Parent = icon
			})

			local title = Utils.make("TextLabel", {
				ZIndex = 6,
				Size = UDim2.new(0, 1, 0, 10),
				BackgroundTransparency = 1,
				Position = UDim2.new(1, 5, 0, 0),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.DisabledText,
				Text = Text,
				Font = Enum.Font.Gotham,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = icon
			})

			local function toggleToggle()
				toggled = not toggled

				Utils.tween(title, {0.2}, {TextColor3 = toggled and __class.CurrentTheme.EnabledText or __class.CurrentTheme.DisabledText})

				if not mouseOver then
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
				else
					Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
				end

				ToggleCallback(toggled)
			end

			toggleColorPicker.MouseButton1Click:connect(toggleToggle)

			toggleColorPicker.MouseEnter:Connect(function()
				mouseOver = true
				
				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabledMouseOver or __class.CurrentTheme.ToggleDisabledMouseOver})
			end)

			toggleColorPicker.MouseLeave:Connect(function()
				mouseOver = false
				
				Utils.tween(icon, {0.2}, {BackgroundColor3 = toggled and __class.CurrentTheme.ToggleEnabled or __class.CurrentTheme.ToggleDisabled})
			end)

			local colorPickerIcon = Utils.make("TextButton", {
				ZIndex = 6,
				Size = UDim2.new(0, 10, 0, 10),
				Position = UDim2.new(1, -10, 0, 0),
				BackgroundColor3 = Default,
				Text = "",
				Parent = toggleColorPicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 12),
				Parent = colorPickerIcon
			})

			local picker = Utils.make("Frame", {
				ZIndex = 12,
				Size = UDim2.new(1, -8, 0, 0),
				ClipsDescendants = true,
				Visible = false,
				Position = UDim2.new(0, 12, 1, 6),
				BackgroundColor3 = __class.CurrentTheme.ColorPicker,
				Parent = toggleColorPicker
			})

			picker.Size = UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24)

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = picker
			})

			local saturation = Utils.make("ImageLabel", {
				ZIndex = 13,
				Size = UDim2.new(1, -29, 0, picker.AbsoluteSize.X - 29),
				Position = UDim2.new(0, 5, 0, 5),
				BackgroundColor3 = Color3.fromHSV(hue, sat, val),
				Image = Utils.GetAsset("BlackWhite"),
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = saturation
			})

			local saturationPicker = Utils.make("Frame", {
				ZIndex = 15,
				Size = UDim2.new(0, 4, 0, 4),
				Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4))),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = saturation
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = saturationPicker
			})

			local outline = Utils.make("Frame", {
				ZIndex = 14,
				Size = UDim2.new(1, 2, 1, 2),
				Position = UDim2.new(0, -1, 0, -1),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Parent = saturationPicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = outline
			})

			local hueFrame = Utils.make("ImageLabel", {
				ZIndex = 13,
				Size = UDim2.new(0, 14, 0, picker.AbsoluteSize.X - 29),
				ClipsDescendants = true,
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -19, 0, 5),
				BackgroundColor3 = Color3.fromRGB(255, 0, 4),
				ScaleType = Enum.ScaleType.Crop,
				Image = Utils.GetAsset("ColorPick"),
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 4),
				Parent = hueFrame
			})

			local huePicker = Utils.make("Frame", {
				ZIndex = 15,
				Size = UDim2.new(1, 0, 0, 2),
				Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4)),
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				Parent = hueFrame
			})

			local outline = Utils.make("Frame", {
				ZIndex = 14,
				Size = UDim2.new(1, 2, 1, 2),
				Position = UDim2.new(0, -1, 0, -1),
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				Parent = huePicker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = outline
			})

			local rgb = Utils.make("TextBox", {
				ZIndex = 14,
				Size = UDim2.new(1, -10, 0, 16),
				Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 42),
				BackgroundColor3 = __class.CurrentTheme.ColorPickerBoxes,
				PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = tostring(math.floor(Default.R * 255)) .. ", " .. tostring(math.floor(Default.G * 255)) .. ", " .. tostring(math.floor(Default.B * 255)),
				ClearTextOnFocus = false,
				Font = Enum.Font.Gotham,
				PlaceholderText = "R,  G,  B",
				Parent = picker
			})

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = rgb
			})

			local hex = Utils.make("TextBox", {
				ZIndex = 14,
				Size = UDim2.new(1, -10, 0, 16),
				Position = UDim2.new(0, 5, 0, picker.AbsoluteSize.Y - 21),
				BackgroundColor3 = __class.CurrentTheme.ColorPickerBoxes,
				PlaceholderColor3 = Color3.fromRGB(180, 180, 180),
				FontSize = Enum.FontSize.Size12,
				TextSize = 12,
				TextColor3 = __class.CurrentTheme.TextColor,
				Text = Utils.RGBToHex(Default),
				ClearTextOnFocus = false,
				Font = Enum.Font.Gotham,
				PlaceholderText = "#FFFFFF",
				Parent = picker
			})

			picker.Size = UDim2.new(1, -8, 0, 0)

			Utils.make("UICorner", {
				CornerRadius = UDim.new(0, 6),
				Parent = hex
			})

			local function openPicker()
				open = not open

				if open then
					picker.Visible = open
				end

				Utils.tween(picker, {0.5}, {Size = open and UDim2.new(1, -8, 0, picker.AbsoluteSize.X + 24) or UDim2.new(1, -8, 0, 0)}, function() picker.Visible = open end)
			end

			colorPickerIcon.MouseButton1Click:connect(openPicker)

			local function updateHue(input)
				local sizeY = 1 - math.clamp((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y, 0, 1)
				local posY = math.clamp(((input.Position.Y - hueFrame.AbsolutePosition.Y) / hueFrame.AbsoluteSize.Y) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 2)
				Utils.tween(huePicker, {0.1}, {Position = UDim2.new(0, 0, 0, posY)})

				hue = sizeY

				rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				hsv = Color3.fromHSV(hue, sat, val)
				saturation.BackgroundColor3 = hsv
				colorPickerIcon.BackgroundColor3 = hsv

				ColorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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

				Utils.tween(saturationPicker, {0.1}, {Position = UDim2.new(0, posX, 0, posY)})

				sat = sizeX
				val = sizeY

				hsv = Color3.fromHSV(hue, sat, val)

				rgb.Text = math.floor((hsv.r * 255) + 0.5) .. ", " .. math.floor((hsv.g * 255) + 0.5) .. ", " .. math.floor((hsv.b * 255) + 0.5)
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				saturation.BackgroundColor3 = hsv
				colorPickerIcon.BackgroundColor3 = hsv

				ColorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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
				hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))

				ColorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
			end

			function toggleColorPickerTypes:SetHex(hex)
				local color = Utils.HexToRGB(hex)

				hue, sat, val = color:ToHSV()
				hsv = Color3.fromHSV(hue, sat, val)

				saturation.BackgroundColor3 = hsv
				colorPickerIcon.BackgroundColor3 = hsv
				saturationPicker.Position = UDim2.new(0, (math.clamp(sat * saturation.AbsoluteSize.X, 0, saturation.AbsoluteSize.X - 4)), 0, (math.clamp((1 - val) * saturation.AbsoluteSize.Y, 0, saturation.AbsoluteSize.Y - 4)))
				huePicker.Position = UDim2.new(0, 0, 0, math.clamp((1 - hue) * hueFrame.AbsoluteSize.Y, 0, hueFrame.AbsoluteSize.Y - 4))

				ColorPickerCallback(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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
					hex.Text = Utils.RGBToHex(Color3.fromRGB(hsv.r * 255, hsv.g * 255, hsv.b * 255))
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
			
			table.freeze(toggleColorPickerTypes)

			return toggleColorPickerTypes
		end

		table.freeze(sectionTypes)

		return sectionTypes
	end

	table.freeze(tabTypes)

	return tabTypes
end

return module

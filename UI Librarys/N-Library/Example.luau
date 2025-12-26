-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discrod Server: https://discord.gg/pY6nDej76m

-- Docs: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Properties%20and%20methods.luau
-- Example: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Example.luau
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

local NLib 		= loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

local wind = NLib:MakeWindow({
    name = "Name Hub",
    
    sizeX = 330,
    sizeY = 360,
    
    theme = "Dark"
})

local tab = wind:MakeTab({
    Text = "Tab 1"
})

local section = tab:MakeSection({
    Text = "Name Section",

    Column = 1 -- 1 - Left, 2 - Right
})

section:MakeLabel({
    Text = "Name Label"
})

section:MakeButton({
    Text = "Button",

    callback = function()
        print("123")
    end
})

section:MakeToggle({
    Text = "Toggle",

    Flag = false,

    callback = function(v)
        if v then
            print("true")
        else
            print("false")
        end
    end
})

section:MakeTextBox({
    Text = "TextBox", -- or placeholder = ""

    callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

section:MakeSlider({
    Text = "Slider",

    Min = 1,
    Max = 16,

    ValueType = "/",

    Decimals = 1,
    Default = 16,

    callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

section:MakeDropdown({
    Content = {"Dropdown", "1"},

    multiChoice = false,

    Default = "1",

    callback = function(v)
        if v == "Dropdown" then
            print("1")
        elseif v == "2" then
            print("1")
        end
    end
})

section:MakeKeybind({
    Text = "Keybind",

    Default = Enum.KeyCode.B,

    callback = function()
        print("Keybind")
    end
})

section:MakeToggleKeybind({
    Text = "ToggleKeybind";

    Default = Enum.KeyCode.B;

    keybindFlag = true;
    toggleFlag = true;

    keybindCallback = function()
        print(123123)
    end;

    toggleCallback = function()
        print(123123)
    end
})

section:MakeColorPicker({
    Text = "ColorPicker",

    Default = Color3.fromRGB(255,255,255),

    callback = function(v)
        print(v)
    end
})

section:MakeToggleColorPicker({
    Text = "ToggleColorPicker",

    Default = Color3.fromRGB(255,255,255),

    colorPickerCallback = function(v)
        print(v)
    end,

    toggleCallback = function(v)
        if v then
            print(v)
        else
            print(v)
        end
    end
})

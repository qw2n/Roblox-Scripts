-- by BinaryCrypt (Aka Qwar1e)
-- Discord: binarycrypt
-- Discrod Server: https://discord.gg/pY6nDej76m

-- Docs: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Properties%20and%20methods.luau
-- Example: https://github.com/qw2n/Roblox-Scripts/blob/main/UI%20Librarys/N-Library/Example.luau
-- Loadstring: loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/UI%20Librarys/N-Library/Main.luau"))()

--[[
Themes:
	+ Dark
	+ Light
	+ PurpleAndBlack
	+ Cosmic
	+ Sunset
	+ Wave
	+ Metalic

#-----# WINDOW #-----#

:MakeWindow()
    :Hide()
    :Show()
    :Destroy()

#-----# TAB #-----#

:MakeTab()
    :Open()
    :Show()
    :Hide()
    :Destroy()

#-----# SECTION #-----#

:MakeSection()
    :Show()
    :Hide()
    :Destroy()

#-----# LABEL #-----#

:MakeLabel()
    :Show()
    :Hide()
    :Destroy()
    :GetText(): string
    :SetText(Text: string)

#-----# BUTTON #-----#

:MakeButton()
    :Hide()
    :Show()
    :Fire()
    :Destroy()

#-----# TOGGLE #-----#

:MakeToggle()
    :Hide()
    :Show()
    :Click()
    :Destroy()
    :Toggle(bool: boolean)

#-----# TEXT BOX #-----#

:MakeTextBox()
    :Get()
    :Show()
    :Hide()
    :Clear()
    :Destroy()
    :Set(Text: string)
    :ClearAfterClick(Bool: boolean)
    :ChangePlaceHolder(Text: string)

#-----# SLIDER #-----#

:MakeSlider()
    :Set()
    :Hide()
    :Show()
    :Destroy()
    :SetMax(newMax: number)

#-----# DROPDOWN #-----#

:MakeDropdown()
    :Hide()
    :Show()
    :Destroy()
    :Set(Table: {})
    :Add(Table: {})
    :Remove(Table: {})
    :Refresh(Table: {})

#-----# KEY BIND #-----#

:MakeKeybind()
    :Get()
    :Hide()
    :Show()
    :Destroy()
    :Set(newKey: Enum.KeyCode)

#-----# COLOR PICKER #-----#

:MakeColorPicker()
    :Hide()
    :Show()
    :Destroy()
    :SetHex(hex)
    :SetRGB(color)

#-----# TOGGLE KEYBIND #-----#

:MakeToggleKeybind()
    :Hide()
    :Show()
    :Click()
    :Destroy()
    :Toggle(bool: boolean)
    :Set(newKey: Enum.KeyCode)

#-----# TOGGLE COLOR PICKER #-----#

:MakeToggleColorPicker()
    :Hide()
    :Show()
    :Destroy()
    :SetHex(hex)
    :SetRGB(color)
    :Toggle(bool: boolean)
]]

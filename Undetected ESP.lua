-- by BinaryCrypt
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/qw2n/Roblox-Scripts/refs/heads/main/Undetected%20ESP.lua"))()

assert(Drawing and Drawing.new, "Your executor not supported Drawing library")
assert(cloneref, "Your executor not supported 'cloneref'")
assert(getgenv, "Your executor not supported 'getgenv'")

if getgenv().EspCache and getgenv().EspCache.Destroy then
    getgenv().EspCache.Destroy()
end

local Players = cloneref(game:GetService("Players")) :: Players
local RunService = cloneref(game:GetService("RunService")) :: RunService

local Owner = Players.LocalPlayer
local camera = workspace.CurrentCamera

local cfg = {
    UI = true,

    ESP = {
        Enabled = false,
        TeamCheck = false,
        Color = Color3.fromRGB(255, 255, 255)
    },
    
    Tracer = {
        Enabled = false,

        Origin = "Bottom"
    }
}

type espClassType = {
    new: (plr: Player) -> espClassType,
    RemoveBox: () -> nil,
    HideBox: () -> nil,
    ShowBox: () -> nil,
    plr: Player,
    Components: {
        Up: Frame,
        Down: Frame,
        Left: Frame,
        Right: Frame,
        Tracer: Frame?
    },
    __cache: {
        lastColor: Color3,
        lastTracerColor: Color3,
        lastTracerThickness: number
    }
}

getgenv().EspCache = {
    Boxes = {},
    Connections = {},
    Destroy = function()
        for _, Box in getgenv().EspCache.Boxes do
            Box:RemoveBox()
        end
        for _, i in getgenv().EspCache.Connections do
            i:Disconnect()
        end
    end
}

local espClass do
    espClass = {}
    espClass.__index = espClass

    function espClass.new(plr: Player): espClassType
        local old = getgenv().EspCache.Boxes[plr]
        if old then return old end

        local self = setmetatable({
            plr = plr,
            Components = nil,
            __cache = {
                lastColor = nil,
                lastTracerColor = nil,
                lastTracerThickness = nil
            }
        }, espClass)

        local Up = Drawing.new("Line")
        Up.Visible = false
        Up.Color = cfg.ESP.Color
        Up.Thickness = 2
        Up.Transparency = 1

        local Down = Drawing.new("Line")
        Down.Visible = false
        Down.Color = cfg.ESP.Color
        Down.Thickness = 2
        Down.Transparency = 1

        local Left = Drawing.new("Line")
        Left.Visible = false
        Left.Color = cfg.ESP.Color
        Left.Thickness = 2
        Left.Transparency = 1

        local Right = Drawing.new("Line")
        Right.Visible = false
        Right.Color = cfg.ESP.Color
        Right.Thickness = 2
        Right.Transparency = 1

        local Tracer = Drawing.new("Line")
        Tracer.Visible = false
        Tracer.Color = cfg.ESP.Color
        Tracer.Thickness = 1
        Tracer.Transparency = 1

        self.Components = {
            Up = Up,
            Down = Down,
            Left = Left,
            Right = Right,
            Tracer = Tracer
        }

        getgenv().EspCache.Boxes[plr] = self

        return self
    end

    function espClass:RemoveBox()
        for _, i in self.Components do
            i:Remove()
        end

        if getgenv().EspCache.Boxes[self.plr] then
            getgenv().EspCache.Boxes[self.plr] = nil
        end
    end

    function espClass:HideBox()
        for _, component in self.Components do
            component.Visible = false
        end
    end

    function espClass:ShowBox()
        for name, component in self.Components do
            if name == "Tracer" then
                component.Visible = cfg.Tracer.Enabled
            else
                component.Visible = cfg.ESP.Enabled
            end
        end
    end
end

if cfg.UI then
    local __module = loadstring(
        game:HttpGet("https://raw.githubusercontent.com/qw2n/N-Library/refs/heads/main/Library.Source.lua")
    )()

    local Window = __module:MakeWindow({
        name = "Undetected ESP | v1.1",
        theme = "PurpleAndBlack",
        
        sizeX = 330,
        sizeY = 400,
    })

    do
        local tab = Window:MakeTab({
            Text = "Main"
        })

        do
            local section = tab:MakeSection({
                Text = "ESP",
                Column = 1
            })

            section:MakeToggle({
                Text = "Enabled",
                Flag = cfg.ESP.Enabled,
                callback = function(v: boolean)
                    cfg.ESP.Enabled = v
                end
            })

            section:MakeToggle({
                Text = "Team Check",
                Flag = cfg.ESP.TeamCheck,
                callback = function(v: boolean)
                    cfg.ESP.TeamCheck = v
                end
            })

            section:MakeColorPicker({
                Text = "Color",
                Default = cfg.ESP.Color,

                callback = function(v)
                    cfg.ESP.Color = v
                end
            })
        end

        do
            local section = tab:MakeSection({
                Text = "Tracer",
                Column = 1
            })

            section:MakeToggle({
                Text = "Tracer Enabled",
                Flag = cfg.Tracer.Enabled,

                callback = function(v: boolean)
                    cfg.Tracer.Enabled = v
                end
            })

            section:MakeDropdown({
                Default = cfg.Tracer.Origin,
                Content = {"Bottom", "Middle", "Top", "Cursor"},
                multiChoice = false,

                callback = function(v)
                    cfg.Tracer.Origin = v
                end
            })
        end
    end
end

for _, i in Players:GetPlayers() do
    espClass.new(i)
end

table.insert(getgenv().EspCache.Connections, Players.PlayerRemoving:Connect(function(plr)
    if Owner == plr then return end
    local box = getgenv().EspCache.Boxes[plr]
    if box then box:RemoveBox() end
end))

table.insert(getgenv().EspCache.Connections, Players.PlayerAdded:Connect(espClass.new))

table.insert(getgenv().EspCache.Connections, RunService.RenderStepped:Connect(function()
    local mouse = Owner:GetMouse()
    
    for _, i in Players:GetPlayers() do
        if i == Owner then continue end

        local Box = getgenv().EspCache.Boxes[i]
        if not Box then continue end

        if not cfg.ESP.Enabled and not cfg.Tracer.Enabled then
            Box:HideBox()

            continue
        end

        local Character = i.Character
        if not Character then Box:HideBox() continue end

        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if not RootPart then Box:HideBox() continue end

        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if not Humanoid then Box:HideBox() continue end

        local Head = Character:FindFirstChild("Head")
        if not Head then Box:HideBox() continue end

        if Humanoid.Health < 0 then Box:HideBox() continue end

        if cfg.ESP.TeamCheck and Owner.TeamColor == i.TeamColor then Box:HideBox() continue end

        if Box.__cache.lastColor ~= cfg.ESP.Color then
            Box.__cache.lastColor = cfg.ESP.Color

            for _, i in Box.Components do
                i.Color = cfg.ESP.Color
            end
        end

        local _, OnScreen = camera:WorldToViewportPoint(RootPart.Position)
        if not OnScreen then Box:HideBox() continue end

        do
            local Scale = Head.Size.Y/2
            local Size = Vector3.new(2, 3, 0) * (Scale * 2)

            local TL = camera:WorldToViewportPoint((RootPart.CFrame * CFrame.new(Size.X, Size.Y, 0)).p)
            local TR = camera:WorldToViewportPoint((RootPart.CFrame * CFrame.new(-Size.X, Size.Y, 0)).p)
            local BL = camera:WorldToViewportPoint((RootPart.CFrame * CFrame.new(Size.X, -Size.Y, 0)).p)
            local BR = camera:WorldToViewportPoint((RootPart.CFrame * CFrame.new(-Size.X, -Size.Y, 0)).p)

            if cfg.ESP.Enabled then
                Box.Components.Up.From = Vector2.new(TL.X, TL.Y)
                Box.Components.Up.To = Vector2.new(TR.X, TR.Y)

                Box.Components.Left.From = Vector2.new(TL.X, TL.Y)
                Box.Components.Left.To = Vector2.new(BL.X, BL.Y)

                Box.Components.Right.From = Vector2.new(TR.X, TR.Y)
                Box.Components.Right.To = Vector2.new(BR.X, BR.Y)

                Box.Components.Down.From = Vector2.new(BL.X, BL.Y)
                Box.Components.Down.To = Vector2.new(BR.X, BR.Y) 
            end

            if cfg.Tracer.Enabled then
                local tracerOrigin, tracerEnd = nil, nil

                tracerEnd = Vector2.new(
                    (BL.X + BR.X) / 2,
                    (BL.Y + BR.Y) / 2
                )

                if cfg.Tracer.Origin == "Bottom" then
                    tracerOrigin = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)

                elseif cfg.Tracer.Origin == "Middle" then
                    tracerOrigin = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

                elseif cfg.Tracer.Origin == "Top" then
                    tracerOrigin = Vector2.new(camera.ViewportSize.X/2, 0)

                elseif cfg.Tracer.Origin == "Cursor" then
                    tracerOrigin = Vector2.new(mouse.X, mouse.Y + 36)
                end

                Box.Components.Tracer.From = tracerOrigin
                Box.Components.Tracer.To = tracerEnd
            end
        end

        Box:ShowBox()
    end
end))

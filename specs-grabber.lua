-- Pretty ugly code by engo#0320 and chinese long name#9053

local name
local specs = {}

local VirtualInputManager = game:GetService('VirtualInputManager')
local ScreenshotReadyConnection; ScreenshotReadyConnection = game.ScreenshotReady:Connect(function(patha)
    name = patha:split("\\")[3]
    ScreenshotReadyConnection:Disconnect()
end)
local DeleteScreenshotNotificationConenction; DeleteScreenshotNotificationConenction = game:GetService("CoreGui").RobloxGui.NotificationFrame.ChildAdded:Connect(function(v)
    if v and v:FindFirstChild("Button1") and v.Button1.Text:find("Open Folder") then
        v:Destroy()
        DeleteScreenshotNotificationConenction:Disconnect()
    end
end)
VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Print, false, game)
VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Print, false, game)

local function hex_to_char(x)
    return string.char(tonumber(x, 16))
end
  
local function unescape(url)
    return url:gsub("%%(%x%x)", hex_to_char)
end

for i,v in next, game:GetService("LogService"):GetHttpResultHistory() do
    local url = unescape(v.URL)
    if url:find("https://ecsv2.roblox.com/pe") then 
        pcall(function() -- what on earth have i created here
            print(url)
            local cpu = url:split("cpu=")[2]:split("placeid=")[1]:split("  ")[1]
            specs.cpu = cpu
            local gpu = url:split("gpu_info=")[2]:split("&gpu_memMB=vid: ")
            local gpu_mem = gpu[2]:split(" sys")[1]
            gpu = gpu[1]
            specs.gpu = gpu..(" (%s MB VRAM)"):format(gpu_mem)
            local os = url:split("os=")[2]:split("/")[1]
            specs.os = os
            local memt = url:split("memMB=")[3]:split("&avgPing=")
            local mem = memt[1]
            specs.memory = mem
        end)
    end
end

repeat task.wait() until name ~= nil
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Hello, "..name,
    Text = "Do u like my spec grabber?",
    Duration = 4
})
repeat task.wait() until specs.memory
for i,v in next, specs do
    task.wait(4)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Hello, "..name,
        Text = i..": "..v,
        Duration = 4
    })
end

-- Script Thông Báo Full Moon Qua Webhook
-- Hãy thay 'YOUR_WEBHOOK_URL' bằng URL webhook Discord của bạn.

local httpService = game:GetService("HttpService")

-- Cấu hình
local webhookURL = "https://discord.com/api/webhooks/1320750531693645855/KtMO2C-qmdVUyNnqPlogvFXdIvrRom2LjNJDHi_8joY-xGxQFZtyKMZDyRfodwQPc-Zl"
local moonStatus = "Full Moon" -- Trạng thái trăng
local playerCount = #game.Players:GetPlayers() -- Đếm số người chơi
local jobId = game.JobId -- Job ID hiện tại
local placeId = game.PlaceId -- Place ID hiện tại

-- Tạo script dịch chuyển
local joinScriptTemplate = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game:GetService("Players").LocalPlayer)',
    placeId, jobId
)

-- Tạo payload gửi qua webhook
local payload = {
    ["embeds"] = {{
        ["title"] = "Thông Báo Full Moon | Khoitongdz",
        ["color"] = 16711680, -- Màu đỏ
        ["fields"] = {
            {["name"] = "Trạng Thái Trăng", ["value"] = moonStatus, ["inline"] = true},
            {["name"] = "Số Người Chơi", ["value"] = tostring(playerCount), ["inline"] = true},
            {["name"] = "Job ID", ["value"] = jobId, ["inline"] = false},
            {["name"] = "Script Dịch Chuyển", ["value"] = string.format("```lua\n%s\n```", joinScriptTemplate), ["inline"] = false}
        },
        ["footer"] = {
            ["text"] = "Full Moon Notifier",
            ["icon_url"] = "https://images-ext-1.discordapp.net/external/QKfBrLEqr4HicNoOEDr3vg8g5uuoBCdb3n_ENYSY1Uc/https/cdn.nekotina.com/images/L06x1IO7L.jpg?format=webp&width=312&height=416" -- Tùy chọn: Thêm icon
        }
    }}
}

-- Gửi dữ liệu qua webhook
local success, err = pcall(function()
    httpService:PostAsync(webhookURL, httpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
end)

if success then
    print("Gửi thông báo thành công.")
else
    warn("Không thể gửi thông báo: " .. err)
end

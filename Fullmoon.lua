-- Script Tự Động Thông Báo Full Moon
local httpService = game:GetService("HttpService")

-- Cấu hình webhook
local webhookURL = "https://discord.com/api/webhooks/1320750531693645855/KtMO2C-qmdVUyNnqPlogvFXdIvrRom2LjNJDHi_8joY-xGxQFZtyKMZDyRfodwQPc-Zl"

-- Lấy thông tin từ game
local moonStatus = "Full Moon" -- Giả định trạng thái là Full Moon (tùy chỉnh nếu cần logic kiểm tra)
local playerCount = #game.Players:GetPlayers() -- Đếm số lượng người chơi
local jobId = game.JobId -- Lấy Job ID hiện tại
local placeId = game.PlaceId -- Lấy Place ID hiện tại

-- Tạo script dịch chuyển
local joinScriptTemplate = string.format(
    'game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game:GetService("Players").LocalPlayer)',
    placeId, jobId
)

-- Tạo payload gửi qua webhook
local payload = {
    ["embeds"] = {{
        ["title"] = "Thông Báo Full Moon|Khoitongdz",
        ["color"] = 16711680, -- Màu đỏ
        ["fields"] = {
            {["name"] = "Trạng Thái Trăng", ["value"] = moonStatus, ["inline"] = true},
            {["name"] = "Số Người Chơi", ["value"] = tostring(playerCount), ["inline"] = true},
            {["name"] = "Job ID", ["value"] = jobId, ["inline"] = false},
            {["name"] = "Script Dịch Chuyển", ["value"] = string.format("```lua\n%s\n```", joinScriptTemplate), ["inline"] = false}
        },
        ["footer"] = {
            ["text"] = "Full Moon Notifier | Auto",
            ["icon_url"] = "https://images-ext-1.discordapp.net/external/QKfBrLEqr4HicNoOEDr3vg8g5uuoBCdb3n_ENYSY1Uc/https/cdn.nekotina.com/images/L06x1IO7L.jpg?format=webp&width=312&height=416"
        }
    }}
}

-- Gửi thông báo qua webhook
local function sendNotification()
    local success, err = pcall(function()
        httpService:PostAsync(webhookURL, httpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)

    if success then
        print("Thông báo Full Moon đã được gửi!")
    else
        warn("Lỗi khi gửi thông báo: " .. tostring(err))
    end
end

-- Tự động gửi thông báo ngay khi script được executor
sendNotification()

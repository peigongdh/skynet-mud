---
--- Created by zhangpei-home.
--- DateTime: 2017/9/25 21:31
---

local skynet = require("skynet")
-- local httpc = require("http.httpc")
local logger = require("logger")
local cjson = require("cjson")
local string_utils = require("string_utils")

local auth_protocol = skynet.getenv("auth_protocol")
local auth_host = skynet.getenv("auth_host")
local auth_url = skynet.getenv("auth_url")

local auth = {}

function auth.skynet_mud(platform, token)
    local uid = nil
    local username = nil

    local recvheader = {}
    local postfields = {
        platform = platform,
        token = token
    }

    logger.debug("auth", "webclient start", auth_protocol .. auth_host .. auth_url)
    -- local ok, status, body = pcall(httpc.post, auth_host, auth_url, postfields, recvheader)
    local webclient = skynet.uniqueservice("webclient")
    local ok, body = skynet.call(webclient, "lua", "request", auth_protocol .. auth_host .. auth_url, nil, postfields, false)
    logger.debug("auth", "webclient end")
    logger.debug("auth", string_utils.dump(body))

    if ok then
        local resp = cjson.decode(body)
        logger.debug("auth", string_utils.dump(body))
        if resp.status == "success" then
            uid = resp.data.id
            username = resp.data.name
        end
    end

    return uid, username
end

return auth
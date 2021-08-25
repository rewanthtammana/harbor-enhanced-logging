local _M = {}

function _M.fetch(red, key)

    if key == nil or key == "" then
        -- return "Empty key/unauthenticated user"
        return 
    end

    red:set_timeouts(1000, 1000, 1000)

    local command = "nslookup redis"
    local output = io.popen(command):read("*a")

    local result = string.match(output, "Address: ([.0-9]+)")

    local ok, err = red:connect(result, 6379)
    if not ok then
        return "Failed to connect: " .. tostring(err)
    end

    local res, err = red:get(key)
    if not res then
        return "No response for key: " .. tostring(key) .. " Error: " .. tostring(err)
    end

    if res == ngx.null then
        return "No data found for key " .. tostring(key)
    end

    local pattern = "[a-zA-Z0-9]*@gmail.com"
    email = string.match(res, pattern)

    if email == nil then
        -- return "No match for given pattern " .. tostring(key)
        return 
    end

    return email
end

return _M


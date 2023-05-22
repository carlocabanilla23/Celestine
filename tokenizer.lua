local token_patterns = {
    -- Operations
    {"%+","ADD"},
    {"%-","SUBTRACT"},
    {"%/","DIVIDE"},
    {"%*","MULTIPLY"},
    {"%=","ASSIGN"},

    -- clauses
    {"%(","L_PAREN"},
    {"%)","R_PAREN"},

    -- numbers
    {"%d+.%d+","DOUBLE"},
    {"%d+","NUM"},
    
    -- Funtions
    {"print%s*","PRINT"},

    
    -- Others
    {"%a%w*", "IDENT"},
    {"%s+", nil},
    {".", "INVALID"}

 
}

local function tokenize_input(input)
    tokens = {}
    while #input > 0 do
        local match = false
        for _,token in ipairs(token_patterns) do
            local token_str, token_type = table.unpack(token)
            local s, e = string.find(input, token_str)

            if s == 1 then
                if token_type then
                    table.insert(
                        tokens, { 
                            type = token_type, 
                            value = string.sub(input, s, e)})
                end
                input = string.sub(input, e + 1)
                match = true
                break
            end
        end
        if not match then
            error("Invalid token: " .. string.sub(input, 1, 1))
        end
    end
    return tokens
end

return {tokenize_input = tokenize_input}
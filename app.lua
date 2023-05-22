local tokenize = require("tokenizer")
local parse = require('parser')

-- Read in the contents of a file
local file = io.open("test.txt", "r")
local input = file:read("*all")
file:close()

-- Tokenize the input

local tokens = tokenize.tokenize_input(input)
local parse = parse.parse(tokens)



-- for _,p in ipairs(parse) do
--     print(p)
-- end
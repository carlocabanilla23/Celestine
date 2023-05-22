
function parse_term(tokens)
    local factor = parse_factor(tokens)

    while tokens[1] and (tokens[1].value == "*" or tokens[1].value == "/") do
        local operator = tokens[1].value
        table.remove(tokens, 1) -- Consume the operator token
        local next_factor = parse_factor(tokens)
        factor = { type = "term", left = factor, operator = operator, right = next_factor }
    end

    return factor
end

 function parse_factor(tokens)
    local token = tokens[1]
    if token.type == "IDENT" or token.type == "NUM" or token.type == "DOUBLE" then
        table.remove(tokens, 1) -- Consume the token
        return { type = "factor", value = token.value }
    elseif token.type == "L_PAREN" then
        table.remove(tokens, 1) -- Consume the '(' token
        local expression = parse_expression(tokens)
        if tokens[1].type == "R_PAREN" then
            table.remove(tokens, 1) -- Consume the ')' token
            return { type = "factor", expression = expression }
        else
            error("Expected ')' after expression")
        end
    else
        error("Invalid factor")
    end
end

local function parse_expression(tokens)
    local term = parse_term(tokens)

    while tokens[1] and (tokens[1].value == "+" or tokens[1].value == "-") do
        local operator = tokens[1].value
        table.remove(tokens, 1) -- Consume the operator token
        local next_term = parse_term(tokens)
        term = { type = "expression", left = term, operator = operator, right = next_term }
    end

    return term
end

local function parse_identifier(tokens)
    local token = tokens[1]
    if token.type == "IDENT" then
        table.remove(tokens, 1) -- Consume the identifier token
        return { type = "identifier", value = token.value }
    else
        error("Expected identifier")
    end
end

local function parse_print_statement(tokens)
    if tokens[1].type == "PRINT" then
        table.remove(tokens, 1) -- Consume the 'print' token
        if tokens[1].type == "L_PAREN" then
            table.remove(tokens, 1) -- Consume the '(' token
            local expression = parse_expression(tokens)
            if tokens[1].type == "R_PAREN" then
                table.remove(tokens, 1) -- Consume the ')' token
            else
                error("Expected ')' after expression")
            end
        else
            error("Expected '(' after 'print'")
        end
    else
        error("Expected 'print' keyword")
    end
end

local function parse_assignment_statement(tokens)
    local identifier = parse_identifier(tokens)
    if tokens[1].type == "ASSIGN" then
        table.remove(tokens, 1) -- Consume the '=' token
        local expression = parse_expression(tokens)
        return { type = "assignment_statement", identifier = identifier, expression = expression }
    else
        error("Expected '=' after identifier")
    end
end

local function parse_statement(tokens)
    if tokens[1].type == "IDENT" then
        return parse_assignment_statement(tokens)
    elseif tokens[1].type == "PRINT" then
        return parse_print_statement(tokens)
    else
        error("Invalid statement")
    end
end

local function parse_statement_list(tokens)
    local statements = {}
    while #tokens > 0 do
        table.insert(statements, parse_statement(tokens))
    end
    return { type = "statement_list", statements = statements }
end

local function parse_program(tokens)
    return parse_statement_list(tokens)
end

local function parse(tokens)
    return parse_program(tokens)
end

return { parse = parse }

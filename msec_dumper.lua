--// Made by mistercoolertyper#6969 | all credits to him.

local function dump(script, options)
    options = options or {}
    for i,v in next, options do
        if tostring(i):lower():find("file") then
            options.save_file = tostring(v)
        end
    end
    local split = script:split(";")
    for i,v in next, split do
        if v:find("while true do") and v:find("%[") and v:find("%]") and not v:find("function") and not v:find("return") and not v:find("break") and not v:find("'") and not v:find('"') then
            local var = v:split("=")[2]:gsub("%[", ""):gsub("%]", ""):split("")[1]
            print(var)
            split[i-1] = split[i-1].."\n;local gotten = {}"
            if options.save_file then
                writefile(options.save_file, "")
                split[i] = split[i].."; local function newunpack(tbl) if type(tbl) ~= 'table' then return tbl end local newstr = ''; for i,v in next, tbl do newstr = newstr..' '..tostring(v) end return newstr end; for i,v in next, "..var.." do if not table.find(gotten, v) then table.insert(gotten, v) print(i, '==>', newunpack(v)) appendfile('"..options.save_file.."', i..' ==> '..newunpack(v)..'\\n') end end"
            else
                split[i] = split[i].."; local function newunpack(tbl) if type(tbl) ~= 'table' then return tbl end local newstr = ''; for i,v in next, tbl do newstr = newstr..' '..tostring(v) end return newstr end; for i,v in next, "..var.." do if not table.find(gotten, v) then table.insert(gotten, v) print(i, '==>', newunpack(v)) end end" 
            end
        end
    end
    if options.copy then
        setclipboard(table.concat(split, ";"):gsub("\n", ""))
    end
    loadstring(table.concat(split, ";"):gsub("\n", ""))()
end

getgenv().dumpmsec = dump

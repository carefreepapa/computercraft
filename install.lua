print("installing computercraft scripts")

local git_repo = "https://raw.githubusercontent.com/carefreepapa/computercraft/main/"
local files = {
    "constants.lua",
    "vector.lua",
    "turtle.lua",
}

for i = 1, #files do
    shell.run("wget", git_repo .. files[i])
end

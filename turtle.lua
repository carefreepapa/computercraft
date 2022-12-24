local constants = require("constants")
local Direction = constants.Direction
local Vector = require("vector")

local Turtle = {}

local self = {
    forward  = Vector.FORWARD(),
    position = Vector.ZERO(),
}

function Turtle.turn_left()
    if not turtle.turnLeft() then return false end
    local x = self.forward.x
    self.forward.x = -self.forward.z
    self.forward.z = x
    return true
end

function Turtle.turn_right()
    if not turtle.turnRight() then return false end
    local x = self.forward.x
    self.forward.x = self.forward.z
    self.forward.z = -x
    return true
end

function Turtle.turn_around()
    return Turtle.turn_left() and Turtle.turn_left()
end

function Turtle.turn(direction)
    if direction == Direction.LEFT then
        return Turtle.turn_left()
    elseif direction == Direction.RIGHT then
        return Turtle.turn_right()
    elseif direction == Direction.BACKWARD then
        return Turtle.turn_around()
    elseif direction == Direction.FORWARD then
        return true
    else
        print("Tried to turn in a direction which was not LEFT, RIGHT, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.move_forward()
    if turtle.forward() then
        self.position = self.position + self.forward
        return true
    end
    return false
end

function Turtle.move_backward()
    if turtle.back() then
        self.position = self.position - self.forward
        return true
    end
    return false
end

function Turtle.move_up()
    if turtle.up() then
        self.position = self.position + Vector.UP()
        return true
    end
    return false
end

function Turtle.move_down()
    if turtle.down() then
        self.position = self.position + Vector.DOWN()
        return true
    end
    return false
end

function Turtle.move(direction)
    if direction == Direction.DOWN then
        return Turtle.move_down()
    elseif direction == Direction.UP then
        return Turtle.move_up()
    elseif direction == Direction.BACKWARD then
        return Turtle.move_backward()
    elseif direction == Direction.FORWARD then
        return Turtle.move_forward()
    else
        print("Tried to move in a direction which was not DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.turn_and_move(direction)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        return Turtle.turn(direction) and Turtle.move_forward()
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        return Turtle.move(direction)
    else
        print("Tried to turn and move in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

Turtle.select            = turtle.select
Turtle.get_selected_slot = turtle.getSelectedSlot
Turtle.get_item_count    = turtle.getItemCount
Turtle.get_item_space    = turtle.getItemSpace
Turtle.get_item_detail   = turtle.getItemDetail
Turtle.equip_left        = turtle.equipLeft
Turtle.equip_right       = turtle.equipRight
Turtle.attack_forward    = turtle.attack
Turtle.attack_up         = turtle.attackUp
Turtle.attack_down       = turtle.attackDown

Turtle.place_forward   = turtle.place
Turtle.place_up        = turtle.placeUp
Turtle.place_down      = turtle.placeDown
--Turtle.detect          = turtle.detect
Turtle.detect_forward  = turtle.detect
Turtle.detect_up       = turtle.detectUp
Turtle.detect_down     = turtle.detectDown
Turtle.inspect_forward = turtle.inspect
Turtle.inspect_up      = turtle.inspectUp
Turtle.inspect_down    = turtle.inspectDown
Turtle.compare_forward = turtle.compare
Turtle.compare_up      = turtle.compareUp
Turtle.compare_down    = turtle.compareDown
Turtle.drop_forward    = turtle.drop
Turtle.drop_up         = turtle.dropUp
Turtle.drop_down       = turtle.dropDown
Turtle.suck_forward    = turtle.suck
Turtle.suck_up         = turtle.suckUp
Turtle.suck_down       = turtle.suckDown
Turtle.refuel          = turtle.refuel
Turtle.get_fuel_level  = turtle.getFuelLevel
Turtle.get_fuel_limit  = turtle.getFuelLimit
Turtle.transfer_to     = turtle.transferTo

function Turtle.detect(direction)
    if direction == Direction.DOWN then
        return Turtle.detect_down()
    elseif direction == Direction.UP then
        return Turtle.detect_up()
    elseif direction == Direction.FORWARD then
        return Turtle.detect_forward()
    else
        print("Tried to detect in a direction which was not DOWN, UP, or FORWARD")
        return false
    end
end

function Turtle.inspect(direction)
    if direction == Direction.DOWN then
        return Turtle.inspect_down()
    elseif direction == Direction.UP then
        return Turtle.inspect_up()
    elseif direction == Direction.FORWARD then
        return Turtle.inspect_forward()
    else
        print("Tried to inspect in a direction which was not DOWN, UP, or FORWARD")
        return false
    end
end

function Turtle.dig_forward(tool_side)
    return Turtle.detect_forward() and turtle.dig(tool_side)
end

function Turtle.dig_up(tool_side)
    return Turtle.detect_up() and turtle.digUp(tool_side)
end

function Turtle.dig_down(tool_side)
    return Turtle.detect_down() and turtle.digDown(tool_side)
end

function Turtle.dig(direction, tool_side)
    if direction == Direction.DOWN then
        return Turtle.dig_down(tool_side)
    elseif direction == Direction.UP then
        return Turtle.dig_up(tool_side)
    elseif direction == Direction.FORWARD then
        return Turtle.dig_forward(tool_side)
    else
        print("Tried to dig in a direction which was not DOWN, UP, or FORWARD")
        return false
    end
end

function Turtle.turn_and_detect(direction)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        return Turtle.turn(direction) and Turtle.detect(direction)
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        return Turtle.detect(direction)
    else
        print("Tried to turn and detect in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.turn_and_dig(direction, tool_side)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        return Turtle.turn(direction) and Turtle.dig_forward()
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        return Turtle.dig(direction)
    else
        print("Tried to turn and dig in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.dig_and_move(direction, tool_side)
    if direction == Direction.DOWN
        or direction == Direction.UP
        or direction == Direction.FORWARD then
        return Turtle.dig(direction, tool_side) and Turtle.move(direction)
    else
        print("Tried to dig and move in a direction which was not DOWN, UP, or FORWARD")
        return false
    end
end

function Turtle.turn_dig_move(direction, tool_side)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        Turtle.turn(direction)
        Turtle.dig_forward()
        return Turtle.move_forward()
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        Turtle.dig(direction)
        return Turtle.move(direction)
    else
        print("Tried to turn, dig, then move in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.dig_until_clear(direction, tool_side)
    Turtle.dig(direction, tool_side)
    if Turtle.detect(direction) then
        while Turtle.dig(direction, tool_side) do
            os.sleep(0.05)
        end
    end
    return true
end

function Turtle.clear_move(direction, tool_side)
    Turtle.dig_until_clear(direction, tool_side)
    return Turtle.move(direction)
    --Turtle.dig_until_clear(direction, tool_side)
    --while not Turtle.move(direction) do
    --    Turtle.dig_until_clear(direction, tool_side)
    --end
end

function Turtle.turn_clear_move(direction, tool_side)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        Turtle.turn(direction)
        Turtle.dig_until_clear(Direction.FORWARD, tool_side)
        return Turtle.move_forward()
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        Turtle.dig_until_clear(direction, tool_side)
        return Turtle.move(direction)
    else
        print("Tried to turn, clear, then move in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end
end

function Turtle.turn_detect_clear_move(direction, tool_side)
    if direction == Direction.LEFT
        or direction == Direction.RIGHT
        or direction == Direction.BACKWARD
        or direction == Direction.FORWARD then
        Turtle.turn(direction)
        if Turtle.detect_forward() then
            Turtle.dig_until_clear(Direction.FORWARD, tool_side)
            return Turtle.move_forward()
        else
            return false
        end
    elseif direction == Direction.DOWN
        or direction == Direction.UP then
        if Turtle.detect(direction) then
            Turtle.dig_until_clear(direction, tool_side)
            return Turtle.move(direction)
        else
            return false
        end
    else
        print("Tried to turn, detect, clear, then move in a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return false
    end

end

local function get_relative_position(direction)
    if direction == Direction.LEFT then
        return self.position + vector.new(self.forward.z, 0, -self.forward.x)
    elseif direction == Direction.RIGHT then
        return self.position + vector.new(-self.forward.z, 0, self.forward.x)
    elseif direction == Direction.DOWN then
        return self.position + Vector.DOWN()
    elseif direction == Direction.UP then
        return self.position + Vector.UP()
    elseif direction == Direction.FORWARD then
        return self.position + self.forward
    elseif direction == Direction.BACKWARD then
        return self.position - self.forward
    end
end

function Turtle.dig_vein(blocks_to_mine, max_depth, tool_side)

    max_depth     = max_depth or 8
    local visited = {}

    local dig_vein_inner
    local dig_vein_helper

    dig_vein_inner = function(direction, depth)
        if depth > max_depth then return false end

        local position = get_relative_position(direction)
        local position_string = position:tostring()

        if visited[position_string] == nil then
            visited[position_string] = true

            local success, data = Turtle.inspect(direction)
            if success
                and blocks_to_mine[data.name] ~= nil
                and Turtle.dig_until_clear(direction, tool_side)
                and Turtle.move(direction) then

                dig_vein_helper(depth)

                if direction == Direction.DOWN then
                    Turtle.clear_move(Direction.UP, tool_side)
                elseif direction == Direction.UP then
                    Turtle.clear_move(Direction.DOWN, tool_side)
                elseif direction == Direction.FORWARD then
                    if not Turtle.move_backward() then
                        Turtle.turn_around()
                        Turtle.clear_move(Direction.FORWARD, tool_side)
                        Turtle.turn_around()
                    end
                end
                return true
            else
                return false
            end
        else
            return false
        end
    end

    dig_vein_helper = function(depth)
        dig_vein_inner(Direction.UP, depth + 1)
        Turtle.turn_left()
        dig_vein_inner(Direction.FORWARD, depth + 1)
        Turtle.turn_left()
        dig_vein_inner(Direction.FORWARD, depth + 1)
        Turtle.turn_left()
        dig_vein_inner(Direction.FORWARD, depth + 1)
        Turtle.turn_left()
        dig_vein_inner(Direction.FORWARD, depth + 1)
        dig_vein_inner(Direction.DOWN, depth + 1)

        return true
    end

    return dig_vein_helper(0)
end

function Turtle.dig_shaft_and_veins(direction, blocks_to_mine, max_depth, tool_side)

    local depth = 0
    max_depth = max_depth or 16
    local hit_bottom = false

    if direction == Direction.LEFT
        or direction == Direction.RIGHT then
        Turtle.turn(direction)
        direction = Direction.FORWARD
    end

    while depth < max_depth and not hit_bottom do
        Turtle.dig_vein(blocks_to_mine, tool_side)
        if depth < max_depth then
            if not Turtle.clear_move(direction, tool_side) then
                hit_bottom = true
            else
                depth = depth + 1
            end
        end
    end
end

function Turtle.dig_shafts(shafts, blocks_to_mine, tool_side)

    if shafts.x <= 0 then print("invalid x value") return false end
    if shafts.y <= 0 then print("invalid y value") return false end
    if shafts.z <= 0 then print("invalid z value") return false end

    local going_down = shafts.y < 0
    if going_down then shafts.y = -shafts.y end

    for y = 1, shafts.y do
        for x = 1, shafts.x do

            Turtle.dig_shaft_and_veins(Direction.FORWARD, blocks_to_mine, shafts.z, tool_side)

            if x < shafts.x then
                if x % 2 == y % 2 then
                    Turtle.turn_left()
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.turn_left()
                else
                    Turtle.turn_right()
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.clear_move(Direction.FORWARD, tool_side)
                    Turtle.turn_right()
                end
            end
        end

        if y < shafts.y then
            local direction
            if going_down then
                direction = Direction.DOWN
            else
                direction = Direction.UP
            end
            Turtle.clear_move(direction, tool_side)
            Turtle.clear_move(direction, tool_side)
            Turtle.clear_move(direction, tool_side)
            Turtle.turn_around()
        end
    end
end

return Turtle

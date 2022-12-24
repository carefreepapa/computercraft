--- A basic 3D vector type and some common vector operations. This may be useful
-- when working with coordinates in Minecraft's world (such as those from the
-- @{gps} API).
--
-- An introduction to vectors can be found on [Wikipedia][wiki].
--
-- [wiki]: http://en.wikipedia.org/wiki/Euclidean_vector
--
-- @module vector
-- @since 1.31
--
-- NOTE: Hijacked by Smits_

--- A 3-dimensional vector, with `x`, `y`, and `z` values.
--
-- This is suitable for representing both position and directional vectors.
--
-- @type Vector
local Vector = {}

--- Adds two vectors together.
--
-- @tparam Vector self The first vector to add.
-- @tparam Vector o The second vector to add.
-- @treturn Vector The resulting vector
-- @usage v1:add(v2)
-- @usage v1 + v2
function Vector.add(self, o)
    return Vector.new(
        self.x + o.x,
        self.y + o.y,
        self.z + o.z
    )
end

--- Subtracts one vector from another.
--
-- @tparam Vector self The vector to subtract from.
-- @tparam Vector o The vector to subtract.
-- @treturn Vector The resulting vector
-- @usage v1:sub(v2)
-- @usage v1 - v2
function Vector.sub(self, o)
    return Vector.new(
        self.x - o.x,
        self.y - o.y,
        self.z - o.z
    )
end

--- Multiplies a vector by a scalar value.
--
-- @tparam Vector self The vector to multiply.
-- @tparam number m The scalar value to multiply with.
-- @treturn Vector A vector with value `(x * m, y * m, z * m)`.
-- @usage v:mul(3)
-- @usage v * 3
function Vector.mul(self, m)
    return Vector.new(
        self.x * m,
        self.y * m,
        self.z * m
    )
end

--- Divides a vector by a scalar value.
--
-- @tparam Vector self The vector to divide.
-- @tparam number m The scalar value to divide by.
-- @treturn Vector A vector with value `(x / m, y / m, z / m)`.
-- @usage v:div(3)
-- @usage v / 3
function Vector.div(self, m)
    return Vector.new(
        self.x / m,
        self.y / m,
        self.z / m
    )
end

--- Negate a vector
--
-- @tparam Vector self The vector to negate.
-- @treturn Vector The negated vector.
-- @usage -v
function Vector.unm(self)
    return Vector.new(
        -self.x,
        -self.y,
        -self.z
    )
end

--- Compute the dot product of two vectors
--
-- @tparam Vector self The first vector to compute the dot product of.
-- @tparam Vector o The second vector to compute the dot product of.
-- @treturn Vector The dot product of `self` and `o`.
-- @usage v1:dot(v2)
function Vector.dot(self, o)
    return self.x * o.x + self.y * o.y + self.z * o.z
end

--- Compute the cross product of two vectors
--
-- @tparam Vector self The first vector to compute the cross product of.
-- @tparam Vector o The second vector to compute the cross product of.
-- @treturn Vector The cross product of `self` and `o`.
-- @usage v1:cross(v2)
function Vector.cross(self, o)
    return Vector.new(
        self.y * o.z - self.z * o.y,
        self.z * o.x - self.x * o.z,
        self.x * o.y - self.y * o.x
    )
end

--- Get the length (also referred to as magnitude) of this vector.
-- @tparam Vector self This vector.
-- @treturn number The length of this vector.
function Vector.length(self)
    return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

--- Divide this vector by its length, producing with the same direction, but
-- of length 1.
--
-- @tparam Vector self The vector to normalise
-- @treturn Vector The normalised vector
-- @usage v:normalize()
function Vector.normalize(self)
    return self:mul(1 / self:length())
end

--- Construct a vector with each dimension rounded to the nearest value.
--
-- @tparam Vector self The vector to round
-- @tparam[opt] number tolerance The tolerance that we should round to,
-- defaulting to 1. For instance, a tolerance of 0.5 will round to the
-- nearest 0.5.
-- @treturn Vector The rounded vector.
function Vector.round(self, tolerance)
    tolerance = tolerance or 1.0
    return Vector.new(
        math.floor((self.x + tolerance * 0.5) / tolerance) * tolerance,
        math.floor((self.y + tolerance * 0.5) / tolerance) * tolerance,
        math.floor((self.z + tolerance * 0.5) / tolerance) * tolerance
    )
end

--- Convert this vector into a string, for pretty printing.
--
-- @tparam Vector self This vector.
-- @treturn string This vector's string representation.
-- @usage v:tostring()
-- @usage tostring(v)
function Vector.tostring(self)
    return self.x .. "," .. self.y .. "," .. self.z
end

--- Check for equality between two vectors.
--
-- @tparam Vector self The first vector to compare.
-- @tparam Vector other The second vector to compare to.
-- @treturn boolean Whether or not the vectors are equal.
function Vector.equals(self, other)
    return self.x == other.x and self.y == other.y and self.z == other.z
end


local vmetatable = {
    __index = Vector,
    __add = Vector.add,
    __sub = Vector.sub,
    __mul = Vector.mul,
    __div = Vector.div,
    __unm = Vector.unm,
    __tostring = Vector.tostring,
    __eq = Vector.equals,
}

--- Construct a new @{Vector} with the given coordinates.
--
-- @tparam number x The X coordinate or direction of the vector.
-- @tparam number y The Y coordinate or direction of the vector.
-- @tparam number z The Z coordinate or direction of the vector.
-- @treturn Vector The constructed vector.
function Vector.new(x, y, z)
    return setmetatable({
        x = tonumber(x) or 0,
        y = tonumber(y) or 0,
        z = tonumber(z) or 0,
    }, vmetatable)
end

function Vector.ZERO()     return Vector.new(0, 0, 0)  end
function Vector.ONE()      return Vector.new(1, 1, 1)  end
function Vector.LEFT()     return Vector.new(-1, 0, 0) end
function Vector.RIGHT()    return Vector.new(1, 0, 0)  end
function Vector.DOWN()     return Vector.new(0, -1, 0) end
function Vector.UP()       return Vector.new(0, 1, 0)  end
function Vector.BACKWARD() return Vector.new(0, 0, -1) end
function Vector.FORWARD()  return Vector.new(0, 0, 1)  end

local Direction = require("constants").Direction
function Vector.from_direction(direction)
    if direction == Direction.LEFT then
        return Vector.LEFT()
    elseif direction == Direction.RIGHT then
        return Vector.RIGHT()
    elseif direction == Direction.DOWN then
        return Vector.DOWN()
    elseif direction == Direction.UP then
        return Vector.UP()
    elseif direction == Direction.BACKWARD then
        return Vector.BACKWARD()
    elseif direction == Direction.FORWARD then
        return Vector.FORWARD()
    else
        print("Tried to get a vector for a direction which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return nil
    end
end

function Vector.to_direction(self)
    if self == Vector.LEFT() then
        return Direction.LEFT
    elseif self == Vector.RIGHT() then
        return Direction.RIGHT
    elseif self == Vector.DOWN() then
        return Direction.DOWN
    elseif self == Vector.UP() then
        return Direction.UP
    elseif self == Vector.BACKWARD() then
        return Direction.BACKWARD
    elseif self == Vector.FORWARD() then
        return Direction.FORWARD
    else
        print("Tried to get a direction for a vector which was not LEFT, RIGHT, DOWN, UP, BACKWARD, or FORWARD")
        return nil
    end
end

return Vector

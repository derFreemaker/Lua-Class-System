---@type class-system
local ClassSystem = require("ClassSystem")

---@class test-class.interface
local test_interface = {}

function test_interface:foo()
end
test_interface.foo = ClassSystem.is_interface

---@type integer
test_interface.foo_value = ClassSystem.is_interface

interface("interface", test_interface)
-- If IsInterface is not set in options, will throw an error since not interfaces has interface members.
-- Also as you might notice all classes have `object` as base class interfaces don't.

local instance = test_interface()
-- Will throw an error since interfaces cannot be constructed

----------------------------------------------------------------
-- using interface class as base class
----------------------------------------------------------------

-- have to inherit `object` as well since test-class.interface is only a interface

---@class test-class : object, test-class.interface
---@overload fun() : test-class
local test_class = {}

---@private
function test_class:__init()
    print("constructor")
end

function test_class:foo()
    print("foo")
end

-- Has to implement foo since its inherited this interface member
-- If not will throw an error at class_system.create

test_class.foo_value = 100
-- Has to implement fooValue since its inherited this interface member
-- If not will throw an error at class_system.create

class("test-class", test_class, { inherit = test_interface })
-- Inherit can have an table with multiple interfaces and one base class set in form of an array.
-- If not all interface members are implemented an error will occur.

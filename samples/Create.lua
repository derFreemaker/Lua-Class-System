---@type Freemaker.ClassSystem
local ClassSystem = require("ClassSystem")

---@class TestClass.Create : object
---@overload fun() : TestClass.Create
local testClass = {}

---@private
function testClass:__init()
    print("constructor")
end

function testClass:foo()
    print("foo")
end

testClass.fooValue = 100

class("Class Name", testClass)
-- does the same class global function just makes it more pretty
-- ClassSystem.Create(class, { Name = "Class Name" })

local instance = testClass()
-- Triggers class:__init with self being set with all members added.

instance:foo()

local val = instance.fooValue

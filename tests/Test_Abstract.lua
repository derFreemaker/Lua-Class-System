local luaunit = require("tests.Luaunit")

local ClassSystem = require("src.init")

function TestCreateAbstractClass()
    local testClass = {}

    function testClass:foo()
    end

    testClass.foo = ClassSystem.IsAbstract

    ClassSystem.Create(testClass, { Name = "testClass", IsAbstract = true })

    luaunit.assertErrorMsgContains("cannot construct abstract class", testClass)
end

function TestCreateClassWithAbstractClassAsBase()
    local abstractTestClass = {}
    function abstractTestClass:foo()
    end

    abstractTestClass.foo = ClassSystem.IsAbstract
    ClassSystem.Create(abstractTestClass, { Name = "abstractTestClass", IsAbstract = true })

    local testClass = {}
    function testClass:foo2()
        print("foo")
    end

    local function errorBecauseOfNotImplementedMember()
        ClassSystem.Create(testClass, { Name = "testClass", Inherit = abstractTestClass })
    end

    luaunit.assertErrorMsgContains("does not implement inherited abstract member", errorBecauseOfNotImplementedMember)
end

function TestCreateClassWithAbstractMembers()
    local abstractTestClass = {}
    function abstractTestClass:foo()
    end

    abstractTestClass.foo = ClassSystem.IsAbstract

    local function errorBecauseOfNotMarkedAsAbstract()
        ClassSystem.Create(abstractTestClass, { Name = "abstractTestClass" })
    end

    luaunit.assertErrorMsgContains("has abstract member/s but is not marked as abstract",
        errorBecauseOfNotMarkedAsAbstract)
end

function TestCreateAbstractClassWithInterfaces()
    local interface = {}
    interface.test = ClassSystem.IsInterface
    ClassSystem.Create(interface, { Name = "interface", IsInterface = true })

    local abstractClass = {}
    abstractClass.class = ClassSystem.IsAbstract
    ClassSystem.Create(abstractClass, { Name = "abstractClass", IsAbstract = true })

    local class = {}
    class.class = "set"
    -- class.test = "set"
    ClassSystem.Create(class, { Name = "class" })
end

os.exit(luaunit.LuaUnit.run())

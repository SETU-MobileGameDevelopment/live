local test_1 = {
    data = {2, 7, -9, 0, 27, 36, 16},
    functions = {
        min = -9,
        max = 36,
        secondMax = 27,
        whereIsMax = {6},
        leftOfMax = 27,
    }
}

local test_2 = {
    data = {36, 36, 36, 16},
    functions = {
        min= 16,
        max = 36,
        secondMax = 16,
        whereIsMax = {1,2,3},
        leftOfMax = nil,
    }
}


local tests = {test_1, test_2}


function min(a)

end


function max(a)

end


function secondMax(a)

end


function whereIsMax(a)

end


function leftOfMax(a)

end


function lenOfLongestIncreasingSubsequence(a)

end


for testNum,test in ipairs(tests) do
    print("\nTest Number " ..testNum)
    print("Data: " .. table.concat(test.data, ", "))
    for f,expected in pairs(test.functions) do
        local actual = _G[f](test.data)
        local result
        if f=="whereIsMax" then
            expected = table.concat(expected,", ")
            actual =  table.concat(actual,", ")
            result = (actual==expected)
        else
            result = (actual==expected)
        end
        print(string.format("\t%-15s %s\t expected=%s\t actual=%s ", 
            f, tostring(result), tostring(expected), tostring(actual) ))
    end
end
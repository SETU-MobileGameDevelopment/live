local rng = { }

-- simple (emphesis on simple) random number generator 
-- works like math.randomseend and math.random

-- using microsoft's setting for generator
rng.a = 214013
rng.c = 2531011
rng.m = 2147483648

rng.state = 42


rng.randomseed = function(new_seed)
    rng.state = (new_seed * rng.a + rng.c) % rng.m
end


rng.rand = function()
    rng.state = (rng.a * rng.state + rng.c) % rng.m
    return rng.state % 32768
end

rng.random = function(min, max)

    -- no arguments, returns a random float in the range [0, 1). That is, zero up to but excluding 1.
    if min == nil then
        return rng.rand() / (32768)
    end

    -- 1 argument, returns an integer in the range [1, n]. That is from 1 up to and including n.
    if max == nil then
        min, max = 1, min+1
    end

    -- 2 arguments, returns an integer in the range [n, u]. That is from n up to and including u.
    return min + math.floor((max-min+1) * rng.rand() / (32768-1))

end

rng.simulate = function(param)

    local x_min = 1
    local x_max = 0
    local x_sum = 0
    local x2_sum = 0
    for k = 1, param.n do
        local x = rng.random()
        x_sum = x_sum + x
        x2_sum = x2_sum + x*x
        if x<x_min then x_min=x end
        if x>x_max then x_max=x end
    end
    local mean = x_sum/param.n
    local var = x2_sum/param.n - mean*mean

    param.min.obs = x_min
    param.max.obs = x_max
    param.mean.obs = mean
    param.var.obs = var

    print()
    print(param.message)
    for k,v in pairs(param) do
        if k=="n" or k=="message" then
            
        else
            print(k,math.abs(v.expected-v.obs)<1E-4, v.expected,v.obs)
        end
    end 
end

rng.test = function()

    local param = { 
        n = 1000000,
        message = "Testing random() .. should return uniform float in [0,1)",
        min = {expected=0},
        max = {expected=1},
        mean = {expected=0.5},
        var = {expected=1/12},
    }
    rng.simulate(param)

    
    for _,x_max in ipairs({2,6}) do 
        param = { 
            n = 1000000,
            message = "Testing random("..x_max..") .. should return uniform int in [1,"..x_max.."]",
            min = {expected=1},
            max = {expected=x_max},
            mean = {expected= (1+x_max)/2},
            var = {expected=(x_max*x_max-1)/12},
        }
        rng.simulate(param)
    end
end
return rng
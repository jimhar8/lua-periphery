package.path = package.path .. ';../../WeatherMat/software/WeatherMat_common/?.lua'

scheduler = require('scheduler')


function callbackFnc()
    print("here")
end

function punch()
	for i = 1, 50 do
		print('do stuff ' .. i)
		scheduler.wait(1.0)
	end
end

print("Attach debugger!")
print("Press enter to continue...")
io.read()

local GPIO = require('periphery').GPIO

-- Open GPIO 10 with input direction
local gpio_in = GPIO(5, "in")

--gpio_in.edge = "rising"

local value = gpio_in:read()
print(value)

--print(gpio_in:poll(30000))

gpio_in:add_event_detect(5, 2, 100, callbackFnc) 

scheduler.schedule(0.0, coroutine.create(punch))
scheduler.run()


print("done")

gpio_in:close()

package.path = package.path .. ';../../WeatherMat/software/WeatherMat_common/?.lua'

scheduler = require('scheduler')
local GPIO = require('periphery').GPIO


-- coroutine
function checkWindSpeed()

	gpio_in = GPIO(5, "in")	
	value = gpio_in:read()
	gpio_in:add_event_detect(5, 2, 1)	  -- gpio=5, edge=falling edge, 1msec debounce

	for i = 1, 30 do  -- temporary, just to allow testing for now
	
		local count = gpio_in:get_count(5)
		
		print(count)
		
     	-- tbd: calculte avg wind speed, retain gust max, etc.
		scheduler.wait(5.0)  -- collect 5 seconds worth of edges.  60mph wind would be 200 edges.
	end
end

print("Attach debugger!")
print("Press enter to continue...")
io.read()

-- schedule checkWindspeed coroutine
scheduler.schedule(0.0, coroutine.create(checkWindSpeed))
scheduler.run()

print("closing gpio")
gpio_in:close()

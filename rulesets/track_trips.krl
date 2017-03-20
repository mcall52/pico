ruleset track_trips {
	meta{
		name "track_trips"
		description <<
		Second ruleset for Part 1 of the single pico lab
		>>
		author "Michael Call"
		logging on
		//shares ...
	}
	
	global {
		__testing = { "events": [ {"domain": "car", "type": "new_trip", "attrs": ["mileage"] } ] }
	}
	
	rule process_trip {
		select when car new_trip
		pre {
			mileage = event:attr("mileage").klog("mileage is: ")
		}
		
		send_directive("trip") with
			trip_length = mileage
	}
}
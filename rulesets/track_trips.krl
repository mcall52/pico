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
		long_trip = 2000
		
		__testing = { "events": [ {"domain": "car", "type": "new_trip", "attrs": ["mileage"] },
								  {"domain": "explicit", "type": "trip_processed", "attrs": ["mileage"] } ]
					}
		
	}
	
	rule process_trip {
		select when car new_trip
		pre {
			mileage = event:attr("mileage").klog("mileage is: ")
			all_events = event:attrs()
		}
		
		send_directive("trip") with
			trip_length = mileage
		fired {
			
			raise explicit event "trip_processed"
				attributes event:attrs()
		}
			
	}
	
	rule find_long_trips {
		select when explicit trip_processed
		pre {
			mileage = mileage
		}
		fired {
			if (mileage.as("Number") > long_trip) 
				raise explicit event "found_long_trip"
		}
	}
}
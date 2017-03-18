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
	
	rule process_trip {
		select when echo message
		pre {
			mileage = event:attr("mileage").klog("mileage is: ")
		}
		
		send_directive("trip") with
			trip_length = mileage
	}
}
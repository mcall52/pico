ruleset third_ruleset {
	meta{
		name "third_ruleset"
		description <<
		First ruleset for Part 2 of the single pico lab, third ruleset total
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
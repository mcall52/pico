ruleset echo {
	meta {
		name "echo"
		description <<
		Part 1: Building a Simple Echo Service
		>>
		author "Michael Call"
		logging on
		shares __testing
	}
	
	global {
		__testing = { "events": [ {"domain": "echo", "type": "hello"},
								  {"domain": "echo", "type": "message", "attrs": [ "input" ] } ]
					}
	}

	rule hello {
		select when echo hello 
		
		send_directive("say") with
			something = "Hello World"
	}
	
	rule message {
		select when echo message
		pre {
			input = event:attr("input").klog("input is ")
		}
		
		send_directive("say") with	
			something = input
	}
}
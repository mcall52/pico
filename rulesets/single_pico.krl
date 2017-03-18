ruleset echo {
	meta {
		name "echo"
		description <<
		Part 1: Building a Simple Echo Service
		>>
		author "Michael Call"
		logging on
		//shares ...
	}

	rule hello {
		select when echo hello 
		
		send_directive("say") with
			something = "Hello World"
	}
	
	rule message {
		select when echo message
		pre {
			input 
		}
		
		send_directive("say") with	
			something = input
	}
}
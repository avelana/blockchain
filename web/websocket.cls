/// WebSocket connections handler class
Class web.websocket Extends %CSP.WebSocket
{

Property blockchain As %String;

Property sockets As list Of %String;

/// Push updates interval in seconds
Parameter PushUpdatesInterval = 0.5;

/// Initialize the chat when someone connects
Method OnPreServer() As %Status
{
    set ^App("steps") = ^App("steps")+1
    set ..blockchain = "test message"
    return $$$OK
}

Method OnPostServer() As %Status
{
	Quit $$$OK
}

/// Method that handles each new client in a new process.
Method Server() As %Status
{
	
	 while (1) { // loop forever until client disconnects
        set ^App("steps") = ^App("steps")+1
    	set data = ..Read(, .status, ..#PushUpdatesInterval)
    	// if the status is not a read timeout error (for example, client disconnects)
    	if ($$$ISERR(status)) && ($$$GETERRORCODE(status) '= $$$CSPWebSocketTimeout) {
    		quit // break the while loop
    	}
    	if (data '= "") { // if any data came from the client
    		set err = ..ReadClientData(data)
    		do:(err '= "") ..ReportError(err)
    	}

    } // end while loop

    return $$$OK
}

/// Process data received from client and return any error string
Method ReadClientData(data) As %String
{

	set ..blockchain = "test read date from client"
	return ""
}

/// Report an error for the client
Method ReportError(err = "")
{
	return:(err = "")
	do ..Send({
		"error": (err),
		"updates": []
	})
}

/// Sends JSON object to the client. This method created for convenience.
Method Send(jsonObj)
{
	return ..Write((jsonObj).%ToJSON())
}

}

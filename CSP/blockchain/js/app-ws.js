//const host = `ws://${ location.hostname }:57772`;
const host = `${ location.hostname }:57772`;
const ws_host = `ws://${ host }/blockchain/web.websocket.cls`;

let ws = null;
	
function httpGet (url, params = {}, callback) {
	
	if (typeof params === "function") {
		callback = params;
		params = {};
	}
	
    let xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4) {
            if (xmlHttp.status == 200) {
            	callback(null, xmlHttp.responseText);
            } else {
                callback(new Error("Timeout"));
			}
        }
    }
	
    xmlHttp.open("GET", url, true); // true for asynchronous
	if (params.timeout)
		xmlHttp.timeout = params.timeout;
    xmlHttp.send(null);
	
}

function connect (theHost) {
	console.log("we are connecting to " + theHost)
	if (ws && (ws.readyState === ws.OPEN || ws.readyState === ws.CONNECTING)) {
		ws.close();
	}
	
	ws = new WebSocket(${ the_Host });
	console.log("new WebSocket " + ws)
	
	ws.addEventListener("open", () => {
		console.log("Connection established.");
		ws.send(JSON.stringify({
			text: "text"
		}));
	});

	ws.addEventListener("error", (err) => printMessage({
		text: "Connection error: " + err.toString()
	}));

	ws.addEventListener("close", (event) => {
		console.log("Connection is closed. Code «" + event.code + "». Reason «" + event.reason + "».");
		printMessage({
		text: "Connection with the server is closed!"
	})
	});
	
	ws.addEventListener("message", (mes) => {
		let message = JSON.parse(mes.data);
		if (message["error"])
			return console.error(`Server reporting an error: ${ message.error }`);
		if (message["updates"] instanceof Array) message["updates"].forEach(update => {
			if (update.type === "message")
				printMessage(update);
			else if (update.type === "notification")
				printMessage(update);
			else if (update.type === "init")
				initRoom(update);
			else
				console.warn("Unhandled WebSocket message", message);
		});
	});
	
}

function printMessage ({ text }) {
    let block = document.querySelector(".data");
    block.innerHTML += `<div class="message">
       <div class="text">${ text }</div>
       </div>`;
    document.body.scrollTop = 99999999;
}

function clearMessages () {
	let block = document.querySelector(".data");
	block.innerHTML = "";
}

document.addEventListener("DOMContentLoaded", () => {
	
	SetWebSocketAddress();
	
	
    const selection = document.querySelector("#input");
	selection.addEventListener("keydown", (event) => {
        if (selection.value && event.keyCode === 13) {
            ws.send(JSON.stringify({ "text": "test client data" }));
        }
    });
	
	selection.addEventListener("change", (event) => {
		const selected = selection.options[selection.selectedIndex];
		clearMessages();
		printMessage({
			text: `test text`
		});
		connect(host);
	});
	
});
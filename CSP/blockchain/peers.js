    console.log("Hi");
	var xmlhttp = new XMLHttpRequest();
    
	var url ="http://localhost:57772/blockchain/api/peers";
	xmlhttp.open("GET", url, true);
    xmlhttp.setRequestHeader("Access-Control-Allow-Origin","*");
    xmlhttp.setRequestHeader("Access-Control-Allow-Credentials", "true");
    xmlhttp.send();
	xmlhttp.onreadystatechange = function()
	{     console.log("IN Func");
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
		{   console.log("IN ReadySt");
			console.log(myArr);
			var myArr = JSON.parse(xmlhttp.responseText);
			console.log(myArr);
            for(var i=0;i<myArr.Peers.length;i++)
            {
				console.log(myArr);
				$("#content").append("<tr><td>"myArr.Peers[i].ID"</td><td>" + myArr.Peers[i].IP + "</td><td>" + myArr.Peers[i].port + "</td></tr>");
            }
        }
	}
/*var form;

form.onsubmit = function (e) {
  // stop the regular form submission
  e.preventDefault();

  // collect the form data while iterating over the inputs
  var data = {};
  for (var i = 0, ii = form.length; i < ii; ++i) {
    var input = form[i];
    if (input.name) {
      data[input.name] = input.value;
    }
  }

	var url ="http://localhost:57772/blockchain/api/peers"
  // construct an HTTP request
  var xhr = new XMLHttpRequest();
  xhr.open(url,GET, true);
  xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8');

  // send the collected data as JSON
  xhr.send(JSON.stringify(data));
	
  xhr.onloadend = function () {
    // done
  };
};*/
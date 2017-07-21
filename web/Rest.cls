Class web.Rest Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
 	  <Route Url="/block" Method="GET" Call="json.Service:readData" />
 	  <Route Url="/mineBlock" Method="POST" Call="json.Service:writeData" />
 	  <Route Url="/peers" Method="GET" Call="json.Service:readPeer" />
</Routes>
}

}

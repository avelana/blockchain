Class web.Rest Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
 	  <Route Url="/block" Method="GET" Call="json.Service:readData" Cors="true"/>
 	  <Route Url="/mineBlock" Method="POST" Call="json.Service:writeData" Cors="true"/>
 	  <Route Url="/peers" Method="GET" Call="json.Service:readPeer" Cors="true"/>
 	  <Route Url="/addPeers" Method="GET" Call="json.Service:writePeer" Cors="true" />
 	  <Route Url="/getAllBlocks" Method="GET" Call="json.Service:readAllBlocks" Cors="true"/>
 	  <Route Url="/broadcast" Method="GET" Call="json.Service:broadCastData" Cors="true"/>
</Routes>
}

}

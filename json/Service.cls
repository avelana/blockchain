Class json.Service
{

ClassMethod readData() As %Status
{
	
	set list = ##class(dao.mainDao).ReadAllData()
	set returnJsonObj={}
	set jsonArray = []
	for i=1:1:list.Count()
	{
	do jsonArray.%Push(list.GetAt(i))
	}
	set returnJsonObj.data = jsonArray
	w returnJsonObj.%ToJSON()
	return $$$OK
}

ClassMethod writeData() As %Status
{
	set ^App("log") = "write data"
	#dim %request As %CSP.Request
	//set dataJson = ##class(%DynamicObject).%FromJSON(%request.Content)
	set dataJson = {"text":"Kanika"}
	set data = dataJson.text
	set obj =##class(entity.main).%OpenId(^chain)
	do obj.insertInBlockChain(obj.generateNextBlock(data))
    
    return $$$OK
}

ClassMethod readAllBlocks() As %Status
{
	
	set list = ##class(dao.mainDao).ReadAllBlocks()
	set returnJsonObj={}
	set jsonArray = []
	for i=1:1:list.Count()
	{
	do jsonArray.%Push(list.GetAt(i))
	}
	set returnJsonObj.Blocks = jsonArray
	w returnJsonObj.%ToJSON()
	return $$$OK
}

ClassMethod readPeer() As %Status
{
	
	set list = ##class(dao.mainDao).ReadAllPeers()
	set returnJsonObj={}
	set jsonArray = []
	for i=1:1:list.Count()
	{
	do jsonArray.%Push(list.GetAt(i))
	}
	set returnJsonObj.Peers = jsonArray
	w returnJsonObj.%ToJSON()
	return $$$OK
}

ClassMethod writePeer() As %Status
{
	#dim %request As %CSP.Request
	set dataJson = ##class(%DynamicObject).%FromJSON(%request.Content)
	//set dataJson = {"Ip":"183.167.22.32","port":"843711"}
	set obj =##class(entity.Peers).%New()
    set obj.IpAddress = dataJson.Ip
    set obj.PortId = dataJson.port
    set status = obj.%Save()

    return $$$OK
}

ClassMethod broadCastData(str As %String) As %Status
{
	
	&sql(declare scroller cursor for
			select  PortId,IpAddress 
			from entity.Peers)
			
		&sql(open scroller)
		for {
			&sql(fetch scroller into :port,:ip)
			quit:(SQLCODE '= 0)
			Set httprequest=##class(%Net.HttpRequest).%New()
		    Set httprequest.Server=ip
		    Set httprequest.Port=port
		    Do httprequest.InsertFormData(str)
		    Do httprequest.Post("/blockchain/api/mineBlocks")
				
		}
		&sql(close scroller)
}

}

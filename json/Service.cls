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
	#dim %request As %CSP.Request
	//set dataJson = ##class(%DynamicObject).%FromJSON(%request.Content)
	set dataJson = {"text":"alsnfa"}
	set data = dataJson.text
	set obj =##class(entity.main).%OpenId(^chain)
    do obj.insertInBlockChain(obj.generateNextBlock(data))

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
	set returnJsonObj = jsonArray
	w returnJsonObj.%ToJSON()
	return $$$OK
}

}

Class dao.mainDao Extends %Persistent
{

ClassMethod ReadAllData() As %ListOfDataTypes
{
    set obj =##class(entity.main).%OpenId(^chain)
    set list = ##class(%ListOfDataTypes).%New()
   for i=1:1:obj.blockChain.Count()
   { //write !,"I is",i  
    set var = obj.blockChain.GetAt(i).data
   // write "VAR is ",var
      do list.Insert(var)
   }
  // w !,"hello data",list.GetAt(2)
    //write obj.blockChain.Count()
    return list
}

ClassMethod ReadAllBlocks() As %ListOfObjects
{
  
	set list = ##class(%ListOfObjects).%New()
	try {
		
		&sql(declare BlocksCursor cursor for
			select ID
			from entity.block)
			
		&sql(open BlocksCursor)
		for {
			&sql(fetch BlocksCursor into :id)
			quit:(SQLCODE '= 0)
			set Jsonobj=..CopyToJsonBlock(##class(entity.block).%OpenId(id))
			do list.Insert(Jsonobj)
		}
		&sql(close BlocksCursor)
	}
	catch (ex) {
		set status = ex.AsStatus()
	}
	quit list
}

ClassMethod CopyToJsonBlock(peerObj As entity.block) As %DynamicObject
{

	set obj={}
	set obj.ID=peerObj.%Id()
	set obj.Data=peerObj.data
	set obj.Hash=peerObj.hash
	set obj.TimeStamp = peerObj.timestamp
    set obj.PreviousHash = peerObj.previousHash
	return obj
}

ClassMethod CopyToJson(peerObj As entity.Peers) As %DynamicObject
{

	set obj={}
	set obj.ID=peerObj.%Id()
	set obj.IP=peerObj.IpAddress
	set obj.Port=peerObj.PortId

	return obj
}

ClassMethod ReadAllPeers() As %ListOfObjects
{
  
	set list = ##class(%ListOfObjects).%New()
	try {
		
		&sql(declare PeerCursor cursor for
			select ID
			from entity.Peers)
			
		&sql(open PeerCursor)
		for {
			&sql(fetch PeerCursor into :id)
			quit:(SQLCODE '= 0)
			set Jsonobj=..CopyToJson(##class(entity.Peers).%OpenId(id))
			do list.Insert(Jsonobj)
		}
		&sql(close PeerCursor)
		
		//write list.Count()
	}
	catch (ex) {
		set status = ex.AsStatus()
	}
	quit list
}

Storage Default
{
<Data name="mainDaoDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^dao.mainDaoD</DataLocation>
<DefaultData>mainDaoDefaultData</DefaultData>
<IdLocation>^dao.mainDaoD</IdLocation>
<IndexLocation>^dao.mainDaoI</IndexLocation>
<StreamLocation>^dao.mainDaoS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

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

ClassMethod ReadAllPeers() As %ListOfDataTypes
{
	set list = ##class(%ListOfDataTypes).%New()
	try {
		
		&sql(declare PeerCursor cursor for
			select *
			from entity.Peers)
			
		&sql(open PeerCursor)
		for {
			&sql(fetch PeerCursor into :id,:IP,:port)
			quit:(SQLCODE '= 0)
			//do list.Insert(##class(entity.Peers).%OpenId(id))
			set str = " ID:  "_id_" IP :  "_IP_" Port:  "_port
			do list.Insert(str)
		}
		&sql(close PeerCursor)
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

Class entity.block Extends %Persistent
{

Property timestamp As %String [ Required ];

Property previousHash As %String [ Required ];

Property data As %String [ Required ];

Property hash As %String [ Required ];

Method %OnNew(PreviousHash As %String, Timestamp As %String, Data As %String, Hash As %String) As %Status
{
	set st = $$$OK
	set ..timestamp = Timestamp
	set ..previousHash = PreviousHash
	set ..data = Data
	set ..hash = Hash
	return st
}

Storage Default
{
<Data name="blockDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>timestamp</Value>
</Value>
<Value name="3">
<Value>previousHash</Value>
</Value>
<Value name="4">
<Value>data</Value>
</Value>
<Value name="5">
<Value>hash</Value>
</Value>
<Value name="6">
<Value>blockchain</Value>
</Value>
</Data>
<DataLocation>^entity.blockD</DataLocation>
<DefaultData>blockDefaultData</DefaultData>
<IdLocation>^entity.blockD</IdLocation>
<IndexLocation>^entity.blockI</IndexLocation>
<StreamLocation>^entity.blockS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

Class entity.Peers Extends %Persistent
{

Property PortId As %Numeric [ Required ];

Property IpAddress As %String [ Required ];

Storage Default
{
<Data name="PeersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PortId</Value>
</Value>
<Value name="3">
<Value>IpAddress</Value>
</Value>
<Value name="4">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^entity.PeersD</DataLocation>
<DefaultData>PeersDefaultData</DefaultData>
<IdLocation>^entity.PeersD</IdLocation>
<IndexLocation>^entity.PeersI</IndexLocation>
<StreamLocation>^entity.PeersS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

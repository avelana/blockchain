Class entity.main Extends %Persistent
{

Property blockChain As list Of entity.block;

Method getLatestBlock() As entity.block
{
	//set length=blockChain.Count()
	w !,"HASH is",..blockChain.GetAt(..blockChain.Count()).hash
	return ..blockChain.GetAt(..blockChain.Count())
	//return block1
}

Method calculateHash(previousHash As %String, timestamp As %String, data As %String) As %String
{

   set key = "wo2ni2"
   return $System.Encryption.HMACSHA( 256, previousHash_timestamp_data , key )
}

Method generateNextBlock(blockData As %String) As entity.block
{
	
	set previousBlock = ..getLatestBlock()
	//write "Pblock= ",previousBlock.data
	set nextTimeStamp = $ZTIMESTAMP
	//write previousBlock.hash
	set nextHash=..calculateHash(previousBlock.hash,nextTimeStamp,blockData)
	//write !,nextHash
	set ob = ##class(entity.block).%New(previousBlock.hash,nextTimeStamp,blockData,nextHash)
	  do ob.%Save()
	  return ob
}

Method getGenesisBlock() As entity.block
{
	set block1=##class(entity.block).%New("0",$ZTIMESTAMP,"genesis block","3784c14378abed4f7d7")
	write block1.data
	set status= block1.%Save()
	write !,status
	do $System.Status.DisplayError(status)
	return block1
}

Method createBlockChain() As %Status
{
   set block1=..getGenesisBlock()
   
	do ..blockChain.Insert(block1)
	return $$$OK
}

Method isValidNewBlock(newBlock As entity.block, previousBlock As entity.block) As %Status
{
 //    if (previousBlock.%Id() + 1 '= newBlock.%Id())
 //    {
 //        write "invalid index"
 //        return $$$ERROR($$$GeneralError,"Wrong")
 //    }
 // 	if (previousBlock.hash '= newBlock.previousHash)
 //    {
 //        write "invalid previoushash"
 //        return $$$ERROR($$$GeneralError,"Wrong")
 //    }
 //    elseif (..calculateHash(newBlock) '= newBlock.hash)
 //     {
 //         write "invalid Block ",..calculateHash(newBlock)," ",newBlock.hash
 //         return $$$ERROR($$$GeneralError,"Wrong")
 //    }
    return $$$OK
}

Method insertInBlockChain(newBlock As entity.block) As %Status
{
    set status = ..isValidNewBlock(newBlock,..getLatestBlock())
	if (status) {do ..blockChain.Insert(newBlock)}
	return $$$OK
}

// ClassMethod replaceChain(newBlock As Block)

// {

// 	if ( isValidChain(newBlock) && newBlock.length > blockchain.length)

// 	{

// 		write !, "Received blockchain is valid. Replacing current blockchain with received blockchain"

// 	    set blockchain = newBlock

// 	    broadcast(responseLatestMsg())

// 	}

// 	else

// 	{

// 		write !,"received blockchain invalid"

// 	}

// }

Storage Default
{
<Data name="mainDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>blockChain</Value>
</Value>
</Data>
<DataLocation>^entity.mainD</DataLocation>
<DefaultData>mainDefaultData</DefaultData>
<IdLocation>^entity.mainD</IdLocation>
<IndexLocation>^entity.mainI</IndexLocation>
<StreamLocation>^entity.mainS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

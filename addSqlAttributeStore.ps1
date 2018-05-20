$AttributeStoreName = "SQLAttributeStore"

$ServerName = "SqlServer.mydomain.net"
$SQLPort = 1433
$DatabaseName = "AttributeDB"

#I recommend to use integrated security. The service account for the ADFS farm needs READ and CONNECT rights to the database
#If you don't use integrated security you have to privde username and password
$UseIntegratedSecurity = $True
$Username = ""
$Password = ""

#If the ServerName is an availabilty group listener you should set this to $true
$AGListener = $False


$ConnectionString = ""

If ($SQLPort -ne 1433) {

    $ServerConnectionString = $ServerName+","+$SQLPort.ToString()

} Else {

    $ServerConnectionString = $ServerName

}

$ConnectionString += "Server=$ServerConnectionString;Database=$DatabaseName"

If ($UseIntegratedSecurity) {

    $ConnectionString += ";Integrated Security=True"

} Else {

    $ConnectionString += ";User Id=$Username;Password=$Password"

}

If ($AGListener) {
    
    $ConnectionString += ";MultiSubnetFailover=Yes"

}


Add-AdfsAttributeStore -Name $AttributeStoreName -StoreType SQL -Configuration @{"connection"=$ConnectionString}

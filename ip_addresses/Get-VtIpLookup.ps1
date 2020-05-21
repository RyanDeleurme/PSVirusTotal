
function Get-VtIpLookup
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Ip,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey
        )

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/ip_addresses/$ip"
        Headers = @{'x-apikey' = "$apikey"}
        Method = 'GET'
    }

    try 
    {
        $Json = Invoke-RestMethod @params 
        return $Json.data.attributes
    }
    catch
    {
        Get-VtServerErrors
    }
}

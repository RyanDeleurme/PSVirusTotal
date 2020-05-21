
function Get-VtIpVote
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
                Uri = "https://www.virustotal.com/api/v3/ip_addresses/$ip/votes"
                Headers = @{'x-apikey' = "$apikey"}
                Method = 'GET'
            }
    try 
    {
        $Json = Invoke-RestMethod @params 
        return $Json.data
    }
    catch
    {
        Get-VtServerErrors
    }
}

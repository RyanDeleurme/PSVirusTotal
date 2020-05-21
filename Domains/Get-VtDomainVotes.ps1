
function Get-VtDomainVotes
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $domain,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey
        )
            $params = @{
                Uri = "https://www.virustotal.com/api/v3/domains/$domain/votes"
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

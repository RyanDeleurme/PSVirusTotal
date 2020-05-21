
function Get-VtUrlVotes
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $url,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey
        )

    $urlBytes = [System.Text.Encoding]::UTF8.GetBytes($url)
    $urlId = [Convert]::ToBase64String($urlBytes)
    $urlId = $urlId.Replace('=','')
        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
            $params = @{
                Uri = "https://www.virustotal.com/api/v3/urls/$urlId/votes"
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

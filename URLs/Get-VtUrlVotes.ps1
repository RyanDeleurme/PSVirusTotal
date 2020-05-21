
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


function Get-VtFileVote
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $filePath,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey
        )

        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
        $hash = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
            $params = @{
                Uri = "https://www.virustotal.com/api/v3/files/$hash/votes"
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

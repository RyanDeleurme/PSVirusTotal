
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

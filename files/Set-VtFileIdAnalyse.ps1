
function Set-VtFileIdAnalyse
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,

        [Parameter(Mandatory=$true)]
        [string]
        $filePath
        )
        #ID needs to be SHA256, SHA1, or MD5 hash of a file
        $hash = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/files/$hash/analyse"
            $params = @{
                Uri = $uri
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

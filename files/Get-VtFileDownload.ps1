
function Get-VtFileDownload
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,

        [Parameter(Mandatory=$true)]
        [string]
        $filePath
        )
        #special priveleges required.
        $hash = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/files/$hash/download"
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

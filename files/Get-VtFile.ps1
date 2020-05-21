
function Get-VtFile
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
        #need to expand property unless the hash will return in a hash table and not a string
        $hash = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/files/$hash"
            $params = @{
                Uri = $uri
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
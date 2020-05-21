
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
        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
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

function Get-VtAnalyses
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,

        [Parameter(Mandatory=$true)]
        [string]
        $id
        )
        #ID needs to be SHA256, SHA1, or MD5 hash of a file
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/analyses/$id"
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


function Get-VtFileUploadUrl
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey 
        )

        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/files/upload_url"
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

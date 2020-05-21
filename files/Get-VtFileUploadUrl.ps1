
function Get-VtFileUploadUrl
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey 
        )

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

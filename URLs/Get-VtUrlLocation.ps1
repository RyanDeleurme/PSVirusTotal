function Get-VtUrlLocation
{

    ## Need powershell 7 to post the form data with invoke-restmethod ## 
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [string]
        $url
        )

    # we need to convert the URL to Base64 and strip the = at the end since this is what the 
    #documentation says in the virus total API.
    $urlBytes = [System.Text.Encoding]::UTF8.GetBytes($url)
    $urlId = [Convert]::ToBase64String($urlBytes)
    $urlId = $urlId.Replace('=','')

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/urls/$urlId/network_location"
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
6
function Set-VtUrl 
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

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/urls"
        Headers = @{'x-apikey' = "$apikey"}
        Method = 'POST'
        Form = @{url = $url}
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

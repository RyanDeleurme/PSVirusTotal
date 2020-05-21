function Get-VtDomain
{

    ## Need powershell 7 to post the form data with invoke-restmethod ## 
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [string]
        $domain
        )

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/domains/$domain"
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

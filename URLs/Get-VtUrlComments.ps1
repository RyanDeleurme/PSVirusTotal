function Get-VtUrlComments
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $url,
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,
        [Parameter(Mandatory=$false)]
        [hashtable]
        $queryParams
        )

    $urlBytes = [System.Text.Encoding]::UTF8.GetBytes($url)
    $urlId = [Convert]::ToBase64String($urlBytes)
    $urlId = $urlId.Replace('=','')

    # Create a http name value collection from an empty string
    $uri = "https://www.virustotal.com/api/v3/urls/$urlId/comments"
    #if the user did not specify any parameters
    if($queryParams.length -lt 1)
    {
        $params = @{
            Uri = $uri
            Headers = @{'x-apikey' = "$apikey"}
            Method = 'GET'
        }
    }
    else 
    {
        $uriReq = New-HttpQueryString -Uri $uri -QueryParameter $queryParams
        $params = @{
            Uri = $uriReq
            Headers = @{'x-apikey' = "$apikey"}
            Method = 'GET'
        }
    }

    try 
    {
        $Json = Invoke-RestMethod @params
        $json.data.ID #give the comment ID back to the user
        return $Json.data.attributes
    }
    catch
    {
        Get-VtServerErrors
    }

<#data object 
{
  "data": {
    "type": "comment",
    "attributes": {
        "text": "Lorem #ipsum dolor sit ..."
    }
  }
}#>

}

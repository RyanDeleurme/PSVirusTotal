function Get-VtComments
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,
        [Parameter(Mandatory=$false)]
        [hashtable]
        $queryParams,
        [Parameter(Mandatory=$true)]
        [string]
        $id
        )

    # Create a http name value collection from an empty string
    $uri = "https://www.virustotal.com/api/v3/comments/$id"
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
        $json.data.links
        return $Json.Data.Attributes
    }
    catch
    {
        Get-VtServerErrors
    }
}


function Set-VtUrlVote
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $url,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$true)]
        [ValidateSet('harmless','malicious')]
        [string]
        $vote
        )

    $urlBytes = [System.Text.Encoding]::UTF8.GetBytes($url)
    $urlId = [Convert]::ToBase64String($urlBytes)
    $urlId = $urlId.Replace('=','')
    #The data object needs to be formatted like this and converted to a JSON object per the docs
    #https://developers.virustotal.com/v3.0/reference#ip-comments-post
    # we will pass this into the body parameter to make the call
    $voteDataObject = 
    @{data = 
        @{
        type = "vote"
        attributes = 
            @{
                verdict = $vote
            }
        }
    }

    $voteDataObject = $voteDataObject | ConvertTo-Json

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/urls/$urlId/votes"
        Headers = @{'x-apikey' = "$apikey"}
        Method = 'POST'
        Body = $voteDataObject
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

<#data object 
{
  "data": {
    "type": "vote",
    "attributes": {
        "verdict": "harmless"
    }
  }
}#>

}

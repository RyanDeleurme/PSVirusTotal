function Set-VtIpVote 
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Ip,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$true)]
        [ValidateSet('harmless','malicious')]
        [string]
        $vote
        )

    #The data object needs to be formatted like this and converted to a JSON object per the docs
    #https://developers.virustotal.com/v3.0/reference#ip-comments-post
    # we will pass this into the body parameter to make the call
    $commentDataObject = 
    @{data = 
        @{
        type = "vote"
        attributes = 
            @{
                verdict = $vote
            }
        }
    }

    $commentDataObject = $commentDataObject | ConvertTo-Json

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/ip_addresses/$ip/votes"
        Headers = @{'x-apikey' = "$apikey"}
        Method = 'POST'
        Body = $commentDataObject
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
    "type": "vote",
    "attributes": {
        "text": "harmless"
    }
  }
}#>

}

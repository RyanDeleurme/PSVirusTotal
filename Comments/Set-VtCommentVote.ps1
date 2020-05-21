function Set-VtCommentVote
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,
        [Parameter(Mandatory=$false)]
        [ValidateSet('positive','negative','abuse')]
        [string]
        $vote,
        [Parameter(Mandatory=$true)]
        [string]
        $id
        )

    # Create a http name value collection from an empty string
    $uri = "https://www.virustotal.com/api/v3/comments/$id/vote"
    #if the user did not specify any parameters

        $params = @{
            Uri = $uri
            Headers = @{'x-apikey' = "$apikey"}
            Method = 'GET'
        }

    try
    {
        $Json = Invoke-RestMethod @params
        return $Json.Data.Attributes
    }
    catch
    {
        Get-VtServerErrors
    }
}


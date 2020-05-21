
function Get-VtDomainRelationships
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $domain,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [hashtable]
        $queryParams,

        [Parameter(Mandatory=$true)]
        [ValidateSet('communicating_files','downloaded_files','graphs','historical_whois','referrer_files',
        'resolutions','siblings','subdomains','urls')]
        [string]
        $relationship
        )
        
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/domains/$domain/$relationship"
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
        return $Json.data
    }
    catch
    {
        Get-VtServerErrors
    }
}

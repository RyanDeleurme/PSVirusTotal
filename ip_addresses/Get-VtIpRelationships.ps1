
function Get-VtIpRelationships
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $Ip,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [hashtable]
        $queryParams,

        [Parameter(Mandatory=$true)]
        [ValidateSet('comments','communicating_files','downloaded_files','graphs','historical_whois',
        'referrer_files','resolutions','urls')]
        [string]
        $relationship
        )

        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
        # Add System.Web
        Add-Type -AssemblyName System.Web
    
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/ip_addresses/$ip/$relationship"
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
        return $Json.data.attributes
    }
    catch
    {
        Get-VtServerErrors
    }
}

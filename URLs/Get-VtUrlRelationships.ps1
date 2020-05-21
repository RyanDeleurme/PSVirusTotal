
function Get-VtUrlRelationships
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
        $queryParams,

        [Parameter(Mandatory=$true)]
        [ValidateSet('analyses','downloaded_files','graphs','last_serving_ip_address','redirecting_urls','submissions')]
        [string]
        $relationship
        )

        #'5d5ee699f97d2225e80fa3e1dcd125e1442d124510e00493726456afa0ddf4ab'
        # Add System.Web
        Add-Type -AssemblyName System.Web
        $urlBytes = [System.Text.Encoding]::UTF8.GetBytes($url)
        $urlId = [Convert]::ToBase64String($urlBytes)
        $urlId = $urlId.Replace('=','')
        
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/urls/$urlId/$relationship"
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

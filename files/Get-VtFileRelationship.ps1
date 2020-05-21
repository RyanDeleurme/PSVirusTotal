
function Get-VtIpRelationships
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $filePath,
    
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [hashtable]
        $queryParams,

        [Parameter(Mandatory=$true)]
        [ValidateSet('analyses','behaviours','bundled_files','carbonblack_children','carbonblack_parents','comments',
        'compressed_parents','contacted_domains','contacted_ips','contacted_urls','email_parents','embedded_domains',
        'embedded_ips','embedded_urls','execution_parents','graphs','itw_urls','overlay_parents','pcap_parents',
        'pe_resource_parents','submissions','screenshots','votes')]
        [string]
        $relationship
        )

        $hash = Get-FileHash -Path $filePath -Algorithm SHA256 | Select-Object -ExpandProperty Hash
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/files/$hash/$relationship"
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

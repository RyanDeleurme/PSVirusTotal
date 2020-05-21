
function Get-VtFileSandbox
{
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey,

        [Parameter(Mandatory=$true)]
        [string]
        $SandboxId
        )
        #special priveleges required.
        # Create a http name value collection from an empty string
        $uri = "https://www.virustotal.com/api/v3/file_behaviours/$sandboxid/pcap"
            $params = @{
                Uri = $uri
                Headers = @{'x-apikey' = "$apikey"}
                Method = 'GET'
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

function Set-VtFile 
{

    ## Need powershell 7 to post the form data with invoke-restmethod ## 
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $apikey, 

        [Parameter(Mandatory=$false)]
        [string]
        $filePath
        )

    $params = @{
        Uri = "https://www.virustotal.com/api/v3/files"
        Headers = @{'x-apikey' = "$apikey"}
        Method = 'POST'
        Form = @{file = Get-Item -Path $filePath}
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

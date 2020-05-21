Function Get-VtServerErrors 
{
    #https://tintriapiui.wordpress.com/2017/05/23/invoke-restmethod-exception-handling-with-tintri-apis/
    Write-Host -ForegroundColor Red "There was an error with the API call. Please see the verbose error below to fix your issue."
    #BUILD THE OBJECT FROM SERVER AND PS ERROR MESSAGES
    $serverErrorData = $Error[0].ErrorDetails.Message | ConvertFrom-Json
    $errorMessage = [pscustomobject] @{
        HTTPStatusCode = $_.Exception.Response.StatusCode.value__
        ServerErrorMessage = $serverErrorData.error.message
        ServerErrorCode = $serverErrorData.error.code
        PSError = $_.Exception.Message
        LineError = $_.InvocationInfo.ScriptLineNumber
        RawError = $_
        }
    return $errorMessage
}
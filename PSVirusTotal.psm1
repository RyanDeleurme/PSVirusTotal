
$scriptRoots = @('\Comments','\Domains','\files','\ip_addresses','\URLs','')

foreach($s in $scriptRoots)
{
    $path = $PSScriptRoot + $s
    Get-ChildItem $path *.ps1 | ForEach-Object {Import-Module $_.FullName}
}

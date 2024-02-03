#Endpoint: 'https://util.UTF8.org/UTF8Jsps/character.jsp'
#Method(s): Get
#Content Type: HTML, .jsp

param (
    [string]$CharCode,
    [string]$SelectedChar
    )

#♠
#In the File variable, specify the path the AHK file.
$File = "C:\Users\[Your Username]\Documents\...\Get Character Code.ahk"
#

try {
if (Test-Path -LiteralPath "$File") {
$URI = 'https://util.unicode.org/UnicodeJsps/character.jsp'
$userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
$uri_Params = "$($URI)?a=$($CharCode)&B1=Show"
$body = @{a="$CharCode"; B1="Show"}
$get_response = Invoke-RestMethod -Uri $uri_Params -UserAgent $userAgent  -Method "Get" -Body $body
$pattern = '<td class=''(big[a-zA-Z]{4})''>(?:<.*>)?(.*)(?:<.*>)?</td>' 
$char = New-Object System.Collections.ArrayList
$matches = $get_response | Select-String -Pattern $pattern -AllMatches
if ($matches.Matches) {
    Remove-Item -Path "$env:TMP\Test-Rest-Matches.tmp" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:TMP\Test-Rest-Response.tmp" -Force -ErrorAction SilentlyContinue
    $counter = 0
    $matches.Matches | Select-Object -First 4 | ForEach-Object {
        $null = $char.Add($_.Groups.Captures[2].Value)
        Add-Content -Path "$env:TMP\Test-Rest-Matches.tmp" -Value "$($char[$counter])" -Encoding "UTF8" -Force
        Add-Content -Path "$env:TMP\Test-Rest-Response.tmp" -Value "$get_response" -Encoding "UTF8" -Force
        $counter++
    }
} else {
    Out-File -InputObject $get_response -FilePath "$env:TMP\Test-Rest-Matches.tmp" -Encoding "UTF8" -Force
}
Write-Output "$($char[0])`nU+$($char[1])`n$($char[2])`n$($char[3])"
}
} catch {
    Write-Output $_ 2>&1
}


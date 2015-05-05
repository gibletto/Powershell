Param([string]$FileName)

[System.Xml.XmlDocument]$file = new-object System.Xml.XmlDocument
$path = Join-Path $pwd $FileName
$file.load($path)
$keys = $file.SelectNodes("//rewriteMaps//rewriteMap") | Group-Object key
foreach ($key in $keys){
    foreach ($group in $key.Group) {
        Write-Host "$($group.Name)"
        $values = $group.add | Group-Object key | Sort-Object Count -descending            
        foreach ($value in $values | Where-Object Count -NE "1"){       
            Write-Host "$($value.Count) $($value.Name)"            
        }
    }
}  

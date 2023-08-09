$lfrc = "C:\Users\bschul3\AppData\Local\lf\lfrc"
$pwshconfig = "C:\Users\bschul3\Documents\WindowsPowerShell"
$dl = "C:\Users\bschul3\Downloads"
$dt = "C:\Users\bschul3\Desktop"
$wm_vans = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Vans.pdf"

function paths {
  $content = Get-Content $pwshconfig/custom_scripts/vfpaths.ps1
  $table = [ordered]@{}
  foreach ($line in $content) {
    if ($line -match '(\$.+?) ') { $key = $Matches[1] }
    if ($line -match '\"(.+?)"') { $value = $Matches[1] }
    $table.Add($key, $value) 
  }
  Write-Output ($table)
}

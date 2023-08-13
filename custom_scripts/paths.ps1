$lfrc = "~\AppData\Local\lf\lfrc"
$pwshconfig = "~\Documents\WindowsPowerShell"
$dl = "~\Downloads"
$dt = "~\Desktop"
$wm_vans = "~\OneDrive - VFC Corp\Documents\Stamps\pdf\Vans.pdf"

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

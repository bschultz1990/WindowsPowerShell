function paths_view {
  $content = Get-Content $pwshconfig/custom_scripts/vfpaths.ps1
  $table = [ordered]@{}
  foreach ($line in $content) {
    if ($line -match '(\$.+?) ') { $key = $Matches[1] }
    if ($line -match '\"(.+?)"') { $value = $Matches[1] }
    $table.Add($key, $value) 
  }
  Write-Output ($table)
}

function path_edit {
  nvim "$pwshconfig/custom_scripts/vfpaths.ps1"
  }

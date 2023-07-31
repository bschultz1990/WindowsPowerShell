# TODO: Include the following functions:
# rn: rename
# mkdir: mkdir 1 or more
# cp: copy 1 or more
# mv: move 1 or more
# rm: remove 1 or more

function c {
  while ($true) {
    $global:dirs_array = @('..')
    # $dirs = Get-ChildItem -Directory
    $dirs = Get-ChildItem
    foreach ($dir in $dirs) {
      $global:dirs_array += $dir.Name
    }
    Get-Location
    for ($i = 0; $i -lt $global:dirs_array.Length; $i++) {
      Write-Host "$i  $($global:dirs_array[$i])"
    }
    $response = Read-Host "Command: ? for a list"
    if ($response -eq '?') {
      
    }
    if ($response -eq 'q') {
      return
    }
    Set-Location $global:dirs_array[$response]
    $global:dirs_array = @('..')
    Clear-Host
  }
}

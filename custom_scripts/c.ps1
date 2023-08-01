# TODO: Include the following functions:
# Revamp the external function calling mode.
# Highlight the last-visited item.
# 
function c {
  Clear-Host
  while ($true) {
    $global:dirs_array = @('..')
    # $dirs = Get-ChildItem -Directory
    $dirs = Get-ChildItem
    foreach ($dir in $dirs) {
      $global:dirs_array += $dir.Name
    }
    Get-Location
    for ($i = 0; $i -lt $global:dirs_array.Length; $i++) {
      if ($global:dirs_array[$i] -eq $last) {
        Write-Host "$i  $($global:dirs_array[$i])" -BackgroundColor Blue -ForegroundColor Gray
      }
      Write-Host "$i  $($global:dirs_array[$i])"
    }
    $response = Read-Host "Command: ? for a list"

    if ($response -eq 'q') {
      return
    }
    if ($response -eq 'r') {
      Clear-Host
    }
    if ($response -match '^rn') {
      $arguments = $response -split ' '
      Set-Clipboard $global:dirs_array[$arguments[1]]
      rename $global:dirs_array[$arguments[1]]
      Clear-Host
    }
    if ($response -match '^cp') {
      $arguments = $response -split ' '
      cp $global:dirs_array[$arguments[1]] $global:dirs_array[$arguments[2]] -recurse
      Clear-Host
    }
    if ($response -match '^rm') {
      $arguments = $response -split ' '
      rm $global:dirs_array[$arguments[1]]
      Clear-Host
    }
    if ($response -match '^mv') {
      $arguments = $response -split ' '
      mv $global:dirs_array[$arguments[1]] $global:dirs_array[$arguments[2]]
      Clear-Host
    }
    if ($response -match '^touch') {
      $arguments = $response -split ' '
      touch $arguments[1]
      Clear-Host
    }
    if ($response -match '^mkdir') {
      $arguments = $response -split ' '
      $innerArgs = $arguments[1..($arguments.Length - 1)]
      mkdir $innerArgs
      Clear-Host
    }
    if ($response -match '^\d+') {
      if (Test-Path -Path $global:dirs_array[$response] -PathType Container) {
        Set-Location $global:dirs_array[$response]
        $global:dirs_array = @('..')
      }
      else {
        start $global:dirs_array[$response]
      }
      Clear-Host
    }
  }
}

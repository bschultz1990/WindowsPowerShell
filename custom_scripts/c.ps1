# TODO: Revamp the external function calling mode.
# TODO:If #2 the dirs_array won't fit on one column, use 2 or 3.
# TODO:Add #1 a file picking basket.

function c {
  param ( [string]$working_directory = "." )
  Clear-Host
  try {
    Set-Location $working_directory -ErrorAction Stop
  }
  catch {
    Write-Error "Error: Path does not exist or is not accessible."
    return
  }

  while ($true) {
    $global:dirs_array = @('..')
    $dirs = Get-ChildItem
    foreach ($dir in $dirs) {
      $global:dirs_array += $dir.Name
    }
    $header = (Get-Item .).FullName
    Write-Host $header -ForegroundColor Blue

    for ($i = 0; $i -lt $global:dirs_array.Length; $i++) {
      Write-Host "$i" -ForegroundColor Yellow -NoNewline
      Write-Host "  " -NoNewline

      # Highlight search results
      if (($searched -eq $True) -and $global:dirs_array[$i] -match $search) {
        Write-Host "$($global:dirs_array[$i])" -BackgroundColor Green -ForegroundColor Black
      }
      # Highlight last visited directory
      elseif ($global:dirs_array[$i] -eq $global:last) {
        Write-Host "$($global:dirs_array[$i])" -BackgroundColor Blue -ForegroundColor Black
      }
      # Highlight directories
      elseif (-not (Test-Path -Path $global:dirs_array[$i] -PathType Leaf)) {
        Write-Host "$($global:dirs_array[$i])" -ForegroundColor Blue
      }
      else { 
        Write-Host "$($global:dirs_array[$i])" 
      }
    }
    $response = Read-Host "Command"

    if ($response -eq 'noh') {
      $searched = $False
      Clear-Host
    }
    if ($response -match '^/') {
      $arguments = $response -split '/'
      $search = $arguments[1]
      $searched = $True
      Clear-Host
    }
    if ($response -eq 'q') {
      return
    }
    if ($response -eq 'r') {
      Clear-Host
    }
    if ($response -match '^rn') {
      $arguments = $response -split ' '
      Set-Clipboard $global:dirs_array[$arguments[1]]
      $global:last = rename $global:dirs_array[$arguments[1]]
      Clear-Host
    }
    if ($response -match '^cp') {
      $arguments = $response -split ' '
      cp $global:dirs_array[$arguments[1]] $global:dirs_array[$arguments[2]] -recurse
      Clear-Host
    }
    if ($response -match '^dd') {
      $arguments = $response -split ' '
      $confirmed = $False
      while ($confirmed -eq $False) {
        Write-Host "Delete '$($global:dirs_array[$arguments[1]])'" -BackgroundColor Red -ForegroundColor White
        $confirm = Read-Host "Are you sure? (yes/no)"
        if ($confirm.ToLower() -eq 'yes') {
          $confirmed = $True
          rm $global:dirs_array[$arguments[1]]
        }
        elseif ($confirm.ToLower() -eq 'no') {
          $confirmed = $True
          break
        }
      }
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
      mkdir $arguments[1]
      $global:last = $arguments[1]
      Clear-Host
    }
    if ($response -eq 'b') {
      $global:last = ((Get-Item -Path $pwd).Name)
      $global:dirs_array = @('..')
      Set-Location ..
      Clear-Host
    }
    if ($response -match '^\d+') {
      if (Test-Path -Path $global:dirs_array[$response] -PathType Container) {
        $global:last = ((Get-Item -Path $pwd).Name)
        Set-Location $global:dirs_array[$response]
        $global:dirs_array = @('..')
      }
      else {
        $global:last = $global:dirs_array[$response]
        Start-Process $global:dirs_array[$response]
      }
      Clear-Host
    }
    Clear-Host
  }
}

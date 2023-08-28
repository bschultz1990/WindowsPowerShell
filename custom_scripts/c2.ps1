function c2 {
  param (
    [string]$working_directory = ".",
    [int]$page = 1
  )

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
    $console_height = $host.UI.RawUI.WindowSize.Height
    $items_per_page = $console_height - 3

    $header = (Get-Item .).FullName
    Write-Host $header -ForegroundColor Blue

    $start_index = ($page - 1) * $items_per_page
    $end_index = $start_index + $items_per_page

    for ($i = $start_index; $i -lt $end_index; $i++) {
      if ($i -ge $global:dirs_array.Length) {
        break
      }

      # Highlight search results
      if (($searched -eq $True) -and $global:dirs_array[$i] -match $search) {
        Write-Host "$i  " -ForegroundColor DarkGray -NoNewline
        Write-Host "$($global:dirs_array[$i])" -BackgroundColor Green -ForegroundColor Black
      }
      # Highlight last visited directory
      elseif ($global:dirs_array[$i] -eq $global:last) {
        Write-Host "$i  " -ForegroundColor DarkGray -NoNewline
        Write-Host "$($global:dirs_array[$i])" -BackgroundColor Blue -ForegroundColor Black
      }
      # Highlight directories
      elseif (-not (Test-Path -Path $global:dirs_array[$i] -PathType Leaf)) {
        Write-Host "$i  " -ForegroundColor DarkGray -NoNewline
        Write-Host "$($global:dirs_array[$i])" -ForegroundColor Blue
      }
      else { 
        Write-Host "$i  " -ForegroundColor DarkGray -NoNewline
        Write-Host "$($global:dirs_array[$i])" 
      }
    }

    # Check if there are more items beyond the current page
    if ($end_index -lt $global:dirs_array.Length) {
      Write-Host "Page Down: Press 'd' to go to the next page."
    }

    # Check if there are previous items before the current page
    if ($start_index -gt 0) {
      Write-Host "Page Up: Press 'a' to go to the previous page."
    }

    $response = Read-Host "Command"

    # Handle page navigation commands
    if ($response -eq 'd') {
      # Go to the next page
      $page++
      Clear-Host
      continue
    }
    elseif ($response -eq 'a') {
      # Go to the previous page
      $page--
      Clear-Host
      continue
    }

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


    if ($response -eq 'q') {
      return
    }
    if ($response -eq 'r') {
      Clear-Host
    }

    # Rest of the command handling code...
    # (Please refer to the original function for the remaining code)
  }
}

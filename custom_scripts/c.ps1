function c {
  while ($true) {
    $global:dirs_array = @('..')
      $dirs = Get-ChildItem -Directory
      foreach ($dir in $dirs) {
        $global:dirs_array += $dir.Name
      }
    Get-Location
      for ($i = 0; $i -lt $global:dirs_array.Length; $i++) {
        Write-Host "$i  $($global:dirs_array[$i])"
      }
    $response = Read-Host "Goto or 'q' to quit"
      if ($response -eq 'q') {
        Clear-Host
          Get-ChildItem
          return
      }
    Set-Location $global:dirs_array[$response]
      $global:dirs_array = @('..')
      Clear-Host
  }
}

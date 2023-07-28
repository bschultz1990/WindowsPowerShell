$global:dirs_array = @()

function c {
  while ($response -ne "q") {
    # get-childitem of current dir
    $dirs = Get-ChildItem
    # push just the name of each item into an array
    foreach ($dir in $dirs) {
      $global:dirs_array += $dir.Name
    }
    # display array
    for ($i = 0; $i -lt $global:dirs_array.Length; $i++) {
      Write-Host "$i  $($global:dirs_array[$i])"
    }
    # ask user for array index
    $response = Read-Host "Goto or 'q' to quit"
    # cd to that index's directory
    cd $global:dirs_array[$response]
    $global:dirs_array.clear()
  }
}

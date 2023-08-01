$global:mark_array = @()

function mark {
  if ($global:mark_array -contains $pwd) {
    return
  }
  $global:mark_array += $pwd
}

function marks {
  param (
    [switch]$silent
  )
  if ($global:mark_array.Length -eq 0) {
    Write-Host "No marks. Nothing to see here."
    return
  }
  for ($i = 0; $i -lt $global:mark_array.Length; $i++) {
    Write-Host "$i  $($global:mark_array[$i])"
  }
  if (!$silent) {
    goto $global:mark_array
  }
}

function mark_remove {
  marks -silent
  [int]$index = Read-Host "remove"
  $arrayList = [System.Collections.ArrayList]$global:mark_array
  $arrayList.RemoveAt($index)
  $global:mark_array = $arrayList.ToArray()
}

function marks_clear {
  $global:mark_array = @()
  Write-Host "Marks cleared."
}

# goto is an internal function never meant to be called by the user directly.
function goto {
  param (
    [string[]]$array
  )
  [int]$index = Read-Host "goto"
  cd $array[$index]

}
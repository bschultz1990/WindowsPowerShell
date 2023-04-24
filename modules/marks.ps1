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
    goto
  }
}

function unmark {
  marks -silent
  [int]$index = Read-Host "remove"
  $arrayList = [System.Collections.ArrayList]$global:mark_array
  $arrayList.RemoveAt($index)
  $global:mark_array = $arrayList.ToArray()
}

function unmark_all {
  $global:mark_array = @()
  Write-Host "Marks cleared."
}

function goto {
   [int]$index = Read-Host "goto"
   cd $global:mark_array[$index]

}
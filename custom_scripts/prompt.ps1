function gitstatus {

}

# https://devblogs.microsoft.com/powershell/fun-with-paths/
function Prompt {
  $base = "$((Get-Item .).fullname)"

  if (git symbolic-ref --short HEAD 2>$null) { $notation = " " + (git symbolic-ref --short HEAD 2>$null) }
  if (git status -s 2>$null) { $notation += " +" + (git status -s 2>$null | Measure-Object -Line).Lines }

  return $base + $notation + "`r`n> "
}
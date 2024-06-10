# https://devblogs.microsoft.com/powershell/fun-with-paths/
function Prompt {
  $base = "$((Get-Item .).fullname)"
  return $base + "`r`n> "
}

# https://devblogs.microsoft.com/powershell/fun-with-paths/
function Prompt {
  return "$((Get-Item .).fullname)`r`n> "
}
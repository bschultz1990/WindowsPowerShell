$todo_path = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\todo.txt"

function todo {
  param (
    [switch]$a,
    [switch]$l,
    [switch]$e
  )
  
  if ($a) {
    $todo = Read-Host "Todo content"
    Add-Content -Path $todo_path -Value $todo
    nvim $todo_path +sort +wq
    Clear-Host
    bat $todo_path
    return
  }
  
  if ($l) {
    bat $todo_path
    return
  }

  if ($e) {
    nvim $todo_path
    return
  }
  
  Write-Host "todo -flag`n" +
  "-a: add todo`n" +
  "-l: list todos`n" +
  "-e: edit todos file`n"
}

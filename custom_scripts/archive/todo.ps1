$todo_path = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\todo.txt"

function todo {
  param ( [switch]$v, [switch]$e, [switch]$h)

  if ($h) {
    Write-Host "todo 'note here'"
    Write-Host "or todo -flag"
    Write-Host "-v: view todos"
    Write-Host "-e: edit todos file"
    return
  }

  if ($v) {
    cat $todo_path 
    return 
  }

  if ($e) {
    nvim $todo_path
    return
  }

  $todo = Read-Host "Todo content"
  Add-Content -Path $todo_path -Value $todo
  nvim $todo_path +sort +wq
  Clear-Host
  cat $todo_path
}

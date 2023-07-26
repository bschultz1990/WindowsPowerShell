function todo ($todo) {
  while (-not $todo) { $todo = Read-Host "Todo content" }
  Add-Content -Path todo.txt -Value $todo
  nvim todo.txt +sort +wq
  Clear-Host
  bat todo.txt
}

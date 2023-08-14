# Start-Job -ScriptBlock {
function clean {
  while ($true) {
    Remove-item ~/Downloads/*.ica
    Start-Sleep -Seconds 60
  }
}
# }
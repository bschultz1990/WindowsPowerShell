# Start-Job -ScriptBlock {
function clean {
  clear
  Write-Host "Cleaning ~/Downloads..."
  while ($true) {
    Remove-item ~/Downloads/*.ica
    Start-Sleep -Seconds 60
  }
}
# }

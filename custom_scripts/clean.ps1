# Start-Job -ScriptBlock {
function clean {
  clear
  Write-Host "Cleaning ~/Downloads and OneDrive Attachments..."
  while ($true) {
    Remove-item ~/Downloads/*.ica
    Remove-item ~/OneDrive - VFC Corp/Attachments/*
    Start-Sleep -Seconds 60
  }
}
# }

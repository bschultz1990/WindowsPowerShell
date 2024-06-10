# Start-Job -ScriptBlock {
function clean {
  Clear-Host
  Write-Host "Cleaning ~/Downloads and OneDrive Attachments..."
  while ($true) {
    Remove-item "~/Downloads/*.ica"
    Remove-item "~/OneDrive - VFC Corp/Attachments/*"
    Remove-item "~\Pictures\Screenshots"
    Start-Sleep -Seconds 60
  }
}
# }

function dd {
 param (
 [string]$file
 ) 

  $filename = $file -replace '^\.\\', ''
 $confirmed = $false
 while ($confirmed -eq $false) {
   Write-Host "Delete $($filename)" -BackgroundColor Red -ForegroundColor White
   $confirm = Read-Host "Are you sure? (yes/no)"
   if ($confirm.ToLower() -eq 'yes') {
     $confirmed = $true
     Remove-Item $file
   }
   elseif ($confirm.ToLower() -eq 'no') {
     $confirmed = $true
     break
   }
 }
}

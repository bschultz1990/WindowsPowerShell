function cc {
  ls $dl
  Write-Host
  $response = Read-Host "Continue? [y, n]"
  while ($response.ToLower() -notin @('y', 'n')) {
    $response = Read-Host "Correct responses are either 'Y' or 'N': "
  }
  if ($response.ToLower() -eq "y") {
    rm *.pdf
    python "C:\Users\bschul3\OneDrive - VFC Corp\Documents\international_invoices.py"
    mv $dl/*stamped* .
    rm $dl/*.pdf
    ls $dl
  }
  else {
    return
  }
}

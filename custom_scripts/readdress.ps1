function readdress {
  $server_dir = Get-Location
    $dl = "C:\Users\bschul3\Downloads"
    foreach ($invoice in (Get-ChildItem *stamped*.pdf)){
      $dlinvoice = (Join-Path -Path $dl -ChildPath $invoice.Name)
        Move-Item $invoice $dl
        open $dlinvoice
        Write-Host "Press Enter to continue..."
        Read-Host
        cpdf -add-text "1551 Wewetta St.\nDenver, CO 80202" -topleft "20 105" -font "Helvetica" -font-size 8 $dlinvoice -o $dlinvoice

        cpdf -stamp-under "C:\Users\bschul3\OneDrive - VFC Corp\Documents\watermarks\TNF Stamp - SD.pdf" $dlinvoice ~1 -o $dlinvoice
        cp $dlinvoice $dl/sendme
        Move-Item $dlinvoice $server_dir
    }
}

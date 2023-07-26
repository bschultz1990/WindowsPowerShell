function checklist_general {
    Clear-Host
    Write-Host "=== Invoice Checklist ===`n"
    "[ ] Run Python`n" +
    "[ ] NGC Numbers moved on all pages`n" +
    "[ ] Delete footers from middle pages`n" +
    "[ ] Page numbers correct`n" +
    "[ ] Total value`n" +
    "[ ] Total Qty/Pcs from official PL`n" +
    "[ ] Total Cartons/Pkg from official PL`n" +
    "[ ] Net Wt. from official PL`n" +
    "[ ] Gross wt. from BL or AWB`n" +
    "[ ] Add 'Confirmed BJS' to inovice file and send`n"
}


function checklist_kipling {
    Clear-Host
    Write-Host "=== Kipling Checklist ===`n"
    "[ ] Combine invoices with the same IMP from request email`n" +
    "[ ] Variable Value, Total $ EUR, Gross Amt, Net Amt, Grand Total from request email`n" +
    "[ ] Add to document headers: CNPJ 04.411.431/0001-00`n" +
    "[ ] Net / Gross weight from NGC hub`n" +
    "[ ] Cartons from NGC hub`n" +
    "[ ] Incoterms: FCA Free Carrier `n" +
    "[ ] Port of Loading: Abbreviation from NGC. Full name to invoice.`n" +
    "[ ] Port of Discharge: Vitoria, Brazil`n" +
    "[ ] IMP: #0000 from request email`n" +
    "[ ] Vendor: `n" +
    "[ ] Stamp and send to ederlon.silva@grupoaste.com.br`n"
}

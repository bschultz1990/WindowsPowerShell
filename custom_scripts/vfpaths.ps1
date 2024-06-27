if ([System.Environment]::MachineName -ne "FALCON-II")
{
  $altra_lotus_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1034 Altra\Lotus Corp - Japan 10743817\Invoices\2024"
  $apps = "C:\Users\bschul3\Apps"
  $attachments = "~\OneDrive - VFC Corp\Attachments"
  $cpdf = "C:\Users\bschul3\Apps\cpdf.exe"
  $dll = "\\Client\C$\Users\bschul3\Downloads"
  $document_requests = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\Library\Scripts\document_requests.py"
  $dtl = "\\Client\C$\Users\bschul3\Desktop"
  $fileme = "C:\Users\bschul3\Documents\python\fileme\fileme.py"
  $fileme_dir = "C:\Users\bschul3\Documents\python\fileme\"
  $invoices = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit"
  $invscript = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\international_invoices.py"
  $invscript_server = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\Library\international_invoices.py"
  $jansport_ali_abdulwahab = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1001 JanSport\Ali Abdulwahab Al Mutawa - Kuwait 80010809\Invoices"
  $jansport_forus_2024 = "\\jsap2nfiler1\jsap_data\sharedir\Credit\International\1001 JanSport\Forus - Chile 80008794\Invoices\2024"
  $jansport_musinsa_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1001 JanSport\Musinsa Trading - South Korea - 80074804\Invoices\2024"
  $jansport_primer_philippines = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1001 JanSport\Primer - Philippines 80004057\Invoices\2024"
  $jansport_save_2024 = "\\jsap2nfiler1\jsap_data\sharedir\Credit\International\1001 JanSport\SAVE Comercial Aste - Brazil 80004744\Invoices\2024"
  $jansport_smashtrading_2024 = "\\jsap2nfiler1\jsap_data\sharedir\Credit\International\1001 JanSport\Smash Trading - Egypt 80011657\Invoices\2024"
  $kipling_brazil_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\9999 Kipling\Comercial Aste E Importadora - Brazil\Invoices\2024"
  $kipling_columbia_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\9999 Kipling\Estudio De Moda SAS - Colombia\Invoices\2024"
  $library = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\Library"
  $library_local = "C:\Users\bschul3\OneDrive - VFC Corp\Library"
  $lookitup = "C:\Users\bschul3\Documents\python\lookitup\lookitup.py"
  $notes_vfc = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Notes"
  $onedrive_vfc = "C:\Users\bschul3\OneDrive - VFC Corp\Documents"
  $paths = "C:\Users\bschul3\Documents\WindowsPowerShell\custom_scripts\vfpaths.ps1"
  $process_inv = "~\OneDrive - VFC Corp\Documents\Library\Processing Invoices Emailed to VFOD Intl Docs.pdf"
  $screenshots = "C:\Users\bschul3\OneDrive - VFC Corp\Pictures\Screenshots"
  $smartwool_cerrotorre_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1008 Smartwool\Cerrotorre - South Korea 80072557\Invoices\2024"
  $smartwool_lostarrow_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1008 Smartwool\Lost Arrow -Japan 80032148\Invoices\2024"
  $smartwool_lostarrow_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\LOST ARROW"
  $smartwool_oda_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1008 Smartwool\Outdoor Agency - Australia 80070847\Invoices\2024"
  $smartwool_starlike_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1008 Smartwool\Starlike - Taiwan 80061867\Invoices\2024"
  $smartwool_starlike_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\STARLIKE"
  $stamp_altra = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Altra.pdf"
  $stamp_pro_to_comm = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\watermarks_custom\stamp_proforma_to_commercial.pdf"
  $stamp_jansport = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\JanSport.pdf"
  $stamp_kipling = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Kipling.pdf"
  $stamp_smartwool = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Smartwool.pdf"
  $stamp_timberland = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Timberland.pdf"
  $stamp_tnf = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\TNF.pdf"
  $stamp_vans_invoice = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Vans.pdf"
  $stamp_vans_pl = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\Stamps\pdf\Vans_PL.pdf"
  $tnf_adoc_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1003 TNF\ADOC\Invoices\2024"
  $tnf_comercial_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\TNF COMERCIAL E IMPORTADORA LTDA"
  $tnf_grimoldi_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1003 TNF\Grimoldi - Argentina 10757570\Invoices\2024"
  $tnf_grimoldi_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMOLDI\TNF"
  $tnf_justus_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1003 TNF\Just Us S.A\Invoices & Documents\2024"
  $tnf_justus_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\JUSTUS"
  $tnf_komax_chile_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1003 TNF\Groupo Axo\Komax SA - Chile 80001904\Invoices\2024"
  $tnf_komax_peru_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1003 TNF\Groupo Axo\Komax - Peru 80012221\Invoices\2024"
  $vans_arezzo_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1005 Vans\Arezzo - Brazil 10779997\Invoices\2024"
  $vans_arezzo_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\AREZZO"
  $vans_forus_2024 = "\\jsap2nfiler1\jsap_data\sharedir\Credit\International\1005 Vans\Forus - Chile 10780157\Invoices\2024"
  $vans_grimoldi_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1005 Vans\Grimoldi - Argentina 10757570\Invoices\2024"
  $vans_grimoldi_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMOLDI\VANS\"
  $vans_grimuru_2024 = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\1005 Vans\Grimuru - Uruguay 10761571\Invoices\2024"
  $vans_grimuru_edit = "\\jsap2nfiler1\jsap_data\Sharedir\Credit\International\- Invoices to Edit\GRIMURU"
  $watermark_arezzo_sample = "C:\Users\bschul3\OneDrive - VFC Corp\Documents\watermarks_custom\Arezzo Sample Addresses.pdf"
  $weights = "C:\Users\bschul3\Documents\weights\weights\weights.py"
}

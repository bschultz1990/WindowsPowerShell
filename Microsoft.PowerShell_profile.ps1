$custom_scripts = "C:\Users\bschul3\Documents\WindowsPowerShell\custom_scripts"

$custom_scripts = Get-ChildItem -Path "$custom_scripts" -Filter "*.ps1"
foreach ($script in $custom_scripts) {
  . $script.FullName
}
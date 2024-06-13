foreach ($script in (Get-Item "\\Client\C$\Users\bschul3\Documents\WindowsPowerShell\custom_scripts\*.ps1")) {
        . $script.FullName
        }

# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
# irm get.scoop.sh | iex
# scoop bucket add exras

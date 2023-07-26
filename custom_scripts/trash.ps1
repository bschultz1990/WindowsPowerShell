function trash {
  [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromRemainingArguments = $true)]
        [String[]]$files
        )
      Remove-ItemSafely $files
}

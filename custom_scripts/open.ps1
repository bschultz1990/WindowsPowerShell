function open {
  param (
      [CmdletBinding()]
      [Parameter(Mandatory = $true, position = 0, ValueFromRemainingArguments = $true)]
      [String[]]$files
      )
    Invoke-Item $files
}

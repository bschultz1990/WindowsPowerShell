function getdir {
  Set-Clipboard $pwd
    $full_path = Get-Clipboard
    $prefix = "Microsoft.PowerShell.Core\FileSystem::"
    return $full_path.Replace($prefix, "")
}

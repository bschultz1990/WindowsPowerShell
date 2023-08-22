function cwd {
  Set-Clipboard $((Get-Item .).fullname)
  return
}

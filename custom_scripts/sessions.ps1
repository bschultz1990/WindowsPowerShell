function sessions
{
  Set-Location $docs/vim_sessions/

  if (Test-Path -Path "./neovide_backtraces.log")
  {
    Remove-Item neovide_backtraces.log 
  }

  if (Get-Command neovide -errorAction SilentlyContinue)
  {
    neovide +source $(fzf)
  } else
  {
    nvim -S $(fzf) 
  }
}

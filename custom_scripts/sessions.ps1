function sessions {
  Set-Location $docs/vim_sessions/
  nvim -S $(fzf)
}

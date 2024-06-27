function notes {
  Set-Location ~\Documents\notes
  git pull
  #nvim +"Telescope live_grep""
  nvim +"Telescope find_files"
}

function notes
{
  #TODO: Add a list of programs. Loop through them and check to see if they exist.
  #If not, display an error message like the one below with the program's name.
  if (!(Get-Command -Name gh -ErrorAction SilentlyContinue))
  {
    Write-Host "'gh' is not available. Please install 'gh' and try again."
    exit
  }
  if (!( Test-Path ~\Documents\notes))
  {
    Set-Location ~\Documents
    gh repo clone notes
  }
  else { Set-Location ~\Documents\notes }

  git pull
  nvim +"Telescope find_files"
}

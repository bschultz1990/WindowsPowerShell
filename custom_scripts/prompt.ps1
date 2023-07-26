#Only display the last two directories in the prompt
function prompthelper {
  $short_dir = $pwd.Replace('Microsoft.PowerShell.Core\FileSystem::', '')
  return $short_dir
}

function Prompt {
  return "$pwd`r`n> "
}


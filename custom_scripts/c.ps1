function c
{
  param(
    [string]$directory
  )
  Clear-Host
  Set-Location $directory
  Get-ChildItem -Name
}

function b
{
  param(
    [string]$directory
  )
  Set-Location ..
  Clear-Host
  Get-ChildItem -Name
}

function q
{
  Clear-Host
}

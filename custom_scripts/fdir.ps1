function fdir ($dir) {
	c (fd $dir --type directory | fzf)
}

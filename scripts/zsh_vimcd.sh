vimcd () {
	vim "$1/$(basename "${@:2}")"
}

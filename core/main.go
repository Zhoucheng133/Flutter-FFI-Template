package main

import "C"
import "core/utils"

//export Add
func Add(a, b C.int) C.int {
	return C.int(utils.Add(int(a), int(b)))
}

//export Concat
func Concat(a, b *C.char) *C.char {
	return C.CString(utils.Concat(C.GoString(a), C.GoString(b)))
}

func main() {}

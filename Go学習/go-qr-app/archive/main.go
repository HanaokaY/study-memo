package main

import (
	"fmt"
	"flag"
)

func main() {
	flag.Parse()
	arg := flag.Arg(1)
	fmt.Printf("Hello %s\n", arg)
}

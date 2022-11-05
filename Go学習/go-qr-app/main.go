package main

import (
	"flag"
    "fmt"
	"os"
)

func main() {    
	flag.Parse()
	msg := fmt.Sprintf("Hello %s\n", flag.Arg(0))

	f, err := os.Create("./hello.txt")
	if err != nil {
		fmt.Printf("failed to create file \n: %v", err)
		return
	}
	defer f.Close()
	// defer fmt.Println("mianの処理が全部終わったあとに呼ばれる")

	_, err = f.WriteString(msg) // ここでは変数の宣言ではなく、代入しているから:=ではなく、ただの=
	if err != nil{
		fmt.Printf("failed to write message to file \n: %v", err)
		return
	}

	fmt.Println("Done!")
}


package main

import "fmt"

func main() {
    a := 5

    var pa *int // int型を格納する領域のアドレスを格納する準備
    pa = &a     // &a = aのアドレス

    // paの領域にあるデータの値 = *pa
    fmt.Println(pa)  // 0xc420018078
    fmt.Println(*pa) // 5
}
package main

import (
    "fmt"
)

func main() {    
	a := "hello"
	fmt.Println(&a)
	// &というキーワードが「値のポインタ(メモリアドレス)を取得する」という演算子
}


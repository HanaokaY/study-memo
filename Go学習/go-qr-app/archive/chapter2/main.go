package main

import("fmt")

type User struct {
	id   string
	name string
	age  int
}

func (u *User) IncrementAge() {
	u.age++ // intなどの数字系の値をインクリメント(+1)する処理
}

func main() {
	user := &User{ // &をつけることでポインタ型になる
		id:   "1",
		name: "John Lennon",
		age:  30,
	}

	user.IncrementAge()
	fmt.Println(user.age)
	// => 31
}

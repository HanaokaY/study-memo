// 変数
    // let => 再宣言不可、上書き可
    // const => 再宣言不可、上書き不可

let word = "user";
word = "hello"; //これは可能
// let word = "user2"; //これは不可能

// constに関しては、オブジェクトの中身は変更が可能になっている
const obj = {
    name: "はな",
    age: 26
};

obj.name = 'さいとう'; //constであっても、オブジェクトの中身の変更は可能になっている

const arr = [1,2,3,4]
arr[0] = 100 //配列の場合もconstであっても変更可能
// console.log(arr);

// 上記の結果から、オブジェクトと配列にはconstを使っていこうというふうになっている


// Reactではほぼconstを使用。処理の中で値を上書きしていくような変数に対しては、letを使用することになっている


const name = 'はなおか';

const message = `私の名前は${name}です。`
// console.log(message);

function get_name() {
    return "はなおか";
}

// console.log(get_name());


// アロー関数 新しい関数の記法
const func1 = (val) => { return val; };

// console.log(func1("arrow"));

// 引数が一つならカッコを省略
const fun2 = val => { return "引数一つ" };
// console.log(fun2("a"));

// ワンライナー、単一の処理で済むなら波括弧とリターンすら省略出来る。
const fun3 = (val1,val2) => val1 + val2
// console.log(fun3(3,3));

// 複数行のリターンは()で囲む必要がある
const fun4 = (name,age) => ({
    name: name,
    age: age
})

// console.log(fun4("hana",26)); // => { name: 'hana', age: 26 }


// 分割代入

// オブジェクトの場合
const obj1 = {
    name: "名前",
    age: 100
}
// 通常のプロパティの呼び出し方
// console.log(`${obj1.age}の${obj1.name}です。`);
const {name: his_name, age: his_age} = obj1;
// console.log(`${his_name}と${his_age}`);

// 分割代入はReactではよく使うらしいから覚える

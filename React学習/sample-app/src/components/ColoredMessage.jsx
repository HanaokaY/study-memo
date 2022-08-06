// export const ColoredMessage = (props) => {
//     const contentBlueStyle = {
//         color: props.color,
//         fontSize: "20px"
//     };
//     return <p style={contentBlueStyle}>{props.children}</p>
// };

// jsの分割代入と省略記法を使ったテクニック
// よく使われるらしい

// まずは分割代入により、毎回props.〜と記述しなくていいようにする。
// export const ColoredMessage = (props) => {
//     const {color,children} = props; // 追加
//     const contentBlueStyle = {
//         color: color, // 追加
//         fontSize: "20px"
//     };
//     return <p style={contentBlueStyle}>{children}</p> // 追加
// };

// さらに、分割代入したことにより省略記法を使用することが可能になった。

// export const ColoredMessage = (props) => {
//     const {color,children} = props;
//     const contentBlueStyle = {
//         color, // プロパティ名と設定値が同一の場合、設定値のみに省略することが可能になる。
//         fontSize: "20px"
//     };
//     return <p style={contentBlueStyle}>{children}</p>
// };


// 引数の段階で分割代入と省略記法どちらもできる

export const ColoredMessage = ({color,children}) => { // そもそも引数にはpropsが渡ってきているから、この段階でも可能
    const contentBlueStyle = {
        color,
        fontSize: "20px"
    };
    return <p style={contentBlueStyle}>{children}</p>
};

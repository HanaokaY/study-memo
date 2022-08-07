// import logo from './logo.svg';
// import './App.css';

// function App() {
//   return (
//     <div className="App">
//       <header className="App-header">
//         <img src={logo} className="App-logo" alt="logo" />
//         <p>
//           Edit <code>src/App.js</code> and save to reload.
//         </p>
//         <a
//           className="App-link"
//           href="https://reactjs.org"
//           target="_blank"
//           rel="noopener noreferrer"
//         >
//           Learn React
//         </a>
//       </header>
//     </div>
//   );
// }

// export default App;

// 多分、上記の定義方法はES5ってやつかな？
// 下記のがES6かな

import { ColoredMessage } from "./components/ColoredMessage";
import { useState } from "react"; // state hooksの機能群から使用

export const App = () => {

  const [num,setNum] = useState(0);

  const onClickButton = () => {
    setNum((num) => num + 1); // numの値に基づいてnumを更新するという意味で、この記述の仕方が正しい。
  };
  return(
    <>
      <ColoredMessage color="red">children</ColoredMessage>
      <ColoredMessage color="green">children2</ColoredMessage>
      <button onClick={onClickButton}>ボタン</button>
      <p>{num}</p>
    </>
  );
};

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

export const App = () => {
  const onClickButton = () => {
    alert();
  };
  return(
    <>
      <ColoredMessage color="blue" message="propsで渡したテスト"/>
      <ColoredMessage color="green" message="propsで渡したテスト"/>
      <button onClick={onClickButton}>ボタン</button>
    </>
  );
};

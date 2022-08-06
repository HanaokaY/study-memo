import ReactDom from 'react-dom';

const App = () => {
  return(
    <>
      <h1>hello</h1>
      <p>japan</p>
    </>
    // 空の<>で囲むのはフラグメントというらしい。別方法として、Fragmentをimportする方法もある
  );
};

ReactDom.render(<App/>,document.getElementById("root"));



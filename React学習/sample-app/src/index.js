import ReactDom from 'react-dom';
// import App from './App.js'; // ES5だと{}を記述しなくてもいいのかも
import { App } from './App.jsx';



ReactDom.render(<App/>,document.getElementById("root"));



import ReactDom from 'react-dom';
// import App from './App.js'; // ES5だと{}を記述しなくてもいいのかも <= 間違ってた。下記に記述
import { App } from './App.jsx';

ReactDom.render(<App/>,document.getElementById("root"));


// exportの種類は二種類ある
// export const SomeComponent = () => {}; なら、import { SomeComponent } from "./SomeComponent";
// const SomeComponent = () => {}; export default SomeComponent なら、import SomeComponent from "./SomeComponent";
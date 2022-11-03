import { memo } from "react"; // memoを使用するだけでpropsに変更がない限り再レンダリングが起きない

const style = {
  height: "50px",
  backgroundColor: "lightgray",
};

export const Child2 = memo(() => {
  console.log("Child2 レンダリング ");

  return (
    <div style={style}>
      <p>Child2</p>
    </div>
  );
});


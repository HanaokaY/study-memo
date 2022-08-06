export const ColoredMessage = (props) => {
    const contentBlueStyle = {
        color: props.color,
        fontSize: "20px"
    };
    return <p style={contentBlueStyle}>{props.message}</p>
};
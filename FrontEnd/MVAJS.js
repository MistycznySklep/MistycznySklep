window.onload = () => {
    let firstInput = document.querySelector("input");
    if (firstInput) {
        firstInput.focus();
    }
};

document.querySelectorAll("input").forEach((input, index, inputs) => {

    input.addEventListener("input", () => {
        let nextInput = inputs[index + 1];

       
        while (nextInput && nextInput.value.length === 1) {
            nextInput = inputs[index + 2];
            index++;
        }

        if (nextInput) {
            nextInput.focus();
        }
    });


    input.addEventListener("click", () => {
        let nextInput = inputs[index + 1];

        while (nextInput && nextInput.value.length === 1) {
            nextInput = inputs[index + 2];
            index++;
        }

        if (nextInput) {
            nextInput.focus();
        }
    });
});

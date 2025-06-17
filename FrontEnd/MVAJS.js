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
        } else {
            let code = "";
            inputs.forEach(element => {
                code += element.value;
            });
            fetch("/api/verifyMFA.php", {
                headers: {
                    "Content-Type": "application/json",
                    Authorization: sessionStorage.getItem("mfa")
                },
                method: "POST",
                body: JSON.stringify({ code })
            }).then(async response => {
                if (response.ok) {
                    const json = await response.json();
                    localStorage.setItem("token", json.token);
                    location.href = "index.html";
                } else location.href = "login.html";
            });
        }
    });


    input.addEventListener("click", () => {
        let nextInput = inputs[index];

        while (nextInput && nextInput.value.length === 1) {
            nextInput = inputs[index + 2];
            index++;
        }

        if (nextInput) {
            nextInput.focus();
        }
    });
});

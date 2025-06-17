window.onload = () => {
    let firstInput = document.querySelector("input");
    if (firstInput) {
        firstInput.focus();
    }

    API.AuthPost("/api/beginSetupMFA.php")
        .then(r => r.json())
        .then(data => {
            document.getElementById("nextStep").disabled = false;
            document.getElementById("mfaSecret").value = data.secret;
            document.getElementById("mfaQr").src = data.qr_url;
        });
};

document.getElementById("nextStep").onclick = async () => {
    document.getElementById("nextStep").disabled = true;
    document.getElementById("setupMFA").style.display = "none";
    document.getElementById("finishMFA").style.display = "flex";
}

document.getElementById("goBack").onclick = async () => {
    document.getElementById("nextStep").disabled = false;
    document.getElementById("setupMFA").style.display = "flex";
    document.getElementById("finishMFA").style.display = "none";
}

document.querySelector(".MFASetup").querySelectorAll("input").forEach((input, index, inputs) => {

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
                element.disabled = true;
            });
            API.AuthPost("/api/finishSetupMFA.php", { code })
                .then(r => {
                    if (r.ok) {
                        document.getElementById("setupMFA").style.display = "none";
                        document.getElementById("finishMFA").style.display = "none";
                        document.getElementById("success").style.display = "flex";
                        let counter = 3;
                        document.getElementById("counter").textContent = `${counter} sekund`;
                        let interval = setInterval(() => {
                            if (--counter <= 0) {
                                clearInterval(interval);
                                location.href = "index.html";
                            }
                            document.getElementById("counter").textContent = counter === 1 ? "1 sekundę" : `${counter} sekund`;
                        }, 900);
                    }
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

let loginForm = document.getElementById("loginForm");
const errorText = document.getElementById("errorText");
let labelForm = document.querySelectorAll("label");
let inputsForm = document.querySelectorAll("input");
let form = document.getElementById("registerForm");
let button = document.querySelector(".wyslij")

button.onclick = (e) => {
    Checker(e)
}
inputsForm.forEach(input => {
    input.addEventListener('focus', () => InputFocused(input));
});

function InputFocused(input) {
    let InputName = input.name;
    let label;
    if (InputName) {

        label = document.querySelector(`label[for="${input.name}"]`)
        if (label) {
            label.style.color = "#b169a7";
            input.addEventListener('blur', function zmianaKolorka() {
                label.style.color = "";
                // label.style.color = label.dataset.originalColor || "";
                input.removeEventListener('blur', zmianaKolorka);
            });
        }
    }
}


function ResetColorInAprovedInput(approvedInput) {
    approvedInput.style.boxShadow = "0 0 3px #00000026";
}
function EmptyInputAproved(approvedInputs) {
    // console.log(approvedInputs)
    // approvedInputs.forEach(approvedInput => {
    // approvedInput.style.boxShadow = "box-shadow: 0px 3px 5p #00000026" 
    // })
    if (approvedInputs.length === 1) {
        let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
        ResetColorInAprovedInput(approvedInput)

    } else if (approvedInputs.length === 2) {
        let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
        let approvedInput2 = document.querySelector(`[name=${approvedInputs[1].name}]`)

        ResetColorInAprovedInput(approvedInput)
        ResetColorInAprovedInput(approvedInput2)
    }
    else if (approvedInputs.length === 3) {
        let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
        let approvedInput2 = document.querySelector(`[name=${approvedInputs[1].name}]`)
        let approvedInput3 = document.querySelector(`[name=${approvedInputs[2].name}]`)

        ResetColorInAprovedInput(approvedInput)
        ResetColorInAprovedInput(approvedInput2)
        ResetColorInAprovedInput(approvedInput3)

    }
    else if (approvedInputs.length === 4) {
        let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
        let approvedInput2 = document.querySelector(`[name=${approvedInputs[1].name}]`)
        let approvedInput3 = document.querySelector(`[name=${approvedInputs[2].name}]`)
        let approvedInput4 = document.querySelector(`[name=${approvedInputs[3].name}]`)

        ResetColorInAprovedInput(approvedInput)
        ResetColorInAprovedInput(approvedInput2)
        ResetColorInAprovedInput(approvedInput3)
        ResetColorInAprovedInput(approvedInput4)

    }
}
function ErrorInputColor(emptyInput) {
    emptyInput.style.boxShadow = "0 0 3px 3px rgb(227, 56, 56)";
    // console.log(emptyInput.name)
    let emptyLabel = document.querySelector(`label[for="${emptyInput.name}"]`)
    ErrorLabelColor(emptyLabel)


}
function ErrorLabelColor(emptyLabel) {
    emptyLabel.style.color = "rgb(227, 56, 56)";
}

function EmptyInputError(inputsNames) {
    if (inputsNames.length === 1) {

        let emptyInput = document.querySelector(`[name="${inputsNames[0].name}"]`)

        ErrorInputColor(emptyInput)
        errorText.innerHTML = `uzupełnij pole ${inputsNames[0].name}`;

    } else if (inputsNames.length === 2) {
        let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
        let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
        ErrorInputColor(emptyInput1)
        ErrorInputColor(emptyInput2)

        errorText.innerHTML = `uzupełnij pole ${inputsNames[0].name} i ${inputsNames[1].name}`;

    } else if (inputsNames.length === 3) {
        let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
        let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
        let emptyInput3 = document.querySelector(`[name="${inputsNames[2].name}"]`)
        ErrorInputColor(emptyInput1)
        ErrorInputColor(emptyInput2)
        ErrorInputColor(emptyInput3)

        errorText.innerHTML = `uzupełnij pole ${inputsNames[0].name}, ${inputsNames[1].name} i ${inputsNames[2].name}`;

    } else if (inputsNames.length === 4) {
        let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
        let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
        let emptyInput3 = document.querySelector(`[name="${inputsNames[2].name}"]`)
        let emptyInput4 = document.querySelector(`[name="${inputsNames[3].name}"]`)
        ErrorInputColor(emptyInput1)
        ErrorInputColor(emptyInput2)
        ErrorInputColor(emptyInput3)
        ErrorInputColor(emptyInput4)

        textError.innerHTML = `uzupełnij pole ${inputsNames[0].name}, ${inputsNames[1].name}, ${inputsNames[2].name}, i ${inputsNames[3].name}`;

    } else {
        console.log("a")
    }
}

async function Checker(e) {
    e.preventDefault();

    // console.log("a")
    let emptyInputs = [];
    let approvedInputs = [];

    inputsForm.forEach(input => {
        let inputElement = document.querySelector(`[name="${input.name}"]`);

        if (inputElement && (inputElement.value === "" || !inputElement.checkValidity())) {
            emptyInputs.push(input);

        } else if (inputElement && (inputElement.value !== "" && inputElement.checkValidity())) {
            approvedInputs.push(input)
        }
    });
    console.log("Kod się wykonuje");
    if (emptyInputs.length > 0) {

        EmptyInputAproved(approvedInputs);
        EmptyInputError(emptyInputs);
    } else {
        const login = document.getElementById("inputLogin").value;
        const password = document.getElementById("inputPassword").value;
        const loginResponse = await fetch("/api/login.php", {
            method: "POST",
            body: JSON.stringify({ login, password }),
            headers: {
                "Content-Type": "application/json"
            }
        });

        const json = await loginResponse.json();

        if (!loginResponse.ok) {
            if (loginResponse.status === 401 && json.mfa) {
                sessionStorage.setItem("mfa", json.mfa);
                location.href = "MFA.html";
                return;
            }
            errorText.textContent = "Zły login lub haslo";
            return;
        }
        localStorage.setItem("token", json.token);
        location.href = "index.html";
    }
}

let errorDiv = document.querySelector(".error")
let textError = document.querySelector("p")
let form = document.querySelector("form")

let emptyInputNum = 0;

form.addEventListener("submit", Checker)

inputsForm = [ 
    {name: "login", type: "text", content: "Login"},
    {name: "username",type: "text", content: "Nazwa użytkownika"},
    {name: "email", type: "email", content: "Email"},
    {name: "password", type: "password", content: "Hasło"}

]
function ResetColorInAprovedInput(approvedInput){
    approvedInput.style.boxShadow = "0 0 3px #00000026"; 
}
function EmptyInputAproved(approvedInputs){
    console.log(approvedInputs)
    
    // approvedInputs.forEach(approvedInput => {
        // approvedInput.style.boxShadow = "box-shadow: 0px 3px 5p #00000026" 
        // })
        if(approvedInputs.length === 1){
        let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
        ResetColorInAprovedInput(approvedInput)    

   }else if(approvedInputs.length === 2){
    let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
    let approvedInput2 = document.querySelector(`[name=${approvedInputs[1].name}]`)

    ResetColorInAprovedInput(approvedInput)    
    ResetColorInAprovedInput(approvedInput2)    
}
else if(approvedInputs.length === 3){
    let approvedInput = document.querySelector(`[name=${approvedInputs[0].name}]`)
    let approvedInput2 = document.querySelector(`[name=${approvedInputs[1].name}]`)
    let approvedInput3 = document.querySelector(`[name=${approvedInputs[2].name}]`)
    
    ResetColorInAprovedInput(approvedInput)    
    ResetColorInAprovedInput(approvedInput2)   
    ResetColorInAprovedInput(approvedInput3)   
    
}
else if(approvedInputs.length === 4){
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
function ErrorInputColor(emptyInput){
    emptyInput.style.boxShadow = "0 0 3px 3px #ff0000";
    // console.log(emptyInput.name)
    let emptyLabel = document.querySelector(`label[for="${emptyInput.name}"]`)
    ErrorLabelColor(emptyLabel)

    
}
function ErrorLabelColor(emptyLabel){
    emptyLabel.style.color = "#ff0000"; 
}

function EmptyInputError(inputsNames) {
   if(inputsNames.length === 1){

        let emptyInput = document.querySelector(`[name="${inputsNames[0].name}"]`)

        ErrorInputColor(emptyInput)
       textError.textContent = `uzupełnij pole ${inputsNames[0].name}`;

   }else if(inputsNames.length === 2){
    let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
    let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
    ErrorInputColor(emptyInput1)
    ErrorInputColor(emptyInput2)

    textError.textContent = `uzupełnij pole ${inputsNames[0].name} i ${inputsNames[1].name}`;

   }else if(inputsNames.length === 3){
    let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
    let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
    let emptyInput3 = document.querySelector(`[name="${inputsNames[2].name}"]`)
    ErrorInputColor(emptyInput1)
    ErrorInputColor(emptyInput2)
    ErrorInputColor(emptyInput3)

    textError.textContent = `uzupełnij pole ${inputsNames[0].name}, ${inputsNames[1].name} i ${inputsNames[2].name}`;

   }else if(inputsNames.length === 4){
    let emptyInput1 = document.querySelector(`[name="${inputsNames[0].name}"]`)
    let emptyInput2 = document.querySelector(`[name="${inputsNames[1].name}"]`)
    let emptyInput3 = document.querySelector(`[name="${inputsNames[2].name}"]`)
    let emptyInput4 = document.querySelector(`[name="${inputsNames[3].name}"]`)
    ErrorInputColor(emptyInput1)
    ErrorInputColor(emptyInput2)
    ErrorInputColor(emptyInput3)
    ErrorInputColor(emptyInput4)
    
    textError.textContent = `uzupełnij pole ${inputsNames[0].name}, ${inputsNames[1].name}, ${inputsNames[2].name}, i ${inputsNames[3].name}`;

   }

    
}
function Checker(event) {

       

        let emptyInputs = [];
        let approvedInputs = [];
        
        inputsForm.forEach(input => {
            let inputElement = document.querySelector(`[name="${input.name}"]`);
            if (inputElement && inputElement.value === "") {
                emptyInputs.push(input);
                
            }else if(inputElement && inputElement.value !== "" && inputElement.checkValidity()){
                approvedInputs.push(input)
            }
        });
        if (emptyInputs.length > 0) {
            if (event && typeof event.preventDefault === "function") {
                event.preventDefault();
            }
            EmptyInputAproved(approvedInputs);
            EmptyInputError(emptyInputs);
        }else
        {
            
            return true;
        }
    
}
    
    


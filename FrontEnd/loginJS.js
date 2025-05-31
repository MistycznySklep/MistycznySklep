let labelForm = document.querySelectorAll("label")
let inputsForm = document.querySelectorAll("input")

inputsForm.forEach(input => {
    input.addEventListener('focus', () => InputFocused(input));
});

// }      -------- jestem geniuszem i dopiero ogarnąłem że nie trzeba w ifie przypisywać konkretnej wartości tylko można sprawdzić czy istnieje XDDDDDDDDD     --------------

// function InputFocused(input){



//     let InputName = input.name;
//     let label;
//     if(InputName === "login"){
        
//         label = document.querySelector(`label[for="${input.name}"]`)
//         if(label){
//             label.style.color = "#b169a7";
//             input.addEventListener('blur', function zmianaKolorka() {
//                 label.style.color = "";
//                 input.removeEventListener('blur', zmianaKolorka);
//             });
               
//         }
//     }else if(InputName === "password"){
//         label = document.querySelector(`label[for="${input.name}"]`)
//         if(label){
//             label.style.color = "#b169a7"
//             input.addEventListener('blur', function powrotKolorka() {
//                 label.style.color = "";
//                 input.removeEventListener('blur', powrotKolorka);
//             });
//         }
//     }
    


function InputFocused(input){



    let InputName = input.name;
    let label;
    if(InputName){
        
        label = document.querySelector(`label[for="${input.name}"]`)
        if(label){
            label.style.color = "#b169a7";
            input.addEventListener('blur', function zmianaKolorka() {
                label.style.color = "";
                // label.style.color = label.dataset.originalColor || "";
                input.removeEventListener('blur', zmianaKolorka);
            });
               
        }
    }


}


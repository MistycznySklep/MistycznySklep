let loginForm = document.getElementById("loginForm")
let labelForm = document.querySelectorAll("label")
let inputsForm = document.querySelectorAll("input")

inputsForm.forEach(input => {
    input.addEventListener('focus', () => InputFocused(input));
});


    


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



// loginForm.onsubmit = async e => {
  
//     e.preventDefault();
//      const username = document.querySelector("inputLogin").value;
//      const password = document.querySelector("inputPassword").value;
//      const loginResponse = await fetch("/api/login.php", {
//           method: "POST",
//           body: JSON.stringify({ username, password }), 
//           headers: {
//                "Content-Type": "application/json"
//           }
        
//      });

//      console.log(123)
//      console.log(loginResponse.ok)
//      if (!loginResponse.ok) {
//           errorText.textContent = "Zly login lub haslo";
//           return;
//      }
//      const json = await loginResponse.json();
//      localStorage.setItem("token", json.token);
// };
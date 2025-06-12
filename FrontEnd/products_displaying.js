
const ShopContainer = document.querySelector(".plants")

window.onload = async () => {
    const response = await API.GetProductList()
    console.log(response)
    let x = 0;
    while(response[x]){
        const productDiv = document.createElement('div')
        productDiv.classList.add("ShopElement")
        ShopContainer.appendChild(productDiv)
        const productImg = document.createElement('img')
        productImg.classList.add("ShopElementIMG")
        productDiv.appendChild(productImg)
        const product = response[x]
        productImg.src = `/api/image.php?id=${product.idImgs}`
        const productH2 = document.createElement('h2')
        productH2.textContent = response[x].name
        productDiv.appendChild(productH2)
        const productDescDiv = document.createElement('div')
        productDescDiv.classList.add("ShopQuickDescDiv")
        productDiv.appendChild(productDescDiv)
        const productDesc = document.createElement('p')
        productDescDiv.appendChild(productDesc)
        productDesc.textContent = response[x].description
        // console.log(productH2)
        const productCategory = document.createElement('h2')
        const productCategoryName = response[x].type
        productCategory.textContent = `Kategoria: ${productCategoryName}` 
        productDiv.appendChild(productCategory)
        const productQuantity = document.createElement('h3')
        productDiv.appendChild(productQuantity)
        // const productQuantityValue = response[x].quantity
        // console.log(productQuantityValue)
        // productQuantity.appendChild(productQuantityValue)
        // productQuantity.textContent = `Kategoria: ${productQuantityValue}` 
        // x++;
    
        
    }
};
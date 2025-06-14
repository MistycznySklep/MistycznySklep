const ShopContainer = document.querySelector(".plants");

window.onload = async () => {
    const response = await API.GetProductList();
    console.log(response);

    for (const product of response) {
        const productDiv = document.createElement("div");
        productDiv.classList.add("ShopElement");
        ShopContainer.appendChild(productDiv);

        const productImg = document.createElement("img");
        productImg.classList.add("ShopElementIMG");
        productImg.src = `/api/image.php?id=${product.idImgs}`;
        productImg.alt = "";
        productDiv.appendChild(productImg);

        const productName = document.createElement("h2");
        productName.style.color = product.hexColor;
        productName.textContent = product.name;
        productDiv.appendChild(productName);

        const descDiv = document.createElement("div");
        descDiv.classList.add("ShopQuickDescDiv");
        const descP = document.createElement("p");
        descP.textContent = product.description;
        descDiv.appendChild(descP);
        productDiv.appendChild(descDiv);

        const category = document.createElement("h2");
        category.textContent = `Kategoria: ${product.type}`;
        productDiv.appendChild(category);

        const stock = document.createElement("h3");
        stock.textContent = `Liczba w magazynie: ${product.quantity}`;
        productDiv.appendChild(stock);

        const price = document.createElement("h3");
        price.innerHTML = `<i>Cena: ${product.price} zł</i>`;
        productDiv.appendChild(price);

        productDiv.appendChild(document.createElement("br"));

        const actionFlex = document.createElement("div");
        actionFlex.classList.add("fleksik");

        const addButton = document.createElement("button");
        addButton.classList.add("AddToCartButton");
        const addIcon = document.createElement("img");
        addIcon.classList.add("AddToCartIcon");
        addIcon.src = "Assets/Images/GreenStoreIconFar.png";
        addIcon.alt = "Dodaj";
        addButton.appendChild(addIcon);

        const infoButton = document.createElement("button");
        infoButton.classList.add("SeeMoreInfoButton");
        infoButton.textContent = "Więcej Informacji";

        actionFlex.appendChild(addButton);
        actionFlex.appendChild(infoButton);
        productDiv.appendChild(actionFlex);
    }
};

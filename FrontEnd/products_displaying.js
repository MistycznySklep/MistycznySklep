const ProductsContainer = document.getElementById("ProductsContainer");

const AddProductsToContainer = (products, categoryId, categoryName) => {
    const container = document.createElement("div");
    container.className = "ShopContainer";

    const tileDetail = document.createElement("div");
    tileDetail.className = "TitleDividerSmall";
    const tileImg = document.createElement("img");
    tileImg.src = "Assets/Images/DividerLine.png";
    const heightParagraph = document.createElement("p");
    heightParagraph.className = "pHeight5vh";
    const tileTextParagrapoh = document.createElement("p");
    tileTextParagrapoh.textContent = `Wszystkie ${categoryName}:`;
    tileDetail.appendChild(tileImg);
    tileDetail.appendChild(heightParagraph);
    tileDetail.appendChild(tileTextParagrapoh);
    ProductsContainer.appendChild(tileDetail);
    
    ProductsContainer.appendChild(container);

    for (const product of products) {
        if (product.idProduct_categories != categoryId) continue;
        const productDiv = document.createElement("div");
        productDiv.classList.add("ShopElement");
        container.appendChild(productDiv);

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
        category.textContent = `Kategoria: ${categoryName}`;
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
}

window.onload = async () => {
    const response = await API.GetProductList();
    const categories = await API.GetCategoryList();
    console.log(categories);

    let displayedCategories = [];
    for (const product of response) {
        if (displayedCategories.includes(product.idProduct_categories)) continue;
        displayedCategories.push(product.idProduct_categories);

        AddProductsToContainer(response, product.idProduct_categories, categories[product.idProduct_categories]);
    }
};

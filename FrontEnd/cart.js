const cart = document.getElementById("cartElements");

API.GetCartProducts().then(async carts => {
    const categories = await API.GetSubCategoryList();

    for (const item of carts) {
        console.log(item);
        const container = document.createElement("div");
        container.className = "cartProductElements";

        const photoDiv = document.createElement("div");
        photoDiv.className = "productPhoto";

        const img = document.createElement("img");
        img.src = `/api/image.php?id=${item.product.idImgs}`;
        img.alt = "";
        photoDiv.appendChild(img);

        const summaryDiv = document.createElement("div");
        summaryDiv.className = "productSummary";

        const nameP = document.createElement("p");
        nameP.className = "CartNazwa";
        nameP.textContent = item.product.name;

        const categoryP = document.createElement("p");
        categoryP.className = "CartKategoria";
        categoryP.textContent = `Kategoria: ${categories[item.product.idProduct_subcategories].subcategory}`;

        const quantityDiv = document.createElement("div");
        quantityDiv.className = "productQuantityAddition";

        const minusBtn = document.createElement("button");
        minusBtn.textContent = "-";

        const quantityP = document.createElement("p");
        quantityP.textContent = item.quantity;

        const plusBtn = document.createElement("button");
        plusBtn.textContent = "+";

        quantityDiv.append(minusBtn, quantityP, plusBtn);

        const pricePerUnitP = document.createElement("p");
        pricePerUnitP.textContent = `Cena z 1 szute: ${item.product.price}zl`;

        const totalPriceP = document.createElement("p");
        totalPriceP.textContent = `Łączna cena: ${Math.round(item.product.price * item.quantity * 100) / 100}zl`;

        const removeBtn = document.createElement("button");
        removeBtn.className = "UsunFromCart";
        removeBtn.textContent = "Usuń z koszyka";

        summaryDiv.append(nameP, categoryP, quantityDiv, pricePerUnitP, totalPriceP, removeBtn);
        container.append(photoDiv, summaryDiv);
        cart.appendChild(container);
    }
});

const container = document.getElementById("InventoryContainer");

const AddProductsToContainer = (products, categoryId, categoryName, categories) => {
    const divider = document.createElement("div");
    divider.className = "TitleDividerSmall";

    const tileTextParagrapoh = document.createElement("p");
    tileTextParagrapoh.textContent = `✧*:･ﾟ✧ ${categoryName} ✧･ﾟ: *✧`;

    divider.appendChild(tileTextParagrapoh);
    
    container.append(divider);

    const grid = document.createElement("div");
    grid.className = "inventoryGrid";
    container.appendChild(grid);

    for (const item of products) {
        console.log(item);
        if (categories[item.product.idProduct_subcategories].idCategories != categoryId) continue;

        const div = document.createElement("div");
        div.className = "inventoryGridItem";

        const img = document.createElement("img");
        img.src = `/api/image.php?id=${item.product.idImgs}`;
        img.alt = item.name ?? "";

        const p = document.createElement("p");
        p.textContent = `Liczba: ${item.quantity}`;

        div.append(img, p);
        grid.append(div);
    }
}

window.onload = async () => {
    const response = await API.GetInventory();
    const categories = await API.GetCategoryList();
    const subcategories = await API.GetSubCategoryList();

    let displayedCategories = [];
    for (const item of response) {
        if (displayedCategories.includes(subcategories[item.product.idProduct_subcategories].idCategories)) continue;
        displayedCategories.push(subcategories[item.product.idProduct_subcategories].idCategories);

        AddProductsToContainer(response, subcategories[item.product.idProduct_subcategories].idCategories, categories[subcategories[item.product.idProduct_subcategories].idCategories], subcategories);
    }
};

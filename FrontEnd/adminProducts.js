const container = document.getElementById("productTableContainer");

window.onload = async () => {
    const products = await API.GetProductList();
    const subcategories = await API.GetSubCategoryList();

    for (const product of products) {
        console.log(product);
        const panelDiv = document.createElement("div");
        panelDiv.className = "PanelDiv TableDiv";

        const img = document.createElement("img");
        img.className = "TableIMG";
        img.src = product.image;
        img.alt = "";
        panelDiv.appendChild(img);

        const table = document.createElement("table");

        const headerRow = document.createElement("tr");
        const headers = ["ID", "Nazwa", "Cena", "Liczba", "Kategoria", "Akcje"];
        for (const text of headers) {
            const th = document.createElement("th");
            th.textContent = text;
            headerRow.appendChild(th);
        }
        table.appendChild(headerRow);

        const dataRow = document.createElement("tr");

        const tdId = document.createElement("td");
        tdId.className = "tableWidth2vw";
        tdId.textContent = product.idProducts;

        const tdName = document.createElement("td");
        tdName.className = "tableWidth12vw";
        tdName.textContent = product.name;

        const tdPrice = document.createElement("td");
        tdPrice.className = "tableWidth5vw";
        tdPrice.textContent = `${product.price} zł`;

        const tdStock = document.createElement("td");
        tdStock.className = "tableWidth5vw";
        tdStock.textContent = product.quantity ?? "Brak";

        const tdCategory = document.createElement("td");
        tdCategory.className = "tableWidth10vw";
        tdCategory.textContent = subcategories[product.idProduct_subcategories].subcategory;

        const tdActions = document.createElement("td");
        tdActions.className = "tableWidth10vw";

        const actionsDiv = document.createElement("div");
        actionsDiv.className = "tableAkcjeDiv";

        const editLink = document.createElement("a");
        editLink.className = "adminEdithref";
        editLink.href = "adminProductEdit.html";
        editLink.textContent = "Edytuj";

        const shopLink = document.createElement("a");
        shopLink.className = "adminStorehref";
        shopLink.href = "productDetails.html";
        shopLink.textContent = "Sklep";

        const removeLink = document.createElement("a");
        removeLink.className = "adminRemovehref";
        removeLink.href = "";
        removeLink.textContent = "Usuń";

        actionsDiv.append(editLink, shopLink, removeLink);
        tdActions.appendChild(actionsDiv);

        dataRow.append(tdId, tdName, tdPrice, tdStock, tdCategory, tdActions);
        table.appendChild(dataRow);

        panelDiv.appendChild(table);
        container.appendChild(panelDiv);
    }
}
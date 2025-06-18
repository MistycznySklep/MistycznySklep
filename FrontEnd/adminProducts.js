const container = document.getElementById("productTableContainer");

const Reload = async () => {
    const products = await API.GetProductList();
    const subcategories = await API.GetSubCategoryList();

    container.innerHTML = "";
    for (const product of products) {
        console.log(product);
        const panelDiv = document.createElement("div");
        panelDiv.className = "PanelDiv TableDiv";

        const img = document.createElement("img");
        img.className = "TableIMG";
        img.src = `/api/image.php?id=${product.idImgs}`;
        img.alt = "Image";
        img.loading = "lazy";
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
        const nameInput = document.createElement("input");
        nameInput.value = product.name;
        nameInput.style.width = "100%";
        nameInput.style.border = "none";
        nameInput.style.padding = "0";
        nameInput.style.outline = "0";
        nameInput.style.margin = "0";
        nameInput.style.height = "auto";
        tdName.appendChild(nameInput);

        const tdPrice = document.createElement("td");
        const priceInput = document.createElement("input");
        priceInput.style.border = "none";
        priceInput.style.padding = "0";
        priceInput.style.outline = "0";
        priceInput.style.margin = "0";
        priceInput.style.height = "auto";
        priceInput.value = product.price;

        tdPrice.className = "tableWidth5vw";
        tdPrice.appendChild(priceInput);

        const tdStock = document.createElement("td");
        tdStock.className = "tableWidth5vw";
        const stockInput = document.createElement("input");
        stockInput.type = "number";
        stockInput.value = product.quantity ?? 0;
        stockInput.style.width = "100%";
        stockInput.style.border = "none";
        stockInput.style.padding = "0";
        stockInput.style.outline = "0";
        stockInput.style.margin = "0";
        stockInput.style.height = "auto";
        tdStock.appendChild(stockInput);

        const tdCategory = document.createElement("td");
        tdCategory.className = "tableWidth10vw";
        tdCategory.textContent = subcategories[product.idProduct_subcategories].subcategory;

        const tdActions = document.createElement("td");
        tdActions.className = "tableWidth10vw";

        const actionsDiv = document.createElement("div");
        actionsDiv.className = "tableAkcjeDiv";

        const editLink = document.createElement("a");
        editLink.className = "adminEdithref";
        editLink.textContent = "Edytuj";
        editLink.onclick = async () => {
            await API.EditProduct(product.idProducts, nameInput.value, priceInput.value, stockInput.value);
            await Reload();
        }

        const shopLink = document.createElement("a");
        shopLink.className = "adminStorehref";
        shopLink.href = "productDetails.html";
        shopLink.textContent = "Sklep";

        const removeLink = document.createElement("a");
        removeLink.className = "adminRemovehref";
        removeLink.textContent = "Usuń";
        removeLink.onclick = async () => {
            await API.DeleteProduct(product.idProducts);
            await Reload();
        }

        actionsDiv.append(editLink, shopLink, removeLink);
        tdActions.appendChild(actionsDiv);

        dataRow.append(tdId, tdName, tdPrice, tdStock, tdCategory, tdActions);
        table.appendChild(dataRow);

        panelDiv.appendChild(table);
        container.appendChild(panelDiv);
    }
}

window.onload = Reload;
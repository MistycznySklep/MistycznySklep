const container = document.getElementById("categoryTableContainer");

const ReloadCategories = async () => {
    const categories = await API.GetSubCategoryList();
    const parentCategories = await API.GetCategoryList();

    container.innerHTML = "";
    for (const categoryId in categories) {
        const category = categories[categoryId];
        const panelDiv = document.createElement("div");
        panelDiv.className = "PanelDiv TableDiv";

        const table = document.createElement("table");

        const headerRow = document.createElement("tr");
        const headers = ["ID", "Nazwa Kategorii", "Typ Kategorii", "Akcje"];
        for (const text of headers) {
            const th = document.createElement("th");
            th.textContent = text;
            headerRow.appendChild(th);
        }
        table.appendChild(headerRow);

        const dataRow = document.createElement("tr");

        const tdId = document.createElement("td");
        tdId.className = "tableWidth2vw";
        tdId.textContent = category.idProduct_subcategories;

        const tdName = document.createElement("td");
        const inputName = document.createElement("input");
        tdName.className = "tableWidth12vw";
        inputName.value = category.subcategory;
        tdName.appendChild(inputName);
        inputName.style.border = "none";
        inputName.style.padding = "0";
        inputName.style.outline = "0";
        inputName.style.margin = "0";
        inputName.style.height = "auto";

        const tdType = document.createElement("td");
        tdType.className = "tableWidth12vw";
        tdType.textContent = parentCategories[category.idCategories];

        const tdActions = document.createElement("td");
        tdActions.className = "tableWidth7vw";

        const actionsDiv = document.createElement("div");
        actionsDiv.className = "tableAkcjeDiv";

        const editLink = document.createElement("a");
        editLink.className = "adminEdithref";
        editLink.textContent = "Edytuj";
        editLink.onclick = async () => {
            await API.RenameSubCategory(category.idProduct_subcategories, inputName.value);
            await ReloadCategories();
        };

        const removeLink = document.createElement("a");
        removeLink.className = "adminRemovehref";
        removeLink.textContent = "Usuń";
        removeLink.onclick = async () => {
            await API.DeleteSubCategory(category.idProduct_subcategories);
            await ReloadCategories();
        };

        actionsDiv.append(editLink, removeLink);
        tdActions.appendChild(actionsDiv);

        dataRow.append(tdId, tdName, tdType, tdActions);
        table.appendChild(dataRow);

        panelDiv.appendChild(table);
        container.appendChild(panelDiv);
    }
}

ReloadCategories();
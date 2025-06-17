const container = document.getElementById("userTableContainer");

API.GetAccounts().then(users => {
    for (const user of users) {
        const panelDiv = document.createElement("div");
        panelDiv.className = "PanelDiv TableDiv";

        const table = document.createElement("table");

        const headerRow = document.createElement("tr");
        const headers = ["ID", "Login", "Nazwa", "E-mail", "Akcje"];
        for (const text of headers) {
            const th = document.createElement("th");
            th.textContent = text;
            headerRow.appendChild(th);
        }
        table.appendChild(headerRow);

        const dataRow = document.createElement("tr");

        const tdId = document.createElement("td");
        tdId.className = "tableWidth2vw";
        tdId.textContent = user.idAccounts;

        const tdLogin = document.createElement("td");
        tdLogin.className = "tableWidth10vw";
        tdLogin.textContent = user.login;

        const tdName = document.createElement("td");
        tdName.className = "tableWidth12vw";
        tdName.textContent = user.username;

        const tdEmail = document.createElement("td");
        tdEmail.className = "tableWidth12vw";
        tdEmail.textContent = user.email;

        const tdActions = document.createElement("td");
        tdActions.className = "tableWidth5vw";

        const actionsDiv = document.createElement("div");
        actionsDiv.className = "tableAkcjeDiv";

        const removeLink = document.createElement("a");
        removeLink.className = "adminRemovehref";
        removeLink.textContent = "Usuń";

        actionsDiv.appendChild(removeLink);
        tdActions.appendChild(actionsDiv);

        dataRow.append(tdId, tdLogin, tdName, tdEmail, tdActions);
        table.appendChild(dataRow);

        panelDiv.appendChild(table);
        container.appendChild(panelDiv);
    }
})
const container = document.getElementById("logi");

API.FetchLogs().then(logs => {
    logs.forEach(log => {
        const panel = document.createElement("div");
        panel.className = "PanelDiv TableDiv";

        const table = document.createElement("table");

        const header = document.createElement("tr");
        ["ID", "Typ", "Data", "Nazwa Konta", "Agent", "Ostatnie IP"].forEach(text => {
            const th = document.createElement("th");
            th.textContent = text;
            header.appendChild(th);
        });
        table.appendChild(header);

        const row = document.createElement("tr");

        const tdId = document.createElement("td");
        tdId.className = "tableWidth2vw";
        tdId.textContent = log.Id;
        row.appendChild(tdId);

        const tdType = document.createElement("td");
        tdType.className = "tableWidth10vw";
        tdType.textContent = log.Type;
        row.appendChild(tdType);

        const tdDate = document.createElement("td");
        tdDate.className = "tableWidth10vw";
        tdDate.textContent = log["Created At"];
        row.appendChild(tdDate);

        const tdName = document.createElement("td");
        tdName.className = "tableWidth12vw";
        tdName.textContent = log.Account;
        row.appendChild(tdName);

        const tdAgent = document.createElement("td");
        tdAgent.className = "tableWidth7vw";
        tdAgent.textContent = log["User Agent"];
        row.appendChild(tdAgent);

        const tdIP = document.createElement("td");
        tdIP.className = "tableWidth7vw";
        tdIP.textContent = log["Last IP"];
        row.appendChild(tdIP);

        table.appendChild(row);
        panel.appendChild(table);
        container.appendChild(panel);
    });
})
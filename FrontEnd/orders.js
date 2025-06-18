const container = document.getElementById("productTableContainer");
const table = document.createElement("table");
const Panel = document.querySelector('.DivInfo');

let x = 0;
window.onload = async () => {
     const products = await API.OrdersHistory();

     const headerRow = document.createElement("tr");
     const headers = ["Data", "Produkty", "Cena"];

     for (const text of headers) {
          const th = document.createElement("th");
          th.textContent = text;
          headerRow.appendChild(th);
     }


     table.appendChild(headerRow);

     for (const product of products) {
          const panelDiv = document.createElement("div");
          panelDiv.className = "PanelDiv TableDiv";

          const dataRow = document.createElement("tr");

          const tdId = document.createElement("td");
          tdId.className = "tableWidth7vw";
          tdId.textContent = product.ordered_at;

          let products = "";
          product.products.forEach(p => products += p + ", ");
          if (products.length > 0) {
               products = products.substring(0, products.length - 2);
          }

          const tdName = document.createElement("td");
          tdName.className = "tableWidth30vw";
          tdName.textContent = products;

          const tdPrice = document.createElement("td");
          tdPrice.className = "tableWidth5vw";
          tdPrice.textContent = `${product.price} zł`;

          const actionsDiv = document.createElement("div");
          actionsDiv.className = "tableAkcjeDiv";

          dataRow.append(tdId, tdName, tdPrice);
          table.appendChild(dataRow);

          panelDiv.appendChild(table);
          container.appendChild(panelDiv);

     }
}
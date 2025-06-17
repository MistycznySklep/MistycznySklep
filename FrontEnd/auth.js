const API = {
    get accessToken() {
        return localStorage.getItem("token");
    },
    set accessToken(value) {
        localStorage.setItem("token", value);
    },
    AuthGet: async (url) => {
        if (API.accessToken === null) throw new Error("Access token was null");

        return await fetch(url, {
            headers: {
                "Content-Type": "application/json",
                Authorization: API.accessToken
            }
        });
    },
    AuthPost: async (url, body) => {
        if (API.accessToken === null) throw new Error("Access token was null");

        return await fetch(url, {
            headers: {
                "Content-Type": "application/json",
                Authorization: API.accessToken
            },
            method: "POST",
            body: JSON.stringify(body)
        });
    },
    LocalUser: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/local.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    GetProductList: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/products.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    GetCategoryList: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/categories.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        let categories = {};
        for (const category of json) categories[category.idCategories] = category.category; 

        return categories;
    },
    GetSubCategoryList: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/subcategories.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        let categories = {};
        for (const category of json) categories[category.idProduct_subcategories] = category; 

        return categories;
    },
    GetCartProducts: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/cart.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    GetAccounts: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/accounts.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    }
};

const ReloadVariables = async () => {
    if (API.accessToken === null) return;
    try {
        const user = await API.LocalUser();

        const autoloadElements = document.getElementsByClassName("autoload");
        for (const autoload of autoloadElements) {
            if (typeof (autoload.dataset.autoload) === "undefined") continue;
            const expression = autoload.dataset.autoload;
            if (expression.startsWith("localUser.")) {
                const property = expression.substr(expression.indexOf(".") + 1);
                autoload.textContent = user[property];
            }
        }
    } catch (e) {
        if (!location.href.includes("login.html")) location.href = "login.html";
    }
};

window.onload = ReloadVariables;
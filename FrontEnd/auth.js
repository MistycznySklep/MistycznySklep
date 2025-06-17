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
    AuthDelete: async (url) => {
        if (API.accessToken === null) throw new Error("Access token was null");

        return await fetch(url, {
            headers: {
                "Content-Type": "application/json",
                Authorization: API.accessToken
            },
            method: "DELETE"
        });
    },
    AuthPatch: async (url) => {
        if (API.accessToken === null) throw new Error("Access token was null");

        return await fetch(url, {
            headers: {
                "Content-Type": "application/json",
                Authorization: API.accessToken
            },
            method: "PATCH"
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
    },
    DeleteAccount: async id => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthDelete(`/api/accounts.php?id=${id}`);
        if (response.status === 204) return null;
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    GetCartProducts: async () => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthGet("/api/cart.php");
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    AddToCart: async productId => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthPost(`/api/addToCart.php`, { productId });
        if (response.status === 201) return null;
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    DeleteFromCart: async cartId => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthDelete(`/api/deleteFromCart.php?id=${cartId}`);
        if (response.status === 204) return null;
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
    IncrementCartItem: async cartId => {
        if (API.accessToken === null) throw new Error("Access token was null");

        const response = await API.AuthPatch(`/api/incrementCartitem.php?id=${cartId}`);
        if (response.status === 204) return null;
        const json = await response.json();
        if (!response.ok) throw new Error(json);

        return json;
    },
};

const ReloadVariables = async () => {
    if (API.accessToken === null) return;
    try {
        const user = await API.LocalUser();
        console.log(user);
        if (location.href.includes("admin") && user.type !== "admin")
            location.href = "index.html";

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

window.addEventListener("load", ReloadVariables);
const API = {
    get accessToken() {
        return localStorage.getItem("AccessToken");
    },
    set accessToken(value) {
        localStorage.setItem("AccessToken", value);
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
};

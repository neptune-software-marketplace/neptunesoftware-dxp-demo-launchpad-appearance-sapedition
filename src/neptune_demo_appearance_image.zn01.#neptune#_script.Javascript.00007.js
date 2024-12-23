const icons = {
    LEGAL: "sap-icon://fas/section",
    PRIVACY: "sap-icon://fas/user-lock",
    SECURITY: "sap-icon://nep/security",
    ACCESSIBILITY: "sap-icon://accessibility",
    COOKIES: "sap-icon://fas/cookie-bite",
};

neptune.Shell.attachBeforeDisplay(data => {
    Icon.setSrc(icons[data?.icon] || "sap-icon://nep/neptune-connect");
});

neptune.Shell.attachOnNavigation(data => {
    console.log(data);
});

window.addEventListener("hashchange", () => {
    if (location.hash.startsWith("#neptunenavigation-NEPTUNE_DEMO_APPEARANCE_IMAGE")) {
        const hash = location.hash.split("#neptunenavigation-NEPTUNE_DEMO_APPEARANCE_IMAGE_")[1];
        Icon.setSrc(icons[hash] || "sap-icon://nep/neptune-connect");
    }
});

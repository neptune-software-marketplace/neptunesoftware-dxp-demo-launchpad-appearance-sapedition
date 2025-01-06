/**
 * ENHANCEMENT: After Startup: Add logic during the start up process
 * @function
 * @param     params: Object: Request params
 */
const btnEnableHelpAppearance = new sap.m.Button(`btnEnableHelpAppearance`, {
    text: "Enable Help",
    visible: true,
    press: function (e) {
        if (this.getText() === "Enable Help") {
            document.documentElement.classList.add("nepDxpDemoHelp");
            this.setText("Disable Help");
            // sap.n.Shell.loadSidepanel("dxp_demo_appearance_help", {
            //     tabTitle: "Help"
            // });
        } else {
            document.documentElement.classList.remove("nepDxpDemoHelp");
            this.setText("Enable Help");
            // sap.n.Shell.closeSidepanel();
        }
    },
});
AppCacheShellCustomRight.addItem(btnEnableHelpAppearance);

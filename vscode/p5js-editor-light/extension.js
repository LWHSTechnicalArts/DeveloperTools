// p5.js Editor Light: apply the theme once
// ---------------------------------------
// settings.json already selects this theme ("workbench.colorTheme"). But if
// VS Code first started before the theme was installed, it keeps its default
// theme even after the theme arrives, until someone picks the theme by hand.
// Picking it removes the setting and writes it back, and that makes VS Code
// apply it. This file does the same thing automatically, once per Mac.
//
// It runs only once (it remembers in VS Code's own storage), so a student who
// later chooses a different theme keeps their choice.

const vscode = require("vscode");

const themeName = "p5.js Editor Light";
const appliedKey = "p5jsEditorLight.themeApplied";

async function activate(context) {
  if (context.globalState.get(appliedKey)) {
    return;
  }

  const workbench = vscode.workspace.getConfiguration("workbench");
  const userValue = workbench.inspect("colorTheme")?.globalValue;

  // If the user setting already names this theme, writing the same value is
  // ignored, so remove it first and then write it back.
  if (userValue === themeName) {
    await workbench.update("colorTheme", undefined, vscode.ConfigurationTarget.Global);
  }
  await workbench.update("colorTheme", themeName, vscode.ConfigurationTarget.Global);

  await context.globalState.update(appliedKey, true);
}

function deactivate() {}

module.exports = { activate, deactivate };

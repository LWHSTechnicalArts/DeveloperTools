// Refresh Copilot
// ---------------
// Adds a "Refresh Copilot" button to the status bar at the bottom of the
// window. Clicking it runs scripts/refresh-copilot.sh from the DeveloperTools
// repository, which makes the copilot folder (Copilot's class instructions and
// the worksheets) match GitHub, and then reports what happened. A launch agent
// already runs the same script every 15 minutes; this button is for when a fix
// is needed right away, such as during class.
//
// It can also be run from the Command Palette:
// "Refresh Copilot: Update Class Instructions".

const vscode = require("vscode");
const childProcess = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");

const buttonText = "$(sync) Refresh Copilot";
const busyButtonText = "$(sync~spin) Refreshing Copilot";

function activate(context) {
  const button = vscode.window.createStatusBarItem(vscode.StatusBarAlignment.Left);
  button.text = buttonText;
  button.tooltip = "Update Copilot's class instructions from GitHub";
  button.command = "refreshCopilot.refresh";
  button.show();

  context.subscriptions.push(
    button,
    vscode.commands.registerCommand("refreshCopilot.refresh", () => refreshCopilot(button))
  );
}

async function refreshCopilot(button) {
  const scriptPath = getRefreshScriptPath();
  if (!scriptPath) {
    vscode.window.showErrorMessage(
      "Copilot's class instructions are not set up on this Mac. Run the setup command again."
    );
    return;
  }

  button.text = busyButtonText;
  const result = await runScript(scriptPath);
  button.text = buttonText;
  showResult(result);
}

// configure-copilot.sh links ~/.copilot/copilot-instructions.md to the copy
// in the repository, so following that link finds the repository, wherever it
// is on this Mac. Returns nothing if the link or the script is missing.
function getRefreshScriptPath() {
  const instructionsLink = path.join(os.homedir(), ".copilot", "copilot-instructions.md");
  try {
    const instructionsPath = fs.realpathSync(instructionsLink);
    const repositoryFolder = path.dirname(path.dirname(instructionsPath));
    const scriptPath = path.join(repositoryFolder, "scripts", "refresh-copilot.sh");
    return fs.existsSync(scriptPath) ? scriptPath : undefined;
  } catch {
    return undefined;
  }
}

function runScript(scriptPath) {
  return new Promise((resolve) => {
    childProcess.execFile("/bin/bash", [scriptPath], (error, output, errorOutput) => {
      resolve({ error, output: output.trim(), errorOutput: errorOutput.trim() });
    });
  });
}

// refresh-copilot.sh prints a line starting with "Skipped:" when it leaves the
// folder alone, a line ending in "updated the copilot folder from GitHub."
// when it changes it, and nothing when the folder already matches.
async function showResult(result) {
  if (result.error) {
    const details = result.errorOutput || result.error.message;
    vscode.window.showErrorMessage(`Copilot could not be refreshed: ${details}`);
  } else if (result.output.startsWith("Skipped:")) {
    vscode.window.showWarningMessage(`Copilot was not refreshed. ${result.output}`);
  } else if (result.output.includes("updated the copilot folder")) {
    await offerReload();
  } else {
    vscode.window.showInformationMessage("Copilot's class instructions are already up to date.");
  }
}

async function offerReload() {
  const reloadChoice = "Reload Window";
  const choice = await vscode.window.showInformationMessage(
    "Copilot's class instructions were updated. Reload the window so Copilot reads them.",
    reloadChoice
  );
  if (choice === reloadChoice) {
    vscode.commands.executeCommand("workbench.action.reloadWindow");
  }
}

function deactivate() {}

module.exports = { activate, deactivate };

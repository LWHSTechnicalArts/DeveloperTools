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
//
// Copilot chats run in VS Code's "local agent host," which reads the class
// instructions when it starts and keeps that copy, even through "Reload
// Window." So once the folder is current, this extension restarts the agent
// host ("Restart Local Agent Host") and opens a new chat, as if the student
// had clicked the chat's + button, so they never keep typing into a chat that
// still has the old copy.
//
// The chat that is already open when VS Code starts did not always have the
// class instructions, while a chat started with the + button did. So each
// time VS Code finishes starting, this extension also opens a new chat.

const vscode = require("vscode");
const childProcess = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");

const restartCommand = "workbench.action.chat.restartLocalAgentHost";
const newChatCommand = "workbench.action.chat.newChat";
const openChatCommand = "workbench.action.chat.open";
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

  startFreshChat();
}

// Runs once, at startup ("onStartupFinished" in package.json). It shows no
// message, because nothing changed that the student needs to know about.
async function startFreshChat() {
  try {
    await vscode.commands.executeCommand(newChatCommand);
    await vscode.commands.executeCommand(openChatCommand);
  } catch {
    // This version of VS Code has no such commands; the + button still works.
  }
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
// when it changes it, and nothing when the folder already matches. The
// launch agent may have updated the folder in the background already, so
// Copilot is restarted in both of the last two cases.
async function showResult(result) {
  if (result.error) {
    const details = result.errorOutput || result.error.message;
    vscode.window.showErrorMessage(`Copilot could not be refreshed: ${details}`);
  } else if (result.output.startsWith("Skipped:")) {
    vscode.window.showWarningMessage(`Copilot was not refreshed. ${result.output}`);
  } else if (result.output.includes("updated the copilot folder")) {
    await restartCopilot("Copilot's class instructions were updated.");
  } else {
    await restartCopilot("Copilot's class instructions are up to date.");
  }
}

async function restartCopilot(statusMessage) {
  try {
    await vscode.commands.executeCommand(restartCommand);
  } catch {
    // This version of VS Code has no "Restart Local Agent Host" command.
    vscode.window.showInformationMessage(
      `${statusMessage} Quit VS Code and open it again so Copilot reads them.`
    );
    return;
  }
  await openNewChat(statusMessage);
}

// VS Code's own code opens a fresh chat with these two commands: newChat
// starts it, and open shows the chat view if it is closed.
async function openNewChat(statusMessage) {
  try {
    await vscode.commands.executeCommand(newChatCommand);
    await vscode.commands.executeCommand(openChatCommand);
    vscode.window.showInformationMessage(
      `${statusMessage} Copilot was restarted to read them, and a new chat is open.`
    );
  } catch {
    vscode.window.showInformationMessage(
      `${statusMessage} Copilot was restarted to read them. Click + in the chat to start a new chat.`
    );
  }
}

function deactivate() {}

module.exports = { activate, deactivate };

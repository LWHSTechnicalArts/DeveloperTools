// p5.js Live Sketch
// ----------------
// When a folder containing sketch.js opens in VS Code, this extension:
//   0. closes any integrated browser tabs VS Code restored in this window,
//      because they load before Live Server is running and show an error,
//   1. opens sketch.js in the left half of the editor,
//   2. starts Live Server (the same as clicking "Go Live"),
//   3. waits until Live Server is serving this project, and
//   4. shows the sketch in VS Code's integrated browser, in the right half,
//      reusing a browser tab that already shows this sketch.
// Live Server reloads the page whenever a file is saved, so the sketch on the
// right updates about a second after you stop typing (autosave is on).
//
// It can also be run by hand from the Command Palette:
// "p5.js Live Sketch: Show Sketch Beside Code".

const vscode = require("vscode");
const http = require("http");

const pollIntervalMilliseconds = 250;
const pollTimeoutMilliseconds = 20000;

function activate(context) {
  context.subscriptions.push(
    vscode.commands.registerCommand("p5LiveSketch.open", showSketchBesideCode)
  );

  const openOnStart = vscode.workspace
    .getConfiguration("p5LiveSketch")
    .get("openOnStart", true);
  if (openOnStart) {
    closeRestoredBrowserTabs().then(showSketchBesideCode);
  }
}

// When a project opens again, VS Code restores its browser tabs and loads them
// right away, before Live Server has started, so they show an error page until
// the sketch is ready. Closing them at startup means the sketch appears only
// once it works. This closes every integrated browser tab in this window.
async function closeRestoredBrowserTabs() {
  try {
    await vscode.commands.executeCommand("workbench.action.browser.closeAll");
  } catch {
    // No browser tabs were open, so there was nothing to close.
  }
}

async function showSketchBesideCode() {
  const projectFolder = getProjectFolder();
  if (!projectFolder) {
    return;
  }
  const sketchUri = vscode.Uri.joinPath(projectFolder.uri, "sketch.js");
  const indexUri = vscode.Uri.joinPath(projectFolder.uri, "index.html");
  if (!(await getFileExists(sketchUri)) || !(await getFileExists(indexUri))) {
    return;
  }

  // Show the code first, in the left editor group.
  const sketchDocument = await vscode.workspace.openTextDocument(sketchUri);
  await vscode.window.showTextDocument(sketchDocument, vscode.ViewColumn.One);

  // Start Live Server. This is the command behind its "Go Live" button.
  // If it is already running, Live Server just reports its port again.
  await vscode.commands.executeCommand("extension.liveServer.goOnline");

  const port = await getServingPort(sketchUri);
  if (!port) {
    vscode.window.showWarningMessage(
      "p5.js Live Sketch: Live Server did not start in time. Click Go Live in the status bar, then run \"p5.js Live Sketch: Show Sketch Beside Code\"."
    );
    return;
  }

  // Show the sketch in the integrated browser, beside the code.
  //   reuseUrlFilter: if a browser tab already shows a page from this Live
  //     Server address (for example, one VS Code restored after "Reload
  //     Window"), reload that tab instead of opening another one.
  //   openToSide: otherwise, open a new tab in the editor group to the right.
  const serverAddress = `http://127.0.0.1:${port}`;
  await vscode.commands.executeCommand("workbench.action.browser.open", {
    url: `${serverAddress}/index.html`,
    reuseUrlFilter: serverAddress,
    openToSide: true,
  });
}

// The first folder open in this window, or nothing if no folder is open.
function getProjectFolder() {
  const folders = vscode.workspace.workspaceFolders;
  return folders && folders.length > 0 ? folders[0] : undefined;
}

async function getFileExists(uri) {
  try {
    await vscode.workspace.fs.stat(uri);
    return true;
  } catch {
    return false;
  }
}

// Waits until Live Server is serving *this* project, and returns its port.
// Live Server moves to the next port (5501, 5502, ...) when 5500 is busy, for
// example when another project is already open, so this reads the port
// setting on every try. To be sure the server belongs to this project, it
// compares the sketch.js the server sends with the sketch.js on disk.
async function getServingPort(sketchUri) {
  const sketchBytes = await vscode.workspace.fs.readFile(sketchUri);
  const sketchText = Buffer.from(sketchBytes).toString("utf8");
  const deadline = Date.now() + pollTimeoutMilliseconds;

  while (Date.now() < deadline) {
    const port = vscode.workspace
      .getConfiguration("liveServer.settings")
      .get("port", 5500);
    const servedText = await getPageText(`http://127.0.0.1:${port}/sketch.js`);
    if (servedText === sketchText) {
      return port;
    }
    await waitMilliseconds(pollIntervalMilliseconds);
  }
  return undefined;
}

// Resolves to the text at an address, or to undefined if nothing answers.
function getPageText(address) {
  return new Promise((resolve) => {
    const request = http.get(address, (response) => {
      if (response.statusCode !== 200) {
        response.resume();
        resolve(undefined);
        return;
      }
      let body = "";
      response.setEncoding("utf8");
      response.on("data", (chunk) => {
        body += chunk;
      });
      response.on("end", () => resolve(body));
    });
    request.on("error", () => resolve(undefined));
    request.setTimeout(pollIntervalMilliseconds * 4, () => {
      request.destroy();
      resolve(undefined);
    });
  });
}

function waitMilliseconds(milliseconds) {
  return new Promise((resolve) => setTimeout(resolve, milliseconds));
}

function deactivate() {}

module.exports = { activate, deactivate };

# DeveloperTools

This repository sets up your Mac for Code & Design at Lick-Wilmerding High School. One script installs the tools we use in class and makes Visual Studio Code, iTerm2, and your terminal prompt match the light color scheme of the [p5.js web editor](https://editor.p5js.org).

## What the setup does

The setup script installs these programs and settings for you:

- **Homebrew**, a tool that installs other programs from the command line.
- **iTerm2**, the terminal app we use in class.
- **Visual Studio Code**, the code editor we use in class, with the p5.js Editor Light theme and the p5.vscode and Live Server extensions.
- **oh-my-zsh** and **Powerlevel10k**, which give your terminal a colored, informative prompt.
- **zsh-autosuggestions** and **zsh-syntax-highlighting**, which suggest and color commands as you type.
- **MesloLGS NF**, a font with the symbols the prompt draws.

The script does not delete anything. If your Mac already has one of the settings files it replaces, the script moves your old file into a folder named `DeveloperTools-backups` in your home folder.

## Before you start

You need three things before you begin:

- A Mac connected to the internet.
- The password you use to log in to your Mac. Your account must be an administrator account. If the script says you are not an administrator, ask your teacher for help.
- About 30 minutes. Most of that time is waiting while things download.

## Terminal basics

Terminal is an app where you control your Mac by typing commands instead of clicking. You will only need a few skills for this setup:

- **Running a command:** Copy a command from this page, click in the Terminal window, paste it with **Command-V**, and press **Return**. Terminal runs one command each time you press Return.
- **Waiting:** While a command runs, text scrolls by. The command is finished when you see a line ending in `%` with a blinking cursor after it. That line is called the *prompt*.
- **Typing your password:** When Terminal asks for your password, nothing appears on screen as you type, not even dots. This is normal. Type your password and press Return.
- **Stopping a command:** If something goes wrong and you need to stop a command, press **Control-C**.

## Set up your Mac

Follow these steps in order.

1. **Open Terminal.** Press **Command-Space** to open Spotlight, type `Terminal`, and press **Return**. A window with a blinking cursor opens.

2. **Run the setup command.** Copy this whole line, paste it into Terminal, and press **Return**:

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/LWHSTechnicalArts/DeveloperTools/main/bootstrap.sh)"
   ```

   This command downloads a script named `bootstrap.sh` from this repository and runs it. The script installs Apple's Command Line Tools if your Mac does not have them, downloads this repository into a folder named `DeveloperTools` in your home folder, and then runs `setup.sh` to install and set up everything else.

3. **Type your password when asked.** Type your Mac login password and press **Return**. The script may ask more than once, because some steps take longer than macOS remembers your password.

4. **Wait for the script to finish.** This takes about 30 minutes. The script prints a heading for each step, such as `==> Homebrew`. If a window opens asking to install the Command Line Tools, click **Install**, click **Agree**, wait for the installation to finish, and then press **Return** in Terminal. The script is finished when it prints `Done.` and shows the prompt again.

5. **Quit Terminal.** Press **Command-Q**. From now on, use iTerm2 instead of Terminal; the colors only work in iTerm2 and in Visual Studio Code.

6. **Open iTerm2.** Open your **Applications** folder and double-click **iTerm**. If macOS asks whether you are sure you want to open it, click **Open**. The window should have a light background and a colored prompt.

7. **Set iTerm2's font.** The prompt's symbols need the MesloLGS NF font, and this is the one setting the script cannot change for you. With iTerm2 open, press **Command-comma** to open its settings window, click **Profiles**, click the **Text** tab, click the font name under **Font**, and choose **MesloLGS NF**. Close the settings window.

8. **Open Visual Studio Code.** Open your **Applications** folder and double-click **Visual Studio Code**. If macOS asks whether you are sure you want to open it, click **Open**. The editor should already use the p5.js Editor Light theme.

Your Mac is set up.

## Check that everything works

Run these checks in a new iTerm2 window. Each one takes a few seconds.

1. **Look at the window.** The background is light gray-white, and the prompt shows your folder name in color with small symbols, not boxes or question marks.
2. **Check Homebrew.** Run `brew --version`. It prints a line starting with `Homebrew` and a version number.
3. **Check the `code` command.** Run `code --version`. It prints a version number.
4. **Check the color highlighting.** Type `echo` without pressing Return; it turns blue. Delete it and type `ecko`; it turns pink, because `ecko` is not a real command. Delete it before going on.
5. **Check the folder colors.** Run `ls`. Folder names appear in blue.
6. **Check the settings links.** Run `ls -l ~/.zshrc`. The line ends with an arrow pointing into your `DeveloperTools` folder, such as `-> /Users/yourname/DeveloperTools/.zshrc`.
7. **Check Visual Studio Code.** Open Visual Studio Code. The editor uses the light p5.js Editor Light theme. Press **Command-Shift-X** to open the Extensions view; **p5.vscode** and **Live Server** are in the list of installed extensions.
8. **Check Visual Studio Code's terminal.** In Visual Studio Code, press **Control-`** (the key above Tab) to open the terminal. It shows the same colored prompt with symbols.

If a check fails, run the setup command from step 2 again, then repeat the checks. If it still fails, see [If something goes wrong](#if-something-goes-wrong).

## A note on running commands from the internet

The setup command runs a script straight from the internet, without showing it to you first. Homebrew's own installer works the same way. Only run commands like this when you trust where they come from: here, that is this repository, which your teacher maintains. You can read [bootstrap.sh](bootstrap.sh) before you run it.

## Keep the folder where it is

Keep the `DeveloperTools` folder in your home folder, and do not rename or delete it. Your settings files are *linked* to the files in this folder, the way a shortcut points to a file somewhere else. If the folder moves, the links break, and your terminal and editor lose their settings.

## If something goes wrong

Running the setup command again is always safe. The scripts skip anything that is already installed, update your copy of this repository, and finish the rest. To run it again, open iTerm2 (or Terminal, if iTerm2 is not installed yet), paste the same command from step 2, and press **Return**.

These are the most common problems and their fixes:

- **`...DeveloperTools already exists but is not a copy of this repository`**: Your home folder already has a folder named `DeveloperTools` that did not come from this repository. Rename that folder in Finder, then run the setup command again.
- **`The Command Line Tools are still not installed`**: The Command Line Tools installation did not finish. Run the setup command again. If you see this message a second time, ask your teacher for help.
- **`install.sh did not finish, so configure.sh was not run`**: One of the installs failed, often because the internet connection dropped. Read the lines above that message for the reason, then run the setup command again.
- **`Could not update; continuing with the copy already on this Mac`**: Your copy of this repository has changes made on your Mac, so the script kept your copy instead of updating it. Setup still finishes. Show the message to your teacher if you want the newest version.
- **The prompt shows boxes or question marks instead of symbols**: iTerm2's font is not set. Repeat step 7.
- **You need your old settings back**: Your previous files are in the `DeveloperTools-backups` folder in your home folder, in a subfolder named with the date and time the script ran. Ask your teacher before restoring one, because restoring removes the link to this repository.

If none of these fixes the problem, take a screenshot of the Terminal window and show it to your teacher.

## How the scripts work

The scripts are written to be read. If you are curious how a bash script works, open them in Visual Studio Code; every step has a comment explaining what it does.

- `bootstrap.sh` is what the setup command runs. It installs Apple's Command Line Tools, downloads this repository, and runs `setup.sh`.
- `setup.sh` runs the other two scripts in order, and stops if the installs fail.
- `install.sh` installs the programs.
- `configure.sh` links your settings files to this repository and installs the Visual Studio Code extensions listed in `vscode/extensions.txt`.

---

## For contributors

This section is for people who maintain this repository. You will use [Claude Code](https://code.claude.com/docs/en/overview), Anthropic's artificial intelligence coding assistant, which reads this repository's `CLAUDE.md` file every time it starts.

### Get access and a copy of the repository

1. Ask the maintainer, Jeffrey Trevino, to give your GitHub account write access to `LWHSTechnicalArts/DeveloperTools`.
2. Complete the student setup above on your own Mac, so you have Homebrew, the repository in `~/DeveloperTools`, and the linked settings files.
   `bootstrap.sh` downloads the repository from the `main` branch on GitHub, so a change to `bootstrap.sh` reaches students only after it is pushed to `main`.
3. Set up GitHub authentication for `git` on your Mac by following GitHub's guide to [connecting to GitHub with Secure Shell (SSH)](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).
4. Point your copy of the repository at the Secure Shell (SSH) address so that `git push` uses that authentication:

   ```bash
   git -C ~/DeveloperTools remote set-url origin git@github.com:LWHSTechnicalArts/DeveloperTools.git
   ```

### Install and start Claude Code

1. Install Claude Code with Homebrew ([Claude Code setup documentation](https://code.claude.com/docs/en/setup)):

   ```bash
   brew install --cask claude-code
   ```

2. Move into the repository and start Claude Code:

   ```bash
   cd ~/DeveloperTools
   ```

   ```bash
   claude
   ```

3. The first time Claude Code starts, it asks you to sign in. Sign in with a Claude account that has a paid plan, or with an Anthropic Console account, as the setup documentation describes.

Claude Code loads `CLAUDE.md` automatically when it starts in this folder ([Claude Code memory documentation](https://code.claude.com/docs/en/memory)). You do not need to point it at the file.

### What CLAUDE.md contains

`CLAUDE.md` is the project's shared memory for Claude Code. It records what each file is for, where the live copies are linked, the p5.js color palette, the decisions made so far and why, the open tasks, the code conventions, and how replies should be written. Read it once yourself before your first change; it is the fastest way to learn the project.

Keep `CLAUDE.md` accurate. When a change makes something in it untrue, such as a new file, a finished open task, or a new decision, update `CLAUDE.md` in the same commit. You can ask Claude Code to do this for you.

`CLAUDE.md` includes a section on how Claude should reply, written for the maintainer. To add your own preferences without changing the shared file, put them in a file named `CLAUDE.local.md` in the repository folder, which Claude Code also loads ([Claude Code memory documentation](https://code.claude.com/docs/en/memory)). Keep that file out of commits by adding its name to your local exclude list:

```bash
echo "CLAUDE.local.md" >> ~/DeveloperTools/.git/info/exclude
```

### Rules for changes

These rules come from `CLAUDE.md`, and Claude Code follows them too:

- **Your edits are live.** On a machine that ran the setup, `~/.zshrc`, `~/.p10k.zsh`, Visual Studio Code's `settings.json`, and the theme extension are links into this repository. Saving a file here changes your own setup immediately.
- **Keep personal settings out of the repository.** Shell settings for your machine only go in `~/.zshrc.local`, which the shared `.zshrc` loads if it exists. Never commit passwords, tokens, or paths that contain your username.
- **Keep the scripts readable for students.** Every new piece of bash syntax gets a comment that explains it. The scripts must run on the bash version built into macOS (3.2), so avoid associative arrays, `mapfile`, and `${variable,,}`.
- **Keep the palette consistent.** A color changed in the terminal block, the prompt config, or the Visual Studio Code theme usually needs the same change in the other two.
- **Check your work before committing.** Run `bash -n` on any bash script you changed, `zsh -n .zshrc` after changing the shell config, and `python3 -m json.tool` on any JavaScript Object Notation (JSON) file you changed.
- **Write short commit messages.** Use short, lowercase, descriptive messages that match the existing history, for example `added extensions list to configure.sh`.

---

## Reference links

### Agentic engineering with GitHub Copilot

GitHub Copilot is built into Visual Studio Code. These guides explain how to work with it as an *agent*, an assistant that plans and makes changes across your project instead of only suggesting the next line.

- [Access GitHub Copilot for free as a student](https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/enable-copilot/set-up-for-students): how students qualify for free Copilot access through GitHub Education.
- [Set up GitHub Copilot in Visual Studio Code](https://code.visualstudio.com/docs/setup/copilot): signing in to GitHub and turning Copilot on in Visual Studio Code.
- [Build with artificial intelligence in Visual Studio Code](https://code.visualstudio.com/docs/agents/overview): an overview of chat, agents, and the other artificial intelligence features in Visual Studio Code.
- [Understand artificial intelligence agents](https://code.visualstudio.com/docs/agents/concepts/agents): what an agent is and how it differs from chat and code completion.
- [Tutorial: Agentic coding in Visual Studio Code](https://code.visualstudio.com/docs/agents/agents-tutorial): a step-by-step first project built with an agent.
- [Best practices for using artificial intelligence in Visual Studio Code](https://code.visualstudio.com/docs/agents/best-practices): how to write requests, give context, and review what an agent produces.
- [Prompt examples](https://code.visualstudio.com/docs/agents/guides/prompt-examples): sample requests for common tasks.
- [Set up a context engineering flow in Visual Studio Code](https://code.visualstudio.com/docs/agents/guides/context-engineering-guide): planning work in steps and giving the agent the information each step needs.
- [Use custom instructions in Visual Studio Code](https://code.visualstudio.com/docs/agent-customization/custom-instructions): writing standing instructions that Copilot follows in every request, similar to this repository's `CLAUDE.md`.
- [Understand trust and safety for artificial intelligence agents](https://code.visualstudio.com/docs/agents/concepts/trust-and-safety): what an agent is allowed to do on your computer and how to keep it in check.
- [About GitHub Copilot agents](https://docs.github.com/en/copilot/concepts/agent-capabilities/about-agents/about-github-copilot-agents): the agents GitHub offers, including ones that work on GitHub itself.
- [Prompt engineering for GitHub Copilot Chat](https://docs.github.com/en/copilot/concepts/prompting/prompt-engineering): how to phrase requests to get better results.
- [Adding repository custom instructions for GitHub Copilot](https://docs.github.com/en/copilot/how-tos/copilot-on-github/customize-copilot/add-custom-instructions/add-repository-instructions): storing instructions in a repository so everyone's Copilot follows them.
- [GitHub Copilot documentation](https://docs.github.com/en/copilot): GitHub's full Copilot documentation.

### Documentation for everything the scripts install

- **Bash**, the language the setup scripts are written in: [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- **Apple Command Line Tools**: [Installing the command-line tools](https://developer.apple.com/documentation/xcode/installing-the-command-line-tools)
- **git**: [Git documentation](https://git-scm.com/docs)
- **Homebrew**: [Homebrew Documentation](https://docs.brew.sh)
- **iTerm2**: [iTerm2 Documentation](https://iterm2.com/documentation.html) and [Homebrew's iterm2 package](https://formulae.brew.sh/cask/iterm2)
- **Visual Studio Code**: [Visual Studio Code documentation](https://code.visualstudio.com/docs), [the `code` command line](https://code.visualstudio.com/docs/configure/command-line), [color themes](https://code.visualstudio.com/docs/configure/themes), and [Homebrew's visual-studio-code package](https://formulae.brew.sh/cask/visual-studio-code)
- **p5.vscode** extension: [p5.vscode on the Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=samplavigne.p5-vscode)
- **Live Server** extension: [Live Server on the Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
- **p5.js**, the library the p5.vscode extension supports: [p5.js reference](https://p5js.org/reference/)
- **zsh**, the shell in Terminal and iTerm2: [Use zsh as the default shell on your Mac](https://support.apple.com/en-us/102360) and [zsh documentation](https://zsh.sourceforge.io/Doc/)
- **oh-my-zsh**: [oh-my-zsh wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- **Powerlevel10k**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- **MesloLGS NF** font: [Powerlevel10k font guide](https://github.com/romkatv/powerlevel10k/blob/master/font.md)
- **zsh-autosuggestions**: [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- **zsh-syntax-highlighting**: [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

# DeveloperTools

This repo
(`LWHSTechnicalArts/DeveloperTools` on GitHub) makes every student machine match
the p5.js web editor's **light** color scheme in Visual Studio Code and
the zsh prompt.

The setup must install with a bash script and a few shared files: no menu
navigation and no point-and-click steps.

## Repo contents

The repo is the single source of truth. Since 2026-10-17, all four live
locations on Jeffrey's machine are **symlinks** into this repo, so edits here
take effect live, and changes made through Visual Studio Code's Settings screen
land in `vscode/settings.json`. The originals are backed up in
`~/DeveloperTools-backups/2026-10-17/`. A program that rewrites one of these files
can replace its link with a regular file; check with `ls -la` (look for `->`).

| Repo file | Symlinked from on Jeffrey's machine | What it is |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | oh-my-zsh, Powerlevel10k, nvm, conda, Homebrew zsh plugins, and the iTerm2 `SetColors` palette block (kept for Jeffrey's own iTerm2; students no longer get iTerm2) |
| `zsh/p5js-editor-light.p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt config, ending with `ZSH_HIGHLIGHT_STYLES` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` | Jeffrey's own Visual Studio Code settings |
| `vscode/p5js-editor-light/` | `~/.vscode/extensions/p5js-editor-light/` | Theme extension: `package.json` (publisher `local`, `uiTheme` `vs`, version 0.0.1) and `themes/p5js-editor-light-color-theme.json` |

The repo has three folders: `scripts/` (the four setup scripts), `zsh/` (`.zshrc` and the Powerlevel10k config), and `vscode/` (`settings.json`, `extensions.txt`, and the theme extension). `configure.sh` finds the repo root as the parent of `scripts/`. The scripts set up a Mac. Their comments teach bash to students, so keep
them accurate and in that teaching style when editing. They must run on macOS's
built-in bash 3.2: no associative arrays, `mapfile` or `${variable,,}`. Every
step skips work that is already done, so each script is safe to rerun.

- `bootstrap.sh` is what students run first, with the one-line command in `README.md`: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/LWHSTechnicalArts/DeveloperTools/main/scripts/bootstrap.sh)"`. Running it through `bash -c` (not `curl | bash`) keeps the terminal as standard input, so `sudo` and `read` work. It installs Apple's Command Line Tools if `xcode-select -p` fails, using Homebrew's headless method (a placeholder file in `/tmp`, then `softwareupdate -i` with the newest "Command Line Tools" label) and falling back to `xcode-select --install` plus a Return-to-continue prompt; it clones the repo into `~/DeveloperTools`, or runs `git pull --ff-only` if it is already there (continuing on failure), and refuses if `~/DeveloperTools` exists but is not a git repository; then it `exec`s `scripts/setup.sh`. Students get `bootstrap.sh` from `main` on GitHub, so changes reach them only after a push.
- `setup.sh` runs the install and configure steps (`bash scripts/setup.sh` from the repo folder). It runs `install.sh`, then runs `configure.sh` only if `install.sh` exited with status 0; otherwise it prints an error and exits 1.
- `install.sh` installs, in order: Homebrew (`sudo -v` caches the administrator password, then the official installer runs with `NONINTERACTIVE=1`, which makes it use `sudo -n`); the `brew shellenv` line appended to `~/.zprofile`; Visual Studio Code with `brew install --cask` (skipped when the app is already in `/Applications`, since `brew` refuses to overwrite an app it did not install); the Homebrew formulae `zsh-autosuggestions` and `zsh-syntax-highlighting`; oh-my-zsh (`KEEP_ZSHRC=yes`, `--unattended`); `git clone --depth=1` of Powerlevel10k into `~/.oh-my-zsh/custom/themes/powerlevel10k`; and the four MesloLGS NF `.ttf` files from `romkatv/powerlevel10k-media` into `~/Library/Fonts`. Last, it installs the Homebrew cask `font-inconsolata` (Inconsolata, SIL Open Font License) for the editor.
- `configure.sh` recreates all four symlinks, moving anything in the way into `~/DeveloperTools-backups/<date_time>/` and creating missing parent folders. It then installs each extension in `vscode/extensions.txt` (one `publisher.name` per line; `#` comments and blank lines skipped) with `code --install-extension`, using `code` from the command path or from inside `/Applications/Visual Studio Code.app`. The list holds `samplavigne.p5-vscode`, `ritwickdey.LiveServer` and `usernamehw.errorlens`; p5.vscode's extension pack already includes Live Server, and Live Server is not built into Visual Studio Code. GitHub Copilot is built in (`GitHub.copilot-chat`), so it is not in the list.

Facts about these files that matter for distributing them to students:

- `.zshrc` has no machine-specific paths. It uses `$HOME/.oh-my-zsh` and loads both zsh plugins from `${HOMEBREW_PREFIX:-/opt/homebrew}/share/...` (`HOMEBREW_PREFIX` comes from `brew shellenv` in `~/.zprofile`). Its last line sources `~/.zshrc.local` if that file exists.
- Machine-specific shell settings go in `~/.zshrc.local`, which lives outside the repo. Jeffrey's holds only the conda block. The TeX path comes from `/etc/paths.d/TeX` and `$HOME/.local/bin` from `~/.zprofile`. Put new personal settings there, not in `.zshrc`.
- `vscode/settings.json` sets `editor.fontFamily` to `Inconsolata, Menlo, monospace` so the editor looks different from the terminal (`terminal.integrated.fontFamily` is `MesloLGS NF`), because beginners confuse the two. Consolas was the first model, but it is a proprietary Microsoft font that cannot be installed by script; Inconsolata's designer cites Consolas as an inspiration (https://levien.com/type/myfonts/inconsolata.html). Roboto Mono was tried more than once on 2026-10-17; Jeffrey's current choice is Inconsolata. `editor.fontSize` and `terminal.integrated.fontSize` are both 18 (pixels), matching the p5.js web editor's default `fontSize: 18` in `client/modules/IDE/reducers/preferences.ts`.
- p5.vscode 1.2.16 (last updated 2024-08-09) ships `p5types/tsconfig.json` with a `files` list naming `test/index.ts` and `test/unaugmented.ts`, which the extension does not include, and `"baseUrl": "../"`, which TypeScript 6 (bundled with VS Code 1.142) marks deprecated. Any project made with Create p5.js Project gets a `jsconfig.json` that includes `p5types/global.d.ts`, so VS Code loads that tsconfig and shows 3 errors in the Problems panel. `configure.sh` therefore overwrites the file (with a here document) with a copy that drops `baseUrl` and lists only `index.d.ts`, skipping it when `baseUrl` is already gone. Checked with VS Code's TypeScript 6.0.3: original 3 diagnostics, patched 0, and no type errors. Reinstalling the extension restores the original, so rerun `configure.sh`.
- To make mistakes easier to see and fix (2026-10-18): `editor.guides.bracketPairs: true` in `settings.json`; the Error Lens extension in `extensions.txt` (Code Spell Checker was added and then removed the same day); and a `command_not_found_handler` function in `zsh/.zshrc` that prints `"NAME" is not a command. Check the spelling, or press the Up arrow to fix it.` to standard error and returns 127, so the prompt still shows the failure mark.
- To make the terminal safer and more legible (2026-10-18): `zsh/.zshrc` defines an `rm` function that prints `(Type y and press Return to delete, or n and Return to keep.)` to standard error and then runs `command rm -i "$@"` (macOS `rm` cannot change its own "remove FILE?" wording, per `man rm`; a later `-f` overrides `-i`) and `alias ls='ls -FG'` (trailing `/` on folders; `-G` keeps the color oh-my-zsh's `ls -G` alias gave); `settings.json` sets `editor.mouseWheelZoom: true` (Command-scroll zooms the editor) and `terminal.integrated.cursorStyle: "line"`.
- To behave like the p5.js web editor, whose defaults include `autosave: true` and `linewrap: true` (`client/modules/IDE/reducers/preferences.ts`), `vscode/settings.json` sets `files.autoSave: "afterDelay"` and `editor.wordWrap: "on"` (2026-10-18). Autosave also means Live Server shows the latest code without a manual save. Line numbers and auto-closing brackets and quotes are already Visual Studio Code defaults.
- To reduce clutter for beginners (2026-10-18), `vscode/settings.json` turns off sticky scroll (`editor.stickyScroll.enabled: false`), and opens to an empty window (`workbench.startupEditor: "none"`). Breadcrumbs, the file path above the editor, stay on by Jeffrey's choice, and so does the minimap (`editor.minimap.enabled: true`), which he turned back on.
- `vscode/settings.json` has no file paths. Visual Studio Code user settings cannot include another file, so per-machine settings have no equivalent of `~/.zshrc.local`. It still has entries for extensions students do not get: Vim cursor style and two Claude Code options, plus GitHub Copilot options.
- Jeffrey's machine still has an unused git copy of zsh-syntax-highlighting in `~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting`.
- The theme's terminal bright green is `#47820a` and bright blue is `#0b7ca9`.

Files from the earlier Chat-side work that are **not** in this repo:
`setup-vscode.sh`, `p5js-editor-light.itermcolors`, `p5js-editor-light.zip`, and
`p5js-editor-dark-color-theme.json`. The dark theme was built by mistake and is
superseded.

## Palette

Values come from the p5.js web editor's variables stylesheet (light theme).

- Surfaces: page `#fbfbfb`, console `#f0f0f0`, selected `#d9d9d9`, borders `#a6a6a6`, text `#333333`.
- Syntax: comments `#747474`; variables and definitions `#0b7ca9`; strings `#47820a`; regular expressions `#a06801`; atoms and tags `#d52889`; keywords and operators `#7a5a3a`; properties, numbers, attributes and local variables `#333333`.
- Accents: magenta `#ed225d`, active magenta `#f10046`.
- Unverified: the editor's CodeMirror theme files were never retrieved, so the operator color and the line-number color (`#747474`) are guesses.

## Decisions and reasons

- iTerm2 was removed from the student setup on 2026-10-17 to reduce complexity: students use Visual Studio Code's built-in terminal, whose font, size and colors all come from `settings.json` and the theme with no manual steps. iTerm2 needed a by-hand font change. The guarded iTerm2 `SetColors` block stays in `.zshrc` because it does nothing in other terminals. The iTerm2 notes below are kept as history.
- The prompt uses no green, because light green is unreadable on white. Clean version-control state and success status are blue; untracked files are brown.
- Exception, by Jeffrey's choice on 2026-10-17: zsh-syntax-highlighting colors invalid commands a pale yellow-green, bold `#afc641` (`#96b403` mixed 25% toward the page color `#fbfbfb`), set as `ZSH_HIGHLIGHT_STYLES[unknown-token]` in `zsh/p5js-editor-light.p10k.zsh`. It is deliberately outside the p5.js palette so mistakes look clearly wrong next to the magenta accent. It contrasts about 1.9:1 on `#fbfbfb`, the background of iTerm2 and of Visual Studio Code's terminal. Valid commands stay blue `#0b7ca9`, reserved words brown `#7a5a3a`.
- The prompt has two lines. The top line has directory and version-control segments on the left and status, command duration and background jobs on the right (the clock was removed on 2026-10-18 to reduce clutter; its `POWERLEVEL9K_TIME_*` color settings remain, unused). The second line has the prompt character.
- Hexadecimal prompt colors need a terminal with 24-bit color.
- `ZSH_HIGHLIGHT_STYLES` only takes effect when the zsh-syntax-highlighting plugin is installed.
- Colors printed by programs such as Homebrew come from the terminal palette, not the prompt. The `.zshrc` block sets the whole iTerm2 palette per session with `OSC 1337 ; SetColors=key=value`, guarded by `TERM_PROGRAM == iTerm.app`, after the line that sources `~/.p10k.zsh`. Source: https://iterm2.com/documentation-escape-codes.html
- Set the palette in one block. Jeffrey rejected palette lines added one slot at a time. Keep color changes inside the named config files, not in ad hoc palette lines.
- Visual Studio Code's terminal background is `#fbfbfb` (`terminal.background` in the theme), matching the editor and iTerm2, by Jeffrey's request on 2026-10-17; it was the console grey `#f0f0f0`. The surrounding panel (`panel.background`) stays `#f0f0f0`. The prompt's version-control and status segments keep `#f0f0f0` backgrounds, so they now show as light grey blocks, and the prompt character's `#fbfbfb` background blends in.
- `terminal.integrated.minimumContrastRatio` is 1, because Visual Studio Code otherwise shifts text below 4.5:1 contrast, which turned `#ed225d` on `#f0f0f0` (about 3.7:1) dark red. A theme cannot change this setting. Source: https://code.visualstudio.com/docs/terminal/appearance
- The setup script installs the MesloLGS NF font by downloading it from Powerlevel10k's media repository, not by bundling it, because redistribution terms are unconfirmed. Shipping a finished prompt config skips the `p10k configure` wizard that would otherwise offer the font. Source: https://github.com/romkatv/powerlevel10k/blob/master/font.md
- iTerm2 loads profiles live from `~/Library/Application Support/iTerm2/DynamicProfiles/`. This could set font and colors without menus, but it is not built, and it is unconfirmed whether a dynamic profile can become the default without a click.
- The blue right-pointing triangle beside the prompt is an iTerm2 mark indicator. It is hidden only through Preferences > Profiles > Terminal > "Show mark indicators", not through the prompt config.
- The `.zshrc` color block does nothing in the built-in macOS Terminal.

## Open tasks

1. Run the bootstrap command on a real second Mac, ideally a fresh one. So far `bootstrap.sh`, `setup.sh` and `install.sh` have only run against stub commands, so the headless Command Line Tools install is untested.
2. Decide whether the shared `settings.json` keeps the Vim, Claude Code and Copilot entries.
3. Test two prompt details never checked in a real terminal: the gap between the left and right parts of the top line, and the closing arrow after the version-control segment.
4. Test palette output with `brew install --dry-run ffmpeg`. An empty `brew upgrade --dry-run` means nothing is outdated.

## Working here

- The GitHub org is shared with students, so keep secrets, tokens and private details out of committed files.
- Keep the palette consistent across the terminal block, the prompt config and the Visual Studio Code theme.
- Note any new dependency the setup gains.
- Validate before calling a change done: `zsh -n` for shell files, `bash -n` for bash scripts, and `python3 -m json.tool` for JSON.
- Package extensions as a zip with one top-level folder.
- Commit on `main` with short, lowercase, descriptive messages, matching the existing history.

## Code conventions

- Use full-word variable names.
- Start `for` loop indexes at 0.
- Move long math out of function arguments into named variables.
- Name functions with verbs, with a `get` prefix for functions that return values.

## How to reply to Jeffrey

- Answer concisely, in bulleted complete sentences instead of paragraphs.
- Never evaluate Jeffrey's choices, and never call anything good, correct or wise unless he asks a yes-or-no question. Say plainly when something is wrong.
- Never use an acronym except in parentheses after the fully spelled-out name.
- Never build or offer anything he has not explicitly requested, and never ask him for more information.
- Cite every statistic and statement of fact.
- Prefer detailed text explanations. Make a visualization only when he says "show me" or asks for a preview.
- Add no extension, bonus or "further ideas" sections.
- Open each paragraph with a topic sentence, never a bold label fragment.
- Do not refer forward to material that comes later.
- Give direct instructions instead of "just remember to" rules, and commit to one method.
- Give installation steps as numbered actions.

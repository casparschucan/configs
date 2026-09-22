# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Personal dotfiles for an Arch Linux + Sway (Wayland) desktop setup. There is no
build, lint, or test suite — this is configuration only. "Testing" a change
means applying the config (e.g. `swaymsg reload`, restarting the affected
program, or sourcing `.bashrc`) and checking it behaves as expected.

## Layout

Each top-level directory mirrors a directory that gets symlinked into
`~/.config/` (see `scripts/setup.sh`), with the one exception being `bash/`,
whose dotfiles are symlinked directly into `$HOME` instead of `~/.config/`.

- `sway/config` — window manager config (Mod4/Super as `$mod`, vim-style
  `hjkl` navigation, `foot` terminal, `fuzzel` launcher, `lock_blurred` for
  locking). Contains machine-specific `output` position lines for at least
  three known setups (laptop, HP ProDesk dual monitor, PSI setup) — when
  editing outputs, keep all of these variants rather than replacing them.
- `swaylock`, `wlogout`, `foot`, `fuzzel`, `i3status-rust`, `gtk-3.0`,
  `zathura` — companion app configs used from within the Sway session.
- `pulse/default.pa` — PulseAudio (not PipeWire) user config. Includes
  `/etc/pulse/default.pa` first, then reloads `module-bluetooth-policy` with
  `auto_switch=0`. Automatic A2DP↔HFP switching is deliberately off: every
  switch destroys and recreates the card's sink and source, which makes a
  browser in a video call re-enumerate devices, which opens another probe
  stream, which triggers another switch — audio flaps between headset and
  laptop for the whole call. Pick a profile explicitly with `bt_audio_mode`
  instead. Unlike the other directories this is symlinked as a *single file*,
  not a directory, because `~/.config/pulse` also holds runtime state.
- `xdg-desktop-portal-wlr/config` — screencast backend used for screen sharing
  in the browser. Sets `chooser_type=dmenu` with `fuzzel --dmenu` because the
  default chooser is `slurp`, which waits for a mouse click/drag on the output
  and so looks like the share silently failing. Requires the
  `xdg-desktop-portal-wlr` package; sway ships the `portals.conf` that routes
  `ScreenCast` to it, so no further portal config is needed.
- `nvim/` — Neovim config using `vim-plug` (not lazy.nvim/packer). Entry point
  `init.lua` requires, in order: `plugins`, `options`, `lsp`, `git_signs`,
  `markdown`, `keybinds` from `nvim/lua/`. LSP servers are configured with the
  native Neovim 0.11+ `vim.lsp.config` / `vim.lsp.enable` API (not
  `nvim-lspconfig`'s setup functions), with per-server overrides for `clangd`
  (forces `--offset-encoding=utf-16`), `pylsp` (disables most linter plugins,
  keeps flake8), and `julials` (custom launch command invoking
  `LanguageServer.jl` directly). Completion is `nvim-cmp` + `vsnip` (not
  `luasnip`). `markdown.lua` sets up `nvim-treesitter` (ensuring the
  `markdown`/`markdown_inline` parsers, since nothing else in this config
  configures treesitter despite the plugin being installed) and
  `render-markdown.nvim`; toggle rendering with `<leader>mr`.
- `bash/` — `.bashrc` sources `.bash_prompt` and `.bash_aliases`; these three
  files get symlinked straight into `$HOME`, not `~/.config/`.
- `scripts/setup.sh` — idempotent-ish provisioning script for a fresh Arch
  install: installs pacman/yay packages, enables `bluetooth.service` and
  `docker.service` (and adds the user to the `docker` group), sets
  git identity, symlinks every
  config directory into `~/.config` (then fixes up `pulse/` as described
  above), symlinks `scripts/bin/*` into
  `/usr/local/bin`, installs vim-plug + runs `:PlugInstall`, and replaces
  `~/.bashrc` with the symlinked version. It is destructive (removes the
  existing `~/.bashrc`, assumes a clean `~/.config`) — treat edits to it
  carefully since it's meant to be run once on a new machine, not repeatedly.
- `scripts/bin/bt_audio_mode` — switches the connected Bluetooth headset
  between `handsfree_head_unit` (mono, has a mic — for calls) and `a2dp_sink`
  (stereo, no mic — for music), then re-points PulseAudio's default sink and
  source and moves any live streams over. Needed because automatic switching is
  disabled in `pulse/default.pa`; a headset can only do one profile at a time.
- `scripts/bin/lock_blurred` — screenshots the current screen, blurs it with
  ImageMagick, then calls `swaylock`; this is the `$lock` command referenced
  from `sway/config`.

## Conventions to preserve when editing

- Sway keybindings follow vim-style directions (`h`/`j`/`k`/`l`) mirrored by
  arrow keys for the same action — add both when introducing new directional
  binds.
- Neovim plugin management is `vim-plug` (`Plug(...)` calls in
  `nvim/lua/plugins.lua` + `vim.call('plug#begin'/'plug#end')`), not a
  Lua-native plugin manager — don't introduce a second plugin manager.

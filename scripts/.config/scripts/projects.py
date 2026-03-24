#!/usr/bin/env python
import os
import json
import subprocess
from pathlib import Path
from datetime import datetime

# ── Config ──────────────────────────────────────────────────────────────────
terminal = "ghostty"
base_dir = Path.home() / ".config/Projects"
rofi_theme = Path.home() / ".config/rofi/style_3.rasi"
cache_file = Path.home() / ".cache/project_history.json"
# ─────────────────────────────────────────────────────────────────────────────

rofi_base = [
    "rofi",
    "-dmenu",
    "-i",
    "-matching",
    "fuzzy",
    "-theme",
    str(rofi_theme),
]

# ── Cache helpers ─────────────────────────────────────────────────────────────


def load_cache() -> dict:
    if cache_file.exists():
        try:
            return json.loads(cache_file.read_text())
        except json.JSONDecodeError:
            pass
    return {}


def save_cache(cache: dict):
    cache_file.parent.mkdir(parents=True, exist_ok=True)
    cache_file.write_text(json.dumps(cache, indent=2))


def record_open(path: Path):
    cache = load_cache()
    key = str(path)
    entry = cache.get(key, {"last_opened": None, "open_count": 0})
    entry["last_opened"] = datetime.now().isoformat()
    entry["open_count"] = entry["open_count"] + 1
    cache[key] = entry
    save_cache(cache)


# ── Git helpers ───────────────────────────────────────────────────────────────


def git_status_icon(path: Path) -> str:
    try:
        r = subprocess.run(
            ["git", "-C", str(path), "rev-parse", "--is-inside-work-tree"],
            capture_output=True,
            text=True,
        )
        if r.returncode != 0:
            return ""

        dirty = subprocess.run(
            ["git", "-C", str(path), "status", "--porcelain"],
            capture_output=True,
            text=True,
        ).stdout.strip()

        ab = subprocess.run(
            [
                "git",
                "-C",
                str(path),
                "rev-list",
                "--count",
                "--left-right",
                "@{upstream}...HEAD",
            ],
            capture_output=True,
            text=True,
        ).stdout.strip()

        badge = " [git"
        if dirty:
            badge += " *"
        if ab:
            try:
                behind, ahead = ab.split("\t")
                if int(ahead) > 0:
                    badge += f" ↑{ahead}"
                if int(behind) > 0:
                    badge += f" ↓{behind}"
            except ValueError:
                pass
        badge += "]"
        return badge
    except Exception:
        return ""


# ── Rofi helpers ──────────────────────────────────────────────────────────────


def show_rofi_menu(items: list[str], prompt: str = "Select") -> str | None:
    if not items:
        return None
    result = subprocess.run(
        rofi_base + ["-p", prompt],
        input="\n".join(items),
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() if result.returncode == 0 else None


def prompt_input(prompt: str) -> str | None:
    result = subprocess.run(
        rofi_base + ["-p", prompt, "-no-show-match", "-no-sort"],
        input="",
        capture_output=True,
        text=True,
    )
    val = result.stdout.strip()
    return val if val else None


def show_rofi_menu_with_preview(
    items: list[str], paths: list[Path], prompt: str = "Select"
) -> str | None:
    if not items:
        return None

    lookup_file = Path("/tmp/.project_launcher_lookup.json")
    lookup = {label: str(p) for label, p in zip(items, paths)}
    lookup_file.write_text(json.dumps(lookup))

    preview_script = Path("/tmp/.project_launcher_preview.sh")
    preview_script.write_text(
        "#!/usr/bin/env bash\n"
        f'python3 -c "\n'
        "import json, sys\n"
        f"lookup = json.loads(open('{lookup_file}').read())\n"
        "label = sys.argv[1]\n"
        "path = lookup.get(label)\n"
        "if not path:\n    print('(unknown)')\n    exit()\n"
        "from pathlib import Path\n"
        "p = Path(path)\n"
        "print('PATH:', path)\n"
        "print()\n"
        "entries = sorted(p.iterdir(), key=lambda x:(x.is_file(),x.name)) if p.exists() else []\n"
        "for e in entries[:18]:\n"
        "    print(('  ' if e.is_file() else '▸ ') + e.name)\n"
        "if len(entries) > 18:\n    print('  ...')\n"
        '" "$1"\n'
    )
    preview_script.chmod(0o755)

    result = subprocess.run(
        rofi_base + ["-p", prompt, "-preview-cmd", str(preview_script) + " {q}"],
        input="\n".join(items),
        capture_output=True,
        text=True,
    )
    return result.stdout.strip() if result.returncode == 0 else None


# ── Notify ────────────────────────────────────────────────────────────────────


def notify(title: str, message: str, urgency: str = "normal", timeout: int = 3000):
    subprocess.run(
        [
            "notify-send",
            title,
            message,
            f"--urgency={urgency}",
            f"--expire-time={timeout}",
        ],
        capture_output=True,
    )


# ── Open actions ──────────────────────────────────────────────────────────────


def open_tmux(dir_path: Path):
    session_name = dir_path.name
    subprocess.Popen(
        [
            terminal,
            "-e",
            "tmux",
            "new-session",
            "-As",
            session_name,
            "-c",
            str(dir_path),
        ]
    )


def open_zed(dir_path: Path):
    subprocess.Popen(["zeditor", str(dir_path)])


def open_neovide(dir_path: Path):
    subprocess.Popen(["neovide", str(dir_path)])


def choose_open_action(dir_path: Path):
    options = [
        "  tmux session",
        "  zed editor",
        "  neovide",
    ]
    choice = show_rofi_menu(options, prompt="Open with")
    if not choice:
        return
    if "neovide" in choice:
        open_neovide(dir_path)
    elif "tmux" in choice:
        open_tmux(dir_path)
    elif "zed" in choice:
        open_zed(dir_path)


# ── Project list builder ──────────────────────────────────────────────────────


def build_sorted_project_list() -> list[tuple[str, Path]]:
    cache = load_cache()
    known: dict[str, Path] = {}

    if base_dir.exists():
        for p in base_dir.iterdir():
            if p.is_dir() and not p.name.startswith("."):
                known[p.name] = p

    for raw_path in cache:
        p = Path(raw_path)
        if p.name not in known:
            known[p.name] = p

    sorted_names = sorted(
        known.keys(),
        key=lambda n: cache.get(str(known[n]), {}).get("last_opened") or "",
        reverse=True,
    )

    result = []
    for name in sorted_names:
        path = known[name]
        badge = git_status_icon(path) if path.exists() else " [missing]"
        entry = cache.get(str(path), {})
        count = entry.get("open_count", 0)
        last = (
            entry.get("last_opened", "")[:10] if entry.get("last_opened") else "never"
        )
        label = f"{name}{badge}   ({last}, {count}×)"
        result.append((label, path))

    return result


# ── Subfolder picker ──────────────────────────────────────────────────────────


def pick_subfolder(parent: Path) -> Path | None:
    subdirs = sorted(
        [p for p in parent.iterdir() if p.is_dir() and not p.name.startswith(".")],
        key=lambda p: p.name,
    )
    if not subdirs:
        return parent

    labels = ["▸ . (open root)"] + [f"  {p.name}{git_status_icon(p)}" for p in subdirs]
    paths = [parent] + subdirs

    chosen = show_rofi_menu(labels, prompt=f"{parent.name}/")
    if not chosen:
        return None

    for label, path in zip(labels, paths):
        if label == chosen:
            return path

    return parent


# ── Actions ───────────────────────────────────────────────────────────────────


def pick_project(prompt="Open project") -> tuple[str | None, Path | None]:
    project_list = build_sorted_project_list()
    if not project_list:
        notify("No projects", f"Add projects to {base_dir}", urgency="low")
        return None, None

    labels = [l for l, _ in project_list]
    paths = [p for _, p in project_list]

    chosen_label = show_rofi_menu_with_preview(labels, paths, prompt=prompt)
    if not chosen_label:
        return None, None

    for label, path in project_list:
        if label == chosen_label:
            return chosen_label, path

    # Typed a new path
    if chosen_label.startswith(("/", "~")):
        return chosen_label, Path(chosen_label).expanduser().resolve()
    return chosen_label, base_dir / chosen_label


def action_open():
    _, dir_path = pick_project("Open project")
    if not dir_path:
        return

    if not dir_path.exists():
        confirm = show_rofi_menu(
            ["No", "Yes"], prompt=f"Create directory: {dir_path.name}?"
        )
        if confirm != "Yes":
            return
        dir_path.mkdir(parents=True, exist_ok=True)
        notify("Created", dir_path.name)

    # If the project has subdirectories, offer to drill into one
    subdirs = [
        p for p in dir_path.iterdir() if p.is_dir() and not p.name.startswith(".")
    ]
    if subdirs:
        dir_path = pick_subfolder(dir_path)
        if not dir_path:
            return

    record_open(dir_path)
    choose_open_action(dir_path)


def action_new():
    name = prompt_input("New project name:")
    if not name:
        return
    dir_path = base_dir / name
    if dir_path.exists():
        notify("Already exists", f"{name} — opening it.")
    else:
        dir_path.mkdir(parents=True, exist_ok=True)
        notify("Created", name)
    record_open(dir_path)
    choose_open_action(dir_path)


def action_rename():
    _, dir_path = pick_project("Rename project")
    if not dir_path:
        return
    newname = prompt_input(f"Rename '{dir_path.name}' to:")
    if not newname:
        return
    newpath = base_dir / newname
    dir_path.rename(newpath)

    cache = load_cache()
    old_key = str(dir_path)
    if old_key in cache:
        cache[str(newpath)] = cache.pop(old_key)
        save_cache(cache)

    notify("Renamed", f"{dir_path.name} → {newname}")


def action_delete():
    _, dir_path = pick_project("Delete project")
    if not dir_path:
        return

    confirm = show_rofi_menu(
        ["No", "Yes – remove directory"],
        prompt=f"Delete: {dir_path.name}?",
    )
    if not confirm or confirm == "No":
        return

    import shutil

    cache = load_cache()
    shutil.rmtree(dir_path, ignore_errors=True)
    cache.pop(str(dir_path), None)
    save_cache(cache)
    notify("Deleted", dir_path.name)


def action_reveal():
    _, dir_path = pick_project("Reveal in file manager")
    if not dir_path or not dir_path.exists():
        return
    for fm in ["thunar", "nautilus", "dolphin", "nemo", "pcmanfm"]:
        if subprocess.run(["which", fm], capture_output=True).returncode == 0:
            subprocess.Popen([fm, str(dir_path)])
            return
    notify("No file manager found", "", urgency="low")


# ── Main ──────────────────────────────────────────────────────────────────────


def main():
    action = show_rofi_menu(
        [
            "  Open project",
            "  New project",
            "  Rename project",
            "  Delete project",
            "  Reveal in file manager",
        ],
        prompt="Project Manager",
    )

    if not action:
        return

    if "Open project" in action:
        action_open()
    elif "New project" in action:
        action_new()
    elif "Rename" in action:
        action_rename()
    elif "Delete" in action:
        action_delete()
    elif "file manager" in action:
        action_reveal()


if __name__ == "__main__":
    main()

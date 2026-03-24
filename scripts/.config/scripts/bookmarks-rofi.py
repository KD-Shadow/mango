#!/usr/bin/env python3

import re
from pathlib import Path
from shutil import which
import subprocess
import sys

CONFIG_DIR = Path.home() / ".config" / "bookmarks"
CONFIG_DIR.mkdir(parents=True, exist_ok=True)

PERSONAL_FILE = CONFIG_DIR / "personal.txt"
WORK_FILE = CONFIG_DIR / "work.txt"

for f in (PERSONAL_FILE, WORK_FILE):
    f.touch(exist_ok=True)

# Make ROFI_THEME optional - script works without custom theme
ROFI_THEME = Path.home() / ".config/rofi/style_4.rasi"
if ROFI_THEME.exists():
    ROFI_BASE = ["rofi", "-dmenu", "-theme", str(ROFI_THEME)]
else:
    ROFI_BASE = ["rofi", "-dmenu"]

Brave = which("brave")
Brave = which("brave")
FALLBACK = which("xdg-open") or which("firefox") or "firefox"


def debug_log(message):
    """Log debug messages to stderr."""
    print(f"DEBUG: {message}", file=sys.stderr)


def notify_send(title, message, urgency="normal", timeout=3000):
    """Send desktop notification."""
    try:
        subprocess.run(
            [
                "notify-send",
                title,
                message,
                f"--urgency={urgency}",
                f"--expire-time={timeout}",
            ],
            capture_output=True,
            check=False,
        )
    except Exception as e:
        debug_log(f"notify-send failed: {e}")


def show_rofi_menu(items, prompt="Select"):
    """Display items in Rofi menu."""
    # Check if rofi is available
    if not which("rofi"):
        debug_log("ERROR: rofi not found in PATH")
        print("Error: rofi is not installed or not in PATH", file=sys.stderr)
        sys.exit(1)

    if not items:
        # For empty list, still allow input
        rofi_args = ROFI_BASE + ["-p", prompt]
    else:
        rofi_input = "\n".join(items)
        rofi_args = ROFI_BASE + ["-p", prompt]

    try:
        if items:
            result = subprocess.run(
                rofi_args,
                input="\n".join(items),
                capture_output=True,
                text=True,
                check=False,
            )
        else:
            result = subprocess.run(
                rofi_args, input="", capture_output=True, text=True, check=False
            )

        debug_log(f"Rofi return code: {result.returncode}")
        if result.returncode == 0:
            return result.stdout.strip()
        else:
            debug_log(f"Rofi cancelled or error: {result.stderr}")
            return None

    except Exception as e:
        debug_log(f"Rofi execution failed: {e}")
        print(f"Error running rofi: {e}", file=sys.stderr)
        sys.exit(1)


def is_valid_url(url):
    """Check if string looks like a valid URL."""
    # Basic pattern for common URLs
    patterns = [
        r"^https?://",  # http/https
        r"^ftp://",  # ftp
        r"^file://",  # local files
        r"^www\.",  # www domains
        r"^[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+",  # domain names
        r"^localhost",  # localhost
        r"^/|^~",  # absolute or home paths
    ]

    url = str(url).strip()
    if not url:
        return False

    # Check if any pattern matches
    for pattern in patterns:
        if re.match(pattern, url):
            return True

    # Check for local files
    try:
        if Path(url).exists():
            return True
    except:
        pass

    return False


def load_bookmarks(file, tag):
    """Load bookmarks from file."""
    tasks = []
    if not file.exists():
        return tasks

    try:
        with file.open("r") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue

                if "::" in line:
                    parts = line.split("::", 1)
                    lhs = parts[0].strip()
                    rhs = parts[1].strip()
                    tasks.append(f"[{tag}] {lhs} :: {rhs}")
                else:
                    tasks.append(f"[{tag}] {line}")
    except Exception as e:
        debug_log(f"Error loading bookmarks from {file}: {e}")

    return tasks


def parse_selection(selected):
    """Parse the user's selection."""
    if not selected:
        return None

    # Existing bookmark: [Tag] Description :: URL
    if selected.startswith("[") and "]" in selected:
        bracket_end = selected.index("]")
        tag = selected[1:bracket_end]
        rest = selected[bracket_end + 1 :].strip()

        if " :: " in rest:
            desc, url = rest.split(" :: ", 1)
            return {"type": "existing", "tag": tag, "desc": desc, "url": url}
        else:
            return {"type": "existing", "tag": tag, "desc": "", "url": rest}

    # New bookmark: Description :: URL
    elif " :: " in selected:
        desc, url = selected.split(" :: ", 1)
        return {"type": "new", "desc": desc.strip(), "url": url.strip()}

    # Raw URL
    else:
        return {"type": "raw", "url": selected.strip()}


def get_browser(tag):
    """Get browser command for tag."""
    tag_lower = (tag or "").lower()

    if tag_lower == "personal":
        browser = Brave or FALLBACK
    elif tag_lower == "work":
        browser = Brave or FALLBACK
    else:
        browser = FALLBACK

    debug_log(f"Selected browser for tag '{tag}': {browser}")
    return browser


def open_url(browser, url):
    """Open URL in browser."""
    if not is_valid_url(url):
        notify_send("Invalid URL", f"Cannot open: {url}", "critical")
        debug_log(f"Invalid URL: {url}")
        return False

    # Ensure URL has protocol if needed
    original_url = url
    if not url.startswith(("http://", "https://", "ftp://", "file://", "/")):
        if url.startswith("www."):
            url = "https://" + url
        else:
            url = "https://" + url

    debug_log(f"Opening URL: {url} (original: {original_url}) with browser: {browser}")

    try:
        subprocess.Popen(
            [browser, url], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
        )
        notify_send("Opening", f"Opening {url}")
        return True
    except Exception as e:
        debug_log(f"Failed to open URL: {e}")
        notify_send("Error", f"Failed to open: {url}", "critical")
        return False


def save_bookmark(desc, url, category):
    """Save bookmark to file."""
    if category == "Personal":
        file = PERSONAL_FILE
    else:
        file = WORK_FILE

    # Format line
    if desc:
        line = f"{desc} :: {url}\n"
    else:
        line = f"{url}\n"

    # Save
    try:
        with file.open("a") as f:
            f.write(line)
        notify_send("Bookmark Saved", f"Added to {category} bookmarks")
        debug_log(f"Saved bookmark to {file}: {line.strip()}")
    except Exception as e:
        debug_log(f"Failed to save bookmark: {e}")
        notify_send("Error", f"Failed to save bookmark", "critical")


def main():
    """Main program."""
    debug_log("Starting bookmark manager")

    # Check for rofi
    if not which("rofi"):
        print("ERROR: rofi is required but not found in PATH", file=sys.stderr)
        print("Install rofi: sudo apt install rofi (or equivalent)", file=sys.stderr)
        sys.exit(1)

    # Load all bookmarks
    debug_log("Loading bookmarks...")
    personal = load_bookmarks(PERSONAL_FILE, "Personal")
    work = load_bookmarks(WORK_FILE, "Work")
    all_bookmarks = personal + work
    all_bookmarks.sort()
    debug_log(f"Loaded {len(all_bookmarks)} bookmarks")

    # If no bookmarks, offer to add one
    if not all_bookmarks:
        debug_log("No bookmarks found, prompting for new URL")
        new_url = show_rofi_menu([], "Enter URL (no bookmarks yet):")
        if new_url:
            category = show_rofi_menu(["Personal", "Work"], "Category:")
            if category:
                save_bookmark("", new_url, category)
        return

    # Show bookmarks menu
    debug_log("Displaying bookmarks menu")
    selected = show_rofi_menu(all_bookmarks, "Bookmarks:")
    if not selected:
        debug_log("No selection made")
        return

    debug_log(f"Selected: {selected}")

    # Parse selection
    parsed = parse_selection(selected)
    if not parsed:
        debug_log("Failed to parse selection")
        return

    debug_log(f"Parsed: {parsed}")

    # Handle based on type
    if parsed["type"] == "existing":
        browser = get_browser(parsed["tag"])
        open_url(browser, parsed["url"])

    elif parsed["type"] == "new":
        category = show_rofi_menu(["Personal", "Work"], "Save to:")
        if category:
            save_bookmark(parsed["desc"], parsed["url"], category)

    elif parsed["type"] == "raw":
        category = show_rofi_menu(["Personal", "Work", "Open Now"], "Action:")
        if category == "Open Now":
            open_url(FALLBACK, parsed["url"])
        elif category in ["Personal", "Work"]:
            save_bookmark("", parsed["url"], category)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        debug_log(f"Unhandled exception: {e}")
        print(f"ERROR: {e}", file=sys.stderr)
        import traceback

        traceback.print_exc()
        sys.exit(1)

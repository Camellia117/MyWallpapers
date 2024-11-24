# Personal Wallpapers

This is a personal repo that helps me automatically rename image files (e.g., `.png` or `.jpg`) in my wallpaper folder, so I can keep my images organized. It renames the files sequentially (like `1.png`, `2.jpg`), and every week it updates the file names and pushes them to my GitHub repo. 

## Features

- Renames new wallpaper images to sequential numbers (e.g., `1.png`, `2.jpg`, ...).
- Automatically adds new images to Git, commits the changes, and pushes them to GitHub.
- The script can be scheduled to run weekly using `cron`.
- Supports `.png` and `.jpg` images.

## Requirements

- Linux-based system (works great on Ubuntu, Arch Linux, etc.).
- Git (SSH setup for pushing changes).
- `cron` for scheduling the task (optional but recommended).
- Neovim (if you're into Neovim and want to edit crontab easily).

## Setup

If you like those pictures. Clone this repo to your local machine:

   ```bash
   git clone https://github.com/Camellia117/MyWallpapers.git
   cd MyWallpapers


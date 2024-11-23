#!/bin/bash

# Configuration
TARGET_DIR="$HOME/Pictures/MyWallpapers" # Replace with your target directory
GIT_DIR="$HOME/Pictures/MyWallpapers"    # Replace with your Git repo directory
EXTENSIONS="png jpg"                     # Supported extensions
BRANCH="master"                          # Target Git branch
DATE=$(date +'%Y-%m-%d %H:%M:%S')

LAST_COUNT_FILE="$HOME/Pictures/MyWallpapers/.last_image_count"
# Function to rename files
rename_files() {
	echo "Renaming files in $TARGET_DIR..."
	count=1
	for ext in $EXTENSIONS; do
		for file in "$TARGET_DIR"/*.$ext; do
			# Skip if no matching files exist
			[ -e "$file" ] || continue

			# Get the new name with correct extension
			new_name="${TARGET_DIR}/${count}.${ext}"
			mv "$file" "$new_name"
			echo "Renamed $file -> $new_name"
			((count++))
		done
	done
}

# Function to push changes to Git
push_to_git() {
	echo "Pushing changes to Git..."
	cd "$GIT_DIR" || {
		echo "Failed to navigate to $GIT_DIR"
		exit 1
	}

	# Check if there are changes
	if git status --porcelain | grep -qE "^\s*[AMDR]"; then
		git add .
		git commit -m "AutoRename: updated images on $DATE"
		git push origin "$BRANCH"
		echo "Changes pushed to remote repo on branch '$BRANCH'."
	else
		echo "No changes detected. Nothing to push."
	fi
}

check_for_new_images() {
	current_count=$(find "$TARGET_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" \) | wc -l)

	# 如果新文件数量增加，执行重命名和 Git 操作
	if [ "$current_count" -gt "$(cat $LAST_COUNT_FILE 2>/dev/null || echo 0)" ]; then
		rename_files
		push_to_git
		echo "$current_count" >"$LAST_COUNT_FILE"
	else
		echo "没有检测到新的图片文件。"
	fi
}

# 主执行流程
echo "开始每次检查和更新..."
check_for_new_images

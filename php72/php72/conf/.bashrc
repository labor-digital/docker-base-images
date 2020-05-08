
# Allows you to run any command as the www-data user
# Simply pass your normal command to this command as argument like: "$ asUser mkdir /your/directory"
asUser() {
	sudo -u www-data -EH "$@"
}

# Helper to make sure a directory has the correct permissions, recursively.
# BUT it will assume that between runs the permissions will not change
# therefore it writes a marker file into the directory to check if it already
# processed the file or not.
#
# This is used for volume mounts in your production environment.
# You can call this function on a mounted directory to ensure the permissions are set correctly
# Every subsequent boot will not update the permissions again as long as the marker file exists
#
# Accepts 2 parameters
# @param $directory The path to the directory to set the permissions for
# @param $permissions By default "u=rwX,g=rwX,o-rwx" but can be set to any other permission value
setPerms() {
	DIR="$1"
	STAT="${2:-"u=rwX,g=rwX,o-rwx"}"

	# Check if we got a directory or skip
	if [[ -d "$DIR" ]]; then
		:
	else
		echo "FAIL: $DIR is not a directory - skip!"
		return
	fi

	# Update the permissions if we don't have the marker yet
	HASH=$(echo -n "$STAT" | md5sum | awk '{print $1}')
	MARKER_FILE_NAME="$DIR/perms-$HASH.set"
	if [ -f "$MARKER_FILE_NAME" ]; then
		echo "Permissions for $DIR should be correct (marker exists at: $MARKER_FILE_NAME)"
	else
		echo "Setting permissions for $DIR, Permissions: $STAT"
		chmod -R "$STAT" "$DIR"
		asUser touch "$MARKER_FILE_NAME"
	fi
}

# Simple helper to make sure a given directory exists. If it not exists it will create it recursively
# It will also call setPerms() on the directory if you pass additional permissions
# as a second parameter. The directory will be created as the www-data user
# @param $directory The path to the directory to create if it does not exist
# @param $permissions By default "u=rwX,g=rwX,o-rwx" but can be set to any other permission value
makeDir() {
	DIR="$1"
	asUser mkdir -p "$DIR"
	setPerms "$DIR"
}

# Deprecated helper to update permissions -> Don't use this anymore!
set_permissions() {
	echo "You should not use the set_permissions() function anymore!"
}

# Allows child containers to extend the bash-rc
# This is used for the development container!
if [ -f "/root/.bashrc-extension" ]; then
	. /root/.bashrc-extension
fi
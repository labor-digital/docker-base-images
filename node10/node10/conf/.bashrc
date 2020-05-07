
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
# @param $owner By default "www-data.www-data" to define the owner of the directory
set_initial_directory_permissions(){
	# Prepare the variables
	DIR="$1"
	STAT="${2:-"u=rwX,g=rwX,o-rwx"}"
	OWNER="${3:-"node.node"}"

	# Check if we got a directory or skip
	if [[ -d "$DIR" ]]; then
		:
	elif [[ -f "$DIR" ]]; then
		echo "FAIL: $DIR is a file not a directory - skip!"
		return
  	else
    	echo "FAIL: $DIR does not exist - skip!"
    return
  	fi

	# Check if the marker already exists
	MARKER_FILE_NAME="$DIR/perms.set"
	if [ -f "$MARKER_FILE_NAME" ]; then
		echo "Permissions for $DIR should be correct (marker exists at: $MARKER_FILE_NAME)"
	else
		echo "Setting permissions for $DIR"
		chown -R "$OWNER" "$DIR"
		chmod -R "$STAT" "$DIR"
		touch "$MARKER_FILE_NAME"
	fi
}

# Simple helper to make sure a given directory exists. If it not exists it will create it recursively
# It will also call set_initial_directory_permissions() on the directory if you pass additional permissions
# as a second parameter
# @param $directory The path to the directory to create if it does not exist
# @param $permissions By default "u=rwX,g=rwX,o-rwx" but can be set to any other permission value
# @param $owner By default "www-data.www-data" to define the owner of the directory
ensure_directory(){
	DIR="$1"
	STAT="${2}"
	OWNER="${3}"
	mkdir -p "$DIR"
	set_initial_directory_permissions "$DIR" "$STAT" "$OWNER"
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
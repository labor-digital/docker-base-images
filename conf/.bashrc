n() {
        chown -R node.node /var/www
        sudo -u node -EH /usr/local/bin/npm "$@"
        set_permissions
}

set_permissions(){
        chown -R node.node /var/www
        chmod -R u=rwX,g=rX,o-rwx /var/www/html
        chmod -R u=rwX,g=rwX,o-rwx /var/www/html_data /var/www/logs
        source /opt/permissions.sh
        echo "Permissions were updated"
}

npm(){
        chown -R node.node /var/www
        sudo -u node -EH /usr/local/bin/npm "$@"
        if [ $? -ne 0 ]
        then
                exit 1
        fi
        set_permissions
}

ncu(){
	sudo -u node -EH /usr/local/bin/ncu "$@"
}
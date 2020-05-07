c() {
        chown -R composer.www-data /var/www
        sudo -u composer -EH /usr/local/bin/composer.phar "$@"
        set_permissions
}

set_permissions(){
        chown -R composer.www-data /var/www
        chmod -R u=rwX,g=rX,o-rwx /var/www/html
        chmod -R u=rwX,g=rwX,o-rwx /var/www/html_data /var/www/logs
        source /opt/permissions.sh
        echo "Permissions were updated"
}

composer(){
        chown -R composer.www-data /var/www
        sudo -u composer -EH /usr/local/bin/composer.phar "$@"
        if [ $? -ne 0 ]
        then
                exit 1
        fi
        set_permissions
}
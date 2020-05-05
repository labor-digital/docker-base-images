set_permissions(){
  echo "You should not use set_permissions() anymore!"
}

c() {
	/usr/local/bin/composer.phar "$@"
}

composer(){
	/usr/local/bin/composer.phar "$@"
	if [ $? -ne 0 ]
	then
			exit 1
	fi
}
# Configuración de la base de datos MySQL
execute 'create-wordpress-db' do
    command "mysql -uroot -proot_password -e 'CREATE DATABASE IF NOT EXISTS wordpress;'"
    sensitive true
end
  
# Crear usuario de WordPress en la base de datos MySQL
execute 'create-wordpress-user' do
    command "mysql -uroot -proot_password -e \"GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost' IDENTIFIED BY 'user_password';\""
    sensitive true
end
  
# Editar php.ini para habilitar la extensión mysqli
execute 'enable-mysqli-extension' do
    command 'sed -i "s/;extension=mysqli/extension=mysqli/" /etc/php/7.2/apache2/php.ini'
    notifies :restart, 'service[apache2]', :immediately
    not_if 'grep "^extension=mysqli" /etc/php/7.2/apache2/php.ini'
end
  
# Generación del archivo wp-config.php
template '/var/www/html/wp-config.php' do
    source 'wp-config.erb'
    variables(
        db_name: 'wordpress',
        db_user: 'wordpress',
        db_password: 'user_password',
        db_host: 'localhost',
        db_charset: 'utf8mb4'
    )
end
# Instalación de wp-cli
execute 'install-wp-cli' do
  command 'curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp-cli'
  not_if 'which wp-cli'
end

# Instalar paquetes necesarios
package 'apache2'
package 'mysql-server'
package 'php'
package 'php-mysql'

# Requerir la receta de la base de datos
include_recipe 'wordpress::database'

# Requerir la receta descarga e instalacion de wordpress
include_recipe 'wordpress::wordpress'

# Habilitar y empezar el servicio Apache
service 'apache2' do
  action [:enable, :start]
end

# Descargar el archivo de WordPress
remote_file '/tmp/latest.tar.gz' do
    source 'https://wordpress.org/latest.tar.gz'
end

# Extraer WordPress en el directorio /var/www/html
execute 'extract-wordpress' do
    command 'tar -xzvf /tmp/latest.tar.gz -C /var/www/html/ --strip-components=1'
    creates '/var/www/html/wp-settings.php'
end
  
# Instalación de WordPress
execute 'install-wordpress' do
    command 'sudo -u www-data -- wp-cli --path=/var/www/html core install --url=http://localhost:8080 --title="Mi Sitio WordPress" --admin_user=unir --admin_password=unir1234 --admin_email=admin@unir.edu.com'
    not_if 'sudo -u www-data -- wp-cli --path=/var/www/html core is-installed'
end
  
# Eliminar el archivo index.html predeterminado si existe
execute 'remove-index-html' do
    command '/bin/rm -f /var/www/html/index.html'
    only_if '/bin/ls /var/www/html/index.html'
end
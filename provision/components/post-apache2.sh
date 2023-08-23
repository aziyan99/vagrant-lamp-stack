#!/bin/bash

echo 'Setup Apache2'

# Create a new vhost config file
if [ $# -ne 2 ]; then
    echo "Usage: $0 <ServerName> <ServerAlias>"
    exit 1
fi

ServerName="$1"
ServerAlias="$2"

VHOST_CONF="/etc/apache2/sites-available/${ServerName}.conf"
DOC_ROOT="/var/www/html"

# Check if the Apache server is installed
if ! command -v apache2 >/dev/null; then
    echo "Apache2 is not installed. Please install Apache2."
    exit 1
fi

# Check if the Apache configuration directory exists
if [ ! -d "/etc/apache2/sites-available" ]; then
    echo "Apache configuration directory not found."
    exit 1
fi

# Create the virtual host configuration
cat > "$VHOST_CONF" <<EOF
<VirtualHost *:80>
    DocumentRoot "$DOC_ROOT"
    ServerName $ServerName
    ServerAlias $ServerAlias
    <Directory "$DOC_ROOT">
        Options All
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

# Disable the default vhost file
sudo a2dissite 000-default

# Enable the virtual host
sudo a2ensite "${ServerName}.conf"

# Enable mod-rewrite
sudo a2enmod rewrite

# Restart for the changes to take effect
sudo systemctl restart apache2

# Change folder permission
sudo chmod 755 -R /var/www/html
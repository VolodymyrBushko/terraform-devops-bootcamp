#!/bin/bash

# Add Docker's official GPG key:
apt apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Install Nginx
apt install -y nginx php-fpm

systemctl stop nginx

rm /var/www/html/index.html

# Configure Nginx
cat <<EOF | tee /etc/nginx/sites-available/default
    server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;
        index index.php index.html index.htm;

        server_name _;

        location / {
            try_files \$uri \$uri/ =404;
        }

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/var/run/php/php-fpm.sock;
        }

        location ~ /\.ht {
            deny all;
        }
    }
EOF

# Create the System Info page
cat <<EOF | tee /var/www/html/index.php
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <title>OS Version Information</title>
    </head>
    <body>

    <h1>Hello World!</h1>
    <h2>OS Version Information</h2>

    <div>
        <?php
            echo "<p><strong>Operating System:</strong> " . php_uname('s') . "</p>";
            echo "<p><strong>Host Name:</strong> " . php_uname('n') . "</p>";
            echo "<p><strong>Release:</strong> " . php_uname('r') . "</p>";
            echo "<p><strong>Version:</strong> " . php_uname('v') . "</p>";
            echo "<p><strong>Machine Type:</strong> " . php_uname('m') . "</p>";
            echo "<p><strong>Docker version :</strong> " . shell_exec('docker --version') . "</p>";
        ?>
    </div>

    </body>
    </html>
EOF

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

systemctl start nginx
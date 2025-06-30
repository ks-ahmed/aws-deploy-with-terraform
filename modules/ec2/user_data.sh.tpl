#!/bin/bash
apt update -y
apt install -y apache2 mysql-client php php-mysql libapache2-mod-php wget tar unzip

# Enable and start Apache
systemctl enable apache2
systemctl start apache2

# Download and install WordPress
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress /var/www/html/wordpress

# Set permissions for WordPress
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# Remove default Apache welcome page
rm -f /var/www/html/index.html

# Custom index.html for VettlyAI

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Welcome to VettlyAI 🚀</title>
  <style>
    body {
      background: #0e1a2b;
      color: #ffffff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      padding: 20px;
      text-align: center;
    }
    h1 {
      font-size: 3rem;
      margin-bottom: 1rem;
      color: #00d9ff;
    }
    p {
      font-size: 1.2rem;
      max-width: 600px;
      line-height: 1.5;
    }
    .highlight {
      color: #00ff99;
      font-weight: bold;
    }
    a.button {
      margin-top: 30px;
      padding: 12px 25px;
      background-color: #00d9ff;
      color: #0e1a2b;
      border: none;
      text-decoration: none;
      border-radius: 5px;
      font-weight: bold;
      font-size: 1rem;
      transition: background-color 0.3s ease;
    }
    a.button:hover {
      background-color: #00b8d4;
    }
    footer {
      position: absolute;
      bottom: 20px;
      font-size: 0.9rem;
      color: #cccccc;
    }
  </style>
</head>
<body>
  <h1>🎉 Welcome to VettlyAI!</h1>
  <p>
    This site is successfully deployed with a cloud-based infrastructure using <span class="highlight">Terraform</span>, featuring an
    <span class="highlight">EC2 instance</span> for hosting a WordPress application, a managed <span class="highlight">Amazon RDS (MySQL)</span> database, and a secure, scalable
    <span class="highlight">VPC architecture</span> with public/private subnets, a NAT Gateway, and Internet Gateway.
  </p>
  <p>
    This site is now running a real-world, production-ready infrastructure — fully automated and deployed in the cloud! 🌐
  </p>

  <a class="button" href="/wordpress">Visit WordPress Site</a>

  <footer>
    &copy; 2025 VettlyAI | Built with 💡 using Terraform, AWS, and open source.
  </footer>
</body>
</html>
EOF


systemctl restart apache2

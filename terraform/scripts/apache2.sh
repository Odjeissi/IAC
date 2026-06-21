#!/bin/bash

# Update system and install Apache (Debian/Ubuntu)
sudo apt update -y
sudo apt install apache2 -y

# Start and enable Apache service
sudo systemctl start apache2
sudo systemctl enable apache2

# Get instance details
PRIVATE_IP=$(hostname -I | awk '{print $1}')
HOSTNAME=$(hostname)

# Create a simple landing page
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Load Balancer Test</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
            background-color: #f4f4f4;
        }
        .card {
            background: white;
            padding: 30px;
            margin: auto;
            width: 500px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
        }
        h1 {
            color: green;
        }
        h2 {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>The Apache Server is working!</h1>
        <h2>Hostname: $HOSTNAME</h2>
        <h2>Private IP: $PRIVATE_IP</h2>
    </div>
</body>
</html>
EOF

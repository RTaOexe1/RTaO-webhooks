#!/bin/bash
set -e
echo "🚀 Installing Docker..."
apt update && apt install docker.io -y
systemctl start docker && systemctl enable docker
echo "🌟 Cloning RTaO-HOOKS..."
git clone https://github.com/RTaOexe1/RTaO-HOOKS.git
cd RTaO-HOOKS
echo "🐳 Building Docker image..."
docker build -t krnl-server .
echo "🏁 Running Docker container..."
docker run -d --restart unless-stopped -p 5000:5000 krnl-server
echo "✅ Setup complete! Visit: http://<VPS_IP>:5000/"

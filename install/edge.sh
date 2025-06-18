curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/microsoft-edge.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main' | tee /etc/apt/sources.list.d/microsoft-edge.list
apt update -y && apt install microsoft-edge-stable -y

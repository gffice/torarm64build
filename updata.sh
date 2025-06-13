mkdir tmp
cd tmp
proxychains wget https://gffice.github.io/torarm64build/bin-amd64.tar.xz
sudo apt update -y && sudo apt full-upgrade -y 
sudo apt -o Acquire::https::Proxy="socks5h://127.0.0.1:9055" update -y && sudo apt -o Acquire::https::Proxy="socks5h://127.0.0.1:9055" full-upgrade -y
# 检查文件是否存在
if [ ! -f "/lib/systemd/system/tor@default.service" ]; then
  echo "文件 /lib/systemd/system/tor@default.service 不存在！"
  exit 1
fi

# 使用 sed 在第5行开头添加 #
sudo sed -i '23 s/^/#/' /lib/systemd/system/tor@default.service

echo "已在 /lib/systemd/system/tor@default.service 的第23行开头添加 # 注释。"
sudo systemctl daemon-reload
sudo systemctl stop tor.service
tar -xJvf bin-amd64.tar.xz
cd appbin
md5sum -c md5
sudo cp lyrebird  snowflake  webtunnel /usr/local/bin/
cd ~ 
rm -rf tmp
sudo systemctl start tor.service

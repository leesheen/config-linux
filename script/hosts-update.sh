bash -c 'wget https://raw.githubusercontent.com/racaljk/hosts/master/hosts -qO /tmp/hosts && sudo mv /tmp/hosts /etc/hosts' 
sudo systemctl restart NetworkManager

## Usage:
All playbooks are targeted towards Ubuntu Server, other distributions will not work
- Clone the repository
```bash
git clone https://github.com/Astatoru/ansible-vps-setup.git
```
- Generate your ED25519 ssh keypair (ONLY ED25519 KEYS ARE SUPPORTED!!!)
```bash
ssh-keygen -t ed25519 -a 32 -C "example@mail.com"
```
- Install dependencies using your package manager
```bash
sudo pacman -Syu python python-pip ansible-core
```
- Create new python virtual environment
```bash
cd ansible-vps-setup
python3 -m venv ".env"
```
- Activate Python virtual environment (you have to execute this everytime before running `playbook.yaml`)
```bash
source ".env/bin/activate"
```
- Install python and ansible dependencies
```bash
pip install -r "requirements.txt"
ansible-galaxy install -r "requirements.yaml"
```
- Add your servers to `inventories/inventory.yaml`
- Fill in `vars/main.yaml`
  - Run the first playbook
  ```bash
  ansible-playbook --ask-pass playbook.yaml
  ```
- Fill in `vars/optional.yaml`
  - Run the second playbook
  ```bash
  ansible-playbook playbook_post.yaml
  ```
## Variables
- `main.yaml`

| Variable       | Description                                                                               | Default value | Data type |
| -------------- | ----------------------------------------------------------------------------------------- | ------------- | --------- |
| `target_hosts` | Which hosts from `inventory/inventory.yaml` would be targeted                             | `all`         | str       |
| `ssh_key`      | Your public ED25519 ssh key that will be copied over to the `~/.ssh/authorized_keys` file | empty         | str       |
| `user`         | User name that will be used when creating non-root user                                   | `user`        | str       |
| `sftpuser`     | User name that will be used when creating SFTP server user                                | `sftpuser`    | str       |
- `optional.yaml`

| Variable          | Description                                                                                                          | Default value | Data type |
| ----------------- | -------------------------------------------------------------------------------------------------------------------- | ------------- | --------- |
| `disable_root`    | Disable root account (Recommended)                                                                                   | `true`        | bool      |
| `block_parasites` | Block subnets of the russian government agencies on the firewall                                                     | `false`       | bool      |
| `install_docker`  | Install Docker, and run Watchtower container                                                                         | `false`       | bool      |
| `install_nginx`   | Install nginx, obtain letsencrypt certificate and add ready to use nginx config for steal-oneself xray configuration | `false`       | bool      |
| `nginx_port`      | Port that nginx would be listening to                                                                                | `42069`       | int       |
| `domain_name`     | Domain name that is tied to the server, this variable should be changed only when `install_nginx` is set to `true`   | `example.com` | str       |
| `install_warp`    | Install warp, configure it as socks5 proxy and connect                                                               | `false`       | bool      |
| `warp_port`       | Port that will be used for socks5 proxy                                                                              | `10086`       | int       |
| `install_xanmod`  | Install Xanmod kernel, that includes a wide range of optimizations, including BBRv3 (not all systems are supported)  | `false`       | bool      |
## Toolkit:
- `neovim` - Text editor
- `lf` - File manager
- `fdfind` - File search
- `gdu` - Disk usage analyzer
- `tldr` - Cheatsheets for console commands
- `firewalld` - Firewall
- `unbound` - DNS client
- `ntpd-rs` - NTP client (in our case it's NTS client)

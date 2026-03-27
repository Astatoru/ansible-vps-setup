# Work in progress, bugs and unexpected behavior might occur
## Usage:
Playbooks are targeted towards Ubuntu Server, other distributions will not work
- Clone the repository
```bash
git clone https://github.com/Astatoru/ansible-vps-setup.git
```
- Generate your ED25519 (ONLY ED25519 KEYS ARE SUPPORTED!!!)
```bash
ssh-keygen -t ed25519 -a 32 -C "example@mail.com"
```
- Install script dependencies using your package manager
```bash
sudo pacman -Syu python python-pip
```
- Run the script that installs dependencies
```bash
chmod u+x init.sh
./init.sh
```
- Activate Python virtual environment
```bash
source ".env/bin/activate"
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
### Variables
- `main.yaml`

| Variable       | Description                                                                               | Value      | Data type |
| -------------- | ----------------------------------------------------------------------------------------- | ---------- | --------- |
| `target_hosts` | Which hosts from `inventory/inventory.yaml` would be targeted                             | `all`      | str       |
| `ssh_key`      | Your public ED25519 ssh key that will be copied over to the `~/.ssh/authorized_keys` file | empty      | str       |
| `user`         | User name that will be used when creating non-root user                                   | `user`     | str       |
| `sftpuser`     | User name that will be used when creating SFTP server user                                | `sftpuser` | str       |
- `optional.yaml`

| Variable          | Description                                                                                                          | Value         | Data type |
| ----------------- | -------------------------------------------------------------------------------------------------------------------- | ------------- | --------- |
| `disable_root`    | Disable root account (Recommended)                                                                                   | `true`        | bool      |
| `block_parasites` | Block subnets of the russian government agencies on the firewal                                                      | `false`       | bool      |
| `install_docker`  | Install Docker, and run Watchtower container                                                                         | `false`       | bool      |
| `install_nginx`   | Install nginx, obtain letsencrypt certificate and add ready to use nginx config for steal-oneself xray configuration | `false`       | bool      |
| `nginx_port`      | Port that nginx would be listening to                                                                                | `42069`       | int       |
| `domain_name`     | Domain name that is tied to the server, this variable should be changed only when `install_nginx` is set to `true`   | `example.com` | str       |
| `install_warp`    | Install warp, configure it as socks5 proxy and connect                                                               | `false`       | bool      |
| `warp_port`       | Port that will be used for socks5 proxy                                                                              | `10086`       | int       |
| `install_xanmod`  | Install Xanmod kernel, that includes a wide range of optimizations, including BBRv3 (not all systems are supported)  | `false`       | bool      |

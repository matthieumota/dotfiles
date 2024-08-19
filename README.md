# Matthieu's Dotfiles

This project serves me to install, configure and maintain my development workflow on macOS / Ubuntu / Arch. Like that, I can easily reset a Mac or Linux machine and start fresh without installing manually !

I'm back to Arch Linux !

## A fresh macOS / Ubuntu / Arch

Before begin to re-install your machine, please check this steps :

- Did you commit and push on all your repositories ?
- Did you save all your documents not present in Cloud.

You can now install a clean macOS or Ubuntu.

## Usage

You can now clone this repository :

```bash
git clone git@github.com:matthieumota/dotfiles.git .dotfiles
cd .dotfiles
# On your Mac
./setup-mac.sh
# On your Ubuntu
./setup-ubuntu.sh
# On your Arch
./setup-arch.sh
```

## Tunnel SSH

Sometime, I need to create SSH tunnel. For instance, to create a tunnel on `3002` port on `1.2.3.4` server for `domain:80` :

```bash
ssh -R 3002:domain:80 -N cloud@1.2.3.4
```

After, we can use a nginx reverse proxy with :

```
location / {
    proxy_pass http://localhost:3002;
    proxy_set_header Host domain;
}
```

We can also make a simple tunnel to remote server :

```bash
ssh -L 3307:localhost:3306 -N cloud@1.2.3.4
```

## Docker

To manage old PHP versions, I have 2 choices :

- Simply install old versions on machine with AUR or PPA.
- Use docker to manage old PHP versions containers, you can find configuration in `docker` folder.

You can use PHP FPM on Nginx (or Apache but no documented) :

```
location ~ \.php$ {
    # 9082 is exposed for PHP 8.2
    # 9081 is exposed for PHP 8.1
    fastcgi_pass 127.0.0.1:9081;
}
```

You can run PHP commands via container :

```bash
docker compose exec php81 php --version
docker compose exec php81 composer
```

Be careful to adapt `Dockerfile` and `compose.yaml` with your information (Project path, name, user id and group id from system) and you can build images

```bash
docker compose up -d --build
```

You can easily add other PHP versions.

## QEMU

We use QEMU for Virtualization. To create a disk :

```bash
qemu-img create -f qcow2 test 10G
```

Create a NAT for network :

```bash
# Create tap and NAT on host
sudo ip tuntap add tap0 mode tap
sudo ip addr add 192.168.100.1/24 dev tap0
sudo ip link set tap0 up
sudo iptables -t nat -A POSTROUTING -o wlp13s0 -s 192.168.100.1/24 -j MASQUERADE
sudo iptables -I DOCKER-USER 1 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -I DOCKER-USER 2 -i tap0 -o wlp13s0 -j ACCEPT

# On the guest without DHCP
sudo ip a add 192.168.100.2/24 dev ens3
sudo ip route add default via 192.168.100.1
```

We can enable DHCP on host in `/etc/NetworkManager/dnsmasq.d/local` :

```bash
address=/bx/127.0.0.1

interface=tap0
bind-interfaces
dhcp-range=192.168.100.2,192.168.100.254
```

Boot with an iso on a disk :

```bash
qemu-system-x86_64 -cdrom ~/Téléchargements/archlinux-2024.08.01-x86_64.iso \
    -boot order=d \
    -drive file=test,format=qcow2 \
    -cpu host -smp 2 -m 2G \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net,netdev=net0 \
    -enable-kvm
```

We can also mount a partition from qcow2 image :

```bash
sudo modprobe nbd
sudo qemu-nbd -c /dev/nbd0 test
sudo qemu-nbd -d /dev/nbd0
```

Run guest after installation :

```bash
qemu-system-x86_64 -drive file=test,format=qcow2 \
    -cpu host -smp 2 -m 2G \
    -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
    -device virtio-net,netdev=net0 \
    -enable-kvm
```

# Matthieu's Dotfiles

This project serves me to install, configure and maintain my development workflow on macOS / Arch. Like that, I can easily reset a Mac or Linux machine and start fresh without installing manually !

I'm back to Arch Linux !

## A fresh macOS / Arch

Before begin to re-install your machine, please check this steps :

- Did you commit and push on all your repositories ?
- Did you save all your documents not present in Cloud.

You can now install a clean macOS or Arch.

## Usage

You can now clone this repository :

```bash
git clone git@github.com:matthieumota/dotfiles.git .dotfiles
cd .dotfiles
# On your Mac
./setup-mac.sh
# On your Arch
./setup-arch.sh
```

## Tunnel SSH

To expose a local site through any server, open a reverse tunnel from the local machine : the port `3002` of the server forwards to `domain:80` locally.

```bash
ssh -R 3002:domain:80 -N cloud@1.2.3.4
```

On the server, a Caddy reverse proxy sends a public domain to this port :

```
public.example.com {
    reverse_proxy localhost:3002 {
        header_up Host domain
    }
}
```

Sometimes, I need to reach a service of a remote server, like its database on `3306`, locally on `3307` :

```bash
ssh -L 3307:localhost:3306 -N cloud@1.2.3.4
```

## VPN

My dev server prints a client config with `vpn arch`, to paste on the client :

```bash
sudo nano /etc/wireguard/wg0.conf      # paste the config here, /opt/homebrew/etc/wireguard on macOS
sudo chmod 600 /etc/wireguard/wg0.conf
sudo wg-quick up wg0                   # wg-quick down wg0 to stop
ssh matthieu@10.8.0.1
```

On iOS, scan the QR code printed by `vpn` with the Wireguard app.

## Docker

To manage old PHP versions, I have 2 choices :

- Simply install old versions on machine with AUR or PPA.
- Use docker to manage old PHP versions containers, you can find configuration in `docker` folder.

The `caddy` service serves `~/Code` on `http://localhost` and each `~/Code/<project>/public` on `http://<project>.localhost`, with PHP 8.1 (see `docker/caddy/Caddyfile`).

You can also use PHP FPM from another Caddy :

```
# 9082 is exposed for PHP 8.2
# 9081 is exposed for PHP 8.1
php_fastcgi 127.0.0.1:9081
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
echo 'nameserver 192.168.1.254' | sudo tee /etc/resolv.conf
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

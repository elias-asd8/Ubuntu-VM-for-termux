#!bin/bash
pkg upgrade -y && pkg install pd
pd install Ubuntu 
pd login ubuntu
apt install aria2
aria2c -x 16 -s 16 "https://releases.ubuntu.com/24.04.4/ubuntu-24.04.4-desktop-amd64.iso" -o ubuntu.iso
qemu-img create -f qcow2 ubuntu.qcow2 70G
qemu-system-x86_64 \
  -m 4096 \
    -cpu max \
      -smp 4 \
        -hda ~/ubuntu.qcow2 \
          -cdrom ~/ubuntu.iso \
            -boot d \
              -vga virtio \
                -device virtio-net,netdev=net0 \
                  -netdev user,id=net0 \
                    -usb \
                      -device usb-tablet \
                        -rtc base=localtime \
                          -display vnc=:1
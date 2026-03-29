# Installation

## Requirements

- Linux (Ubuntu / Debian-based recommended)
- Root / sudo access
- ZRAM (optional but recommended)

---

## Step 1 - Clone Repository

```bash```

```git clone https://github.com/sekarantika95-sys/Linux-Workstation-Tuning.git```

```cd Linux-Workstation-Tuning```

---

## Step 2 - Apply sysctl configuration  

```bash```

```sudo cp sysctl/99-workstation-optimizer.conf /etc/sysctl.d/```

```sudo sysctl --system```

---

## Step 3 - (Optional) Run automation script

Jika menggunakan script :

```bash```

```chmod +x scripts/apply-tuning.sh```

```./scripts/apply-tuning.sh```

---

## Notes

- Pastikan tidak ada konfigurasi lain yang konflik
- Disarankan untuk reboot setelah apply tuning
- Efek bisa berbeda tergantung sistem. 

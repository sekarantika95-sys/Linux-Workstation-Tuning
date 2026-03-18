# Linux Workstation Tuning
Lightweight Linux tuning project focused on improving system responsiveness and stability under multitasking workloads (VM + browser + development tools).

---

## Overview
Project ini merupakan hasil eksperimen dalam mencoba memahami dan mengoptimasi cara kerja sistem Linux, khususnya pada bagian memory management dan system behavior saat digunakan secara intensif.

Kasus awal :
- sering trash setelah beberapa waktu menjalankan Virtual Machine
- terkadang sistem terasa berat walaupun RAM masih tersedia
- multitasking tidak stabil

Dari situ, dilakukan Tuning secara bertahap sambil memahami efek dari tiap parameter.

---

## What this project does?
- Mengoptimasi penggunaan RAM dan swap
- Mengurangi stutter saat multitasking
- Meningkatkan respons sistem saat memory pressure
- Menyediakan konfigurasi yang lebih stabil untuk workload development

---

## Core Tuning

### Memory Management

```bash
vm.swappiness=20
vm.vfs_cache_pressure=50
vm.page-cluster=0```

- Swappiness diturunkan agar sistem tidak terlalu cepet swap
- Cache pressure dikurangi untuk mempertahankan file cache
- Page-cluster di-set 0 untuk meningkatkan respons saat swap

### ZRAM Configuration

- Menggunakan ZRAM sebagai swap utama
- Size kurang lebih 50% dari RAM
- Prioritas lebih tinggi dari disk swap

Tujuannya adalah untyk menjaga performa saat RAM mulai penuh dan menghindari bottleneck dari disk I/O

### Writeback Control

```bash
vm.dirty_ratio=15
vm.dirty_background_ratio=5```

Untuk mengurangi lonjakan penulisan ke disk yang bisa menyebabkan stutter.

### Memory Overcommit

```bash
vm.overcommit_memory=1
vm.overcommit_ratio=80```

Untuk memberikan fleksibilitas lebih dalam alokasi memori, terutama untuk VM.

### Developer Limits

- File descriptor limit dinaikkan
- Process limit dinaikkan
- Inotify watchers dinaikkan

Menyesuaikan dengan kebutuhan tools modern yang membuka banyak file/process.

### Usage

Apply sysctl config:

```bash
sudo cp sysctl/99-workstation-optimizer.conf /etc/sysctl --system```

### Testing Scenario

Digunakan pada :
- Ubuntu
- RAM 16GB
- ZRAM aktif

Workload :
- Virtual Machine aktif
- Browser dengan multiple tabs
- Terminal multitasking

---

## Notes

- Konfigurasi ini bukan "paling optimal", tapi hasi dari eksperimen
- Efek bisa berbeda tergantung sistem
- Beberapa parameter masih dalam tahap eksplorasi

---

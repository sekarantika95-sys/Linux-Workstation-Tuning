# Linux Workstation Tuning
Lightweight Linux tuning project focused on improving system responsiveness and stability under multitasking workloads (VM + browser + development tools).

---

## Overview
Project ini merupakan hasil eksperimen dalam mencoba memahami dan mengoptimasi cara kerja sistem Linux, khususnya pada bagian memory management dan system behavior saat digunakan secara intensif.

Kasus awal :
- sering trash setelah beberapa waktu menjalankan Virtual Machine
- terkadang sistem terasa berat walaupun RAM masih tersedia
- multitasking tidak stabil

Dari situ, dilakukan tuning secara bertahap sambil memahami efek dari tiap parameter.

---

## What this project does?
- Mengoptimasi penggunaan RAM dan swap
- Mengurangi stutter saat multitasking
- Meningkatkan respons sistem saat memory pressure
- Menyediakan konfigurasi yang lebih stabil untuk workload development

---

## Core Tuning

### Memory Management

vm.swappiness=20

vm.vfs_cache_pressure=50

vm.page-cluster=0

Keterangan : 
- Swappiness diturunkan agar sistem tidak terlalu cepet swap
- Cache pressure dikurangi untuk mempertahankan file cache
- Page-cluster di-set 0 untuk meningkatkan respons saat swap

Penjelasan lebih lanjut : 
- Swappines di-set menjadi 20. Default (60) terlalu agresif dalam menggunakan swap. Nilai ini dipilih agar sistem lebih lama bertahan di RAM sebelum swap digunakan.
- Cache pressure dikurangi menjadi 50. Digunakan untuk mempertahankan file cache lebih lama, sehingga akses file terasa lebih cepat.
- Page-cluster di-set 0 untuk mengurangi jumlah page yang dibaca sekaligus dari swap, sehingga respons terasa lebih cepat pada workload kecil.

### ZRAM Configuration

- Menggunakan ZRAM sebagai swap utama
- Size kurang lebih 50% dari RAM
- Prioritas lebih tinggi dari disk swap

Tujuan :
- Mengurangi ketergantungan pada disk I/O
- Menjaga performa saat RAM mulai penuh

Catatan : ZRAM tidak benar-benar menambah kapasitas memori, tetapi mengompresi data di RAM. Efeknya membantu, tetapi tetap ada batasnya saat workload terlalu berat.

### Writeback Control

vm.dirty_ratio=15

vm.dirty_background_ratio=5

Penjelasan : 
Untuk mengurangi lonjakan penulisan ke disk yang bisa menyebabkan stutter, karena :
- Nilai terlalu besar dapat membuat penulisan menumpuk dan bisa menyebabkan lag
- Nilai lebih kecil dapat membuat penulisan lebih sering, namun lebih ringan

### Memory Overcommit

vm.overcommit_memory=1

vm.overcommit_ratio=80

Penjelasan :
Untuk memberikan fleksibilitas lebih dalam alokasi memori, terutama untuk VM (Program berat lainnya). Namun, konfigurasi ini masih dalam tahap eksplorasi karena berpotensi menyebabkan over-allocation jika tidak terkontrol.

### Developer Limits

- File descriptor limit dinaikkan
- Process limit dinaikkan
- Inotify watchers dinaikkan

Alasan :
Tools modern seperti VS Code, Node.js, dan berbagai tools development lainnya sering membuka banyak file dan process secara bersamaan.

---

## Observed Behavior

Before Tuning :
- Setiap kali menggunakan VM + Firefox berjalan bersaman, sistem terasa lag
- Terkadang terjadi freeze ringan

After Tuning :
- Sistem terasa lebih stabil saat multitasking
- Tidak langsung Freeze, lebih jarang terjadi.

Catatan :
- Saat workload terlalu berat, sistem tetap mencapai limit
- ZRAM hanya membantu menunda bottleneck, bukan menghilangkan.

---

## Testing Scenario

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
- Beberapa parameter masih dalam tahap eksplorasi/pemahaman.

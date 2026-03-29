# Architecture

## Core Idea

Project ini tidak dibuat sebagai “sekadar tweak angka”, tapi sebagai usaha memahami bagaimana Linux mengelola resource di kondisi nyata.

Fokus utamanya:
- bagaimana sistem merespon memory pressure
- bagaimana swap digunakan (atau disalahgunakan)
- bagaimana kernel mengambil keputusan saat multitasking

Alih-alih mencari “setting paling optimal”, pendekatan yang dipakai adalah:
observasi → hipotesis → tuning → validasi

---

## System Perspective

Secara sederhana, sistem bisa dilihat sebagai tiga layer utama:

1. Memory Management
2. I/O Behavior
3. User Workload

Ketiganya saling berinteraksi, dan bottleneck di satu bagian bisa mempengaruhi keseluruhan respons sistem.

---

## Tuning Philosophy

Pendekatan tuning dalam project ini didasarkan pada beberapa prinsip:

### 1. Avoid premature swapping
Swapping terlalu cepat sering membuat sistem terasa lambat, walaupun RAM masih tersedia.

→ Solusi:
- vm.swappiness diturunkan

---

### 2. Preserve useful cache
File cache sebenarnya membantu performa, tapi sering dibuang terlalu agresif.

→ Solusi:
- vm.vfs_cache_pressure dikurangi

---

### 3. Reduce swap latency
Default behavior swap bisa terasa lambat karena membaca dalam blok besar.

→ Solusi:
- vm.page-cluster di-set lebih rendah (0)

---

### 4. Control writeback spikes
Penulisan disk yang tiba-tiba dalam jumlah besar bisa menyebabkan stutter.

→ Solusi:
- vm.dirty_ratio dan vm.dirty_background_ratio diatur lebih rendah

---

### 5. Flexible memory allocation
Beberapa workload (seperti Virtual Machine) butuh fleksibilitas alokasi memori.

→ Solusi:
- vm.overcommit_memory diaktifkan
- vm.overcommit_ratio disesuaikan

---

## ZRAM Strategy

Daripada langsung menggunakan disk sebagai swap, project ini memanfaatkan ZRAM.

Alasannya:
- RAM jauh lebih cepat dibanding disk
- kompresi membuat penggunaan memori lebih efisien
- mengurangi bottleneck I/O

ZRAM digunakan sebagai:
- swap utama
- prioritas lebih tinggi dibanding disk swap

---

## System Limits Adjustment

Modern development tools:
- membuka banyak file
- menjalankan banyak process
- menggunakan file watchers

Default limit Linux sering tidak cukup untuk kondisi ini.

→ Dilakukan peningkatan pada:
- file descriptors
- process limits
- inotify watchers

---

## Interaction Flow

Secara umum, alur kerja sistem setelah tuning:

User workload → Memory usage meningkat →  
Kernel menahan swap selama mungkin →  
Cache tetap dipertahankan →  
Jika diperlukan, ZRAM digunakan terlebih dahulu →  
Disk swap menjadi opsi terakhir

Hasilnya:
- sistem lebih responsif
- multitasking lebih stabil
- stutter berkurang

---

## Trade-offs

Tidak ada tuning yang sempurna.

Beberapa konsekuensi dari konfigurasi ini:

- penggunaan RAM bisa terlihat lebih tinggi
- sistem lebih “agresif” dalam mempertahankan cache
- tidak semua workload akan mendapatkan benefit yang sama

---

## Conclusion

Project ini bukan tentang mencari konfigurasi terbaik, tapi tentang memahami perilaku sistem.

Tuning dilakukan bukan untuk “memaksa sistem”, tapi untuk membantu kernel mengambil keputusan yang lebih sesuai dengan kebutuhan workload.

Pendekatan ini masih terbuka untuk eksplorasi lebih lanjut.

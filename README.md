# Linux Workstation Tuning
Lightweight Linux tuning project focused on improving system responsiveness and stability under multitasking workloads (VM + browser + development tools).

---

## Overview
Projek ini merupakan hasil eksperimen dalam mencoba memahami dan mengoptimasi cara kerja sistem Linux, khususnya pada bagian memory management dan system behavior saat digunakan secara intensif.
Projek ini berangkat dari masalah sederhana :

- Sistem terasa berat setelah menjalankan Virtual Machine
- Kadang terjadi stutter walaupun RAM masih tersedia
- Multitasking tidak stabil dalam jangka waktu tertentu

Dari situ, dilakukan eksplorasi terhadap bagaimana Linux mengelola memory, swap, dan I/O, lalu dicoba beberapa penyesuaian untuk melihat dampaknya.
Perlu diketahui bahwa, project ini bukan tentang mencari setting paling optimal. Tapi lebih ke memahami behavior sistem dan mengarahkannya sesuai kebutuhan.

---

## What this project does?
- Mengurangi stutter saat multitasking
- Mengoptimasi penggunaan RAM dan swap
- Meningkatkan respons sistem saat memory pressure
- Menyesuaikan behavior Linux untuk workload development

---

## Core Idea
Tuning difokuskan pada beberapa area utama :

- Memory management (RAM & swap behavior)
- ZRAM sebagai swap utama
- Writeback control untuk mengurangi spike I/O
- Overcommit untuk fleksibilitas alokasi memori
- System limits untuk kebutuhan tools modern

Detail teknis dan alasan di balik setiap keputusan dijelaskan di : ARSITECTURE.md

---

## Project Structure
- README.md : Penjelasan utama project.
- ARCHITECTURE.md : Penjelasan desain sistem, alasan tuning, dan analisis.
- INSTALLATION.md : Panduan instalasi dan cara penggunaan.
- LICENSE : Lisensi penggunaan projek.
- sysctl/99-workstation-optimizer.conf : Berisi parameter tuning kernel.
- script/apply-tuning.sh : Script untuk menerapkan konfigurasi secara otomatis.

---

## Testing Scenario
Testing dilakukan dalam konteks penggunaan real, bukan synthetic benchmark.

Sistem yang digunakan :
- Ubuntu
- RAM 16GB
- ZRAM aktif

Workload :
- Virtual Machine aktif
- Browser dengan multiple tabs
- Terminal multitasking

---

## Skenario Penggunaan
Simulasi workload yang mendekati kondisi sehari-hari :

- Menjalankan Virtual Machine dalam waktu lama
- Membuka browser dengan multiple tabs (10+)
- Aktivitas development di terminal (editing, running, process, dll)

Semua berjalan secara bersamaan untuk menciptakan kondisi memory pressure.

---

## Fokus Pengujian
Pengamatan difokuskan pada beberapa hal :

- Respons sistem saat RAM mulai penuh
- Perilaku swap (apakah terlalu cepat / terlalu lambat)
- Stabilitas multitasking dalam durasi panjang
- Adanya stutter atau tidak saat switching workload

---

## Observasi Umum
Setelah tuning diterapkan :

- Sistem terasa lebih responsif saat multitasking
- Penggunaan swap menjadi lebih terkontrol
- Stutter berkurang dibanding sebelum tuning
- Sistem lebih stabil dalam penggunaan jangka waktu lama

---

## Notes
- Konfigurasi ini bukan universal best config
- Efek bisa berbeda tergantung hardware dan workload
- Beberapa parameter masih dalam tahap eksplorasi

---

## Final Thoughts
Projek ini lebih ke arah eksplorasi dan pemahaman sistem, bukan apply-tweak saja. Karena pada akhirnya, tuning bukan soal angka saja, tapi juga soal mengerti bagaimana sistem bereaksi terhadap perubahan.



-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 14, 2025 at 12:51 PM
-- Server version: 10.11.13-MariaDB-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_izin`
--
CREATE DATABASE IF NOT EXISTS `db_izin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_izin`;

-- --------------------------------------------------------

--
-- Table structure for table `izin_siswa`
--

DROP TABLE IF EXISTS `izin_siswa`;
CREATE TABLE `izin_siswa` (
  `id_izin` int(11) NOT NULL,
  `id_siswa` int(11) NOT NULL,
  `jenis_izin` varchar(50) DEFAULT NULL,
  `alasan` text DEFAULT NULL,
  `tgl_mulai` datetime DEFAULT NULL,
  `tgl_kembali` datetime DEFAULT NULL,
  `status` enum('pending','disetujui','ditolak') DEFAULT 'pending',
  `waktu_pengajuan` datetime DEFAULT current_timestamp(),
  `waktu_persetujuan` datetime DEFAULT NULL,
  `bukti` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `izin_siswa`
--

INSERT INTO `izin_siswa` (`id_izin`, `id_siswa`, `jenis_izin`, `alasan`, `tgl_mulai`, `tgl_kembali`, `status`, `waktu_pengajuan`, `waktu_persetujuan`, `bukti`) VALUES
(18, 8, 'Sakit', 'mencret', '2025-12-14 00:00:00', '2025-12-15 00:00:00', 'disetujui', '2025-12-14 15:26:15', '2025-12-14 15:26:59', '1765700775474_golang.pdf'),
(19, 8, 'Pulang', 'cepirit', '2025-12-15 00:00:00', '2025-12-16 00:00:00', 'disetujui', '2025-12-14 16:11:20', '2025-12-14 16:11:41', '1765703480762_Kisi - kisi UTS_Algoritma Struktur Data.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

DROP TABLE IF EXISTS `siswa`;
CREATE TABLE `siswa` (
  `id_siswa` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `nama` varchar(100) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nis` varchar(20) DEFAULT NULL,
  `kelas` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`id_siswa`, `id_user`, `nama`, `password`, `nis`, `kelas`) VALUES
(8, NULL, 'amril', '123', '123', '10-A'),
(9, NULL, 'ajib munawar', '1212', '1212', '8-C');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_guru`
--

DROP TABLE IF EXISTS `tbl_guru`;
CREATE TABLE `tbl_guru` (
  `id_guru` int(11) NOT NULL,
  `nama_guru` varchar(100) NOT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `mapel` varchar(50) DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `alamat` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_guru`
--

INSERT INTO `tbl_guru` (`id_guru`, `nama_guru`, `nip`, `mapel`, `jenis_kelamin`, `no_hp`, `alamat`) VALUES
(9, 'Imam', '1283291', 'matematika', 'Laki-laki', '0828123', 'walantaka'),
(10, 'siska', '2101912812', 'basis data', 'Laki-laki', '0986762122', 'serang'),
(11, 'ali', '123388', 'PJOK', 'Laki-laki', '086845640', 'sindang sari'),
(13, 'robi', '23422', 'fisika', 'Laki-laki', '094828347', 'cikeusal');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','guru','siswa') NOT NULL DEFAULT 'siswa',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `nama`, `username`, `password`, `role`, `created_at`) VALUES
(5, 'Administrator', 'admin', '123', 'admin', '2025-12-14 07:47:31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `izin_siswa`
--
ALTER TABLE `izin_siswa`
  ADD PRIMARY KEY (`id_izin`),
  ADD KEY `id_siswa` (`id_siswa`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`id_siswa`),
  ADD UNIQUE KEY `nis` (`nis`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `tbl_guru`
--
ALTER TABLE `tbl_guru`
  ADD PRIMARY KEY (`id_guru`),
  ADD UNIQUE KEY `nip` (`nip`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `izin_siswa`
--
ALTER TABLE `izin_siswa`
  MODIFY `id_izin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `siswa`
--
ALTER TABLE `siswa`
  MODIFY `id_siswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_guru`
--
ALTER TABLE `tbl_guru`
  MODIFY `id_guru` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `izin_siswa`
--
ALTER TABLE `izin_siswa`
  ADD CONSTRAINT `izin_siswa_ibfk_1` FOREIGN KEY (`id_siswa`) REFERENCES `siswa` (`id_siswa`) ON DELETE CASCADE;

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

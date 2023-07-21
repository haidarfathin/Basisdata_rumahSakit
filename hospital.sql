-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Jul 2023 pada 10.08
-- Versi server: 10.4.27-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `checkup`
--

CREATE TABLE `checkup` (
  `id` bigint(20) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `checkup_date` date NOT NULL,
  `diagnose` varchar(500) NOT NULL,
  `treatment` varchar(500) NOT NULL,
  `cost` int(11) DEFAULT NULL,
  `total_cost` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `checkup`
--

INSERT INTO `checkup` (`id`, `doctor_id`, `patient_id`, `checkup_date`, `diagnose`, `treatment`, `cost`, `total_cost`) VALUES
(1, 1, 1, '2023-04-03', 'batuk pilek', '', 100000, 205000.00),
(2, 2, 3, '2023-04-05', 'patah tulang', 'operasi', 25000000, 300000.00),
(3, 1, 7, '2023-04-02', 'demam', '-', 100000, 35000.00),
(4, 2, 2, '2023-04-11', 'keseleo', 'fisioterapi', 100000, 165000.00),
(5, 4, 5, '2023-04-10', 'baik-baik saja', '-', 200000, 235000.00),
(6, 3, 1, '2023-03-30', 'baik-baik saja', '-', 500000, NULL),
(7, 5, 9, '2023-05-04', 'diare', '', 100000, 130000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `checkup_medicine`
--

CREATE TABLE `checkup_medicine` (
  `checkup_id` bigint(20) NOT NULL,
  `drug_id` int(11) NOT NULL,
  `daily_intake` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `quantity` tinyint(4) DEFAULT NULL,
  `price` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `checkup_medicine`
--

INSERT INTO `checkup_medicine` (`checkup_id`, `drug_id`, `daily_intake`, `description`, `quantity`, `price`) VALUES
(1, 7, 3, 'after meals', 1, 55000.00),
(1, 13, 3, 'after meals', 1, 30000.00),
(1, 17, 3, 'after meal', 2, 30000.00),
(1, 21, 3, 'after meal', 2, 30000.00),
(2, 1, 3, 'after meal', 10, 30000.00),
(3, 20, 1, 'if needed', 1, 35000.00),
(4, 17, 1, 'if needed', 1, 47500.00),
(4, 18, 1, 'morning & night', 1, 17500.00),
(5, 20, 1, 'if needed', 1, 35000.00),
(7, 15, 3, 'after meals, 2 tablet at once', 2, 15000.00);

--
-- Trigger `checkup_medicine`
--
DELIMITER $$
CREATE TRIGGER `tambah_drugs_quantity` AFTER DELETE ON `checkup_medicine` FOR EACH ROW BEGIN
    UPDATE drugs
    SET quantity = quantity + OLD.quantity
    WHERE id = OLD.drug_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_drugs_quantity` AFTER INSERT ON `checkup_medicine` FOR EACH ROW BEGIN
    UPDATE drugs
    SET quantity = quantity - NEW.quantity
    WHERE id = NEW.drug_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_cost` AFTER INSERT ON `checkup_medicine` FOR EACH ROW BEGIN
UPDATE checkup c
SET total_cost = (SELECT SUM(quantity * price) FROM checkup_medicine WHERE checkup_id = NEW.checkup_id)
WHERE c.id = NEW.checkup_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_total_cost_on_delete` AFTER DELETE ON `checkup_medicine` FOR EACH ROW BEGIN 
UPDATE checkup c
SET total_cost = (SELECT SUM(quantity * price)
FROM checkup_medicine
WHERE checkup_id = OLD.checkup_id)
WHERE c.id = OLD.checkup_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `daftar_checkup`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `daftar_checkup` (
`ID` bigint(20)
,`Nama Dokter` varchar(200)
,`Nama Pasien` varchar(100)
,`Tanggal CheckUp` date
,`diagnosa` varchar(500)
,`penanganan` varchar(500)
,`biaya` int(11)
,`Total Biaya` decimal(12,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `daftar_dokter`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `daftar_dokter` (
`ID` int(11)
,`Nama Lengkap` varchar(200)
,`NIK` varchar(16)
,`Tanggal Lahir` date
,`Tempat Lahir` varchar(50)
,`Jenis Kelamin` enum('M','F')
,`Spesialisasi` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `daftar_obat`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `daftar_obat` (
`ID` int(11)
,`Nama Obat` varchar(200)
,`Indikasi` varchar(50)
,`Kuantitas` int(11)
,`Harga` decimal(15,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `daftar_pasien`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `daftar_pasien` (
`ID` int(11)
,`Nama Lengkap` varchar(100)
,`NIk` varchar(16)
,`Tanggal Lahir` date
,`Tempat Lahir` varchar(50)
,`Jenis Kelamin` enum('M','F')
,`Pekerjaan` varchar(100)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `birth_date` date NOT NULL,
  `birth_place` varchar(50) NOT NULL,
  `sex` enum('M','F') NOT NULL,
  `type_id` smallint(5) UNSIGNED DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `alumni` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `doctors`
--

INSERT INTO `doctors` (`id`, `fullname`, `nik`, `birth_date`, `birth_place`, `sex`, `type_id`, `email`, `alumni`) VALUES
(1, 'dr. Lola Gardner', '', '1993-06-15', 'Boston', 'F', 1, NULL, ''),
(2, 'dr. Billy Wheeler, Sp.OT', '', '1988-05-11', '', 'M', 2, NULL, ''),
(3, 'dr. Joel Brady, Sp.KJ', '', '1990-01-09', '', 'M', 9, NULL, ''),
(4, 'dr. Sean Stewart, Sp.JP', '', '1991-09-23', '', 'M', 4, NULL, ''),
(5, 'dr. Bartholomew Fenton', '', '1995-08-17', '', 'M', 1, NULL, '');

-- --------------------------------------------------------

--
-- Struktur dari tabel `doctor_type`
--

CREATE TABLE `doctor_type` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `type` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `doctor_type`
--

INSERT INTO `doctor_type` (`id`, `type`) VALUES
(1, 'General Practitioner'),
(2, 'Orthopedics'),
(3, 'Obgyn'),
(4, 'Neurology'),
(5, 'Cardiology and Vascular Medicine'),
(6, 'Pediatric'),
(7, 'Anestesiology'),
(8, 'Pulmonology and Respiratory Medicine'),
(9, 'Psychiatry');

-- --------------------------------------------------------

--
-- Struktur dari tabel `drugs`
--

CREATE TABLE `drugs` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `diagnose` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(15,2) NOT NULL
) ;

--
-- Dumping data untuk tabel `drugs`
--

INSERT INTO `drugs` (`id`, `name`, `diagnose`, `quantity`, `price`) VALUES
(1, 'Rhinos Junior Sirup 60 ml', 'pilek anak', 900, 50000.00),
(2, 'Paratusin 10 Tablet', 'demam', 75, 15000.00),
(3, 'Tremenza Sirup 60 ml', 'pilek', 100, 25000.00),
(4, 'Demacolin 10 Tablet', 'flu', 50, 7500.00),
(5, 'Actifed Plus Cough Supressant Sirup 60 ml (Merah)', 'batuk kering', 50, 60000.00),
(6, 'Rhinofed Sirup 60 ml', 'pilek', 50, 37500.00),
(7, 'Actifed Plus Expectorant Sirup 60 ml (Hijau)', 'batuk berdahak', 50, 55000.00),
(8, 'Sterimar Nose Hygiene Baby 50 ml', 'tht bayi', 10, 175000.00),
(9, 'Degirol Hisap 0.25 mg 10 Tablet', 'radang', 100, 10000.00),
(10, 'Promag Suspensi 60 ml', 'maag', 100, 12500.00),
(11, 'New Diatabs 4 Tablet', 'diare', 200, 2700.00),
(12, 'Ketoconazole 200 mg 10 Tablet', 'anti jamur', 50, 8000.00),
(13, 'Amoxsan Dry Sirup 60 ml', 'antibiotik', 100, 30000.00),
(14, 'Promag 10 Tablet', 'maag', 100, 8000.00),
(15, 'Entrostop 20 Tablet', 'diare', 100, 15000.00),
(16, 'Zyloric 100 mg 10 Tablet', 'asam urat', 100, 27500.00),
(17, 'Counterpain Cool Gel 30 g', 'nyeri otot', 100, 47500.00),
(18, 'Estalex 50 mg 10 Tablet', 'pelemas otot', 100, 17500.00),
(19, 'Ossoral 800 mg 10 Kaplet', 'osteoporosis', 100, 50000.00),
(20, 'Prove D3-1000 IU 10 Tablet', 'vitamin', 100, 35000.00),
(21, 'Cindala 10 mg/g Gel 10 g', 'jerawat', 100, 28000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `employees`
--

CREATE TABLE `employees` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `honor_tambahan_dokter`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `honor_tambahan_dokter` (
`id` int(11)
,`fullname` varchar(200)
,`honor_tambahan` decimal(34,1)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `invoice_pasien`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `invoice_pasien` (
`id` int(11)
,`fullname` varchar(100)
,`total_biaya` decimal(19,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `invoice_pasien_1`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `invoice_pasien_1` (
`id` bigint(20)
,`patient_id` int(11)
,`total_biaya` decimal(41,2)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `obat_diresepkan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `obat_diresepkan` (
`id` int(11)
,`nama_obat` varchar(200)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `obat_tidak_diresepkan`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `obat_tidak_diresepkan` (
`id` int(11)
,`nama_obat` varchar(200)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `pasien_periksa`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `pasien_periksa` (
`id_periksa` bigint(20)
,`nama_pasien` varchar(100)
,`nama_dokter` varchar(200)
,`tanggal_periksa` date
,`diagnosa_dokter` varchar(500)
,`tindakan_dokter` varchar(500)
,`biaya_berobat` int(11)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) DEFAULT NULL,
  `nik` varchar(16) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(50) DEFAULT NULL,
  `sex` enum('M','F') DEFAULT NULL,
  `occupation` varchar(100) DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `patients`
--

INSERT INTO `patients` (`id`, `fullname`, `nik`, `birth_date`, `birth_place`, `sex`, `occupation`, `entry_date`) VALUES
(1, 'Reza Rahadian', '', '1987-03-05', 'Bogor', 'F', 'Actor', '2023-03-02 00:00:00'),
(2, 'Fedi Nuril', '', '1982-07-01', 'Jakarta', 'M', 'Actor', NULL),
(3, 'Nicholas Saputra Schubring', '', '1984-02-24', 'Jakarta', 'M', 'Actor', '2023-03-02 00:00:00'),
(4, 'Diandra Paramitha Sastrowardoyo', '', '1982-03-16', 'Jakarta', 'F', 'Actress', '2023-03-02 00:00:00'),
(5, 'Isyana Sarasvati', '', '1993-05-02', 'Bandung', 'F', 'Singer', '2023-03-02 13:53:40'),
(6, 'Yoshua Sudarso', '', '1989-04-12', 'Jakarta', 'M', 'Actor', '2023-03-02 13:53:40'),
(7, 'Arafah Rianti', '', '1997-09-02', 'Depok', 'F', 'Comedian', '2023-03-02 13:53:40'),
(8, 'G.M.A. Bintang Mahaputra', '', '1996-05-05', 'Jakarta', 'M', 'Comedian', '2023-03-02 13:53:40'),
(9, 'Aci Resti', '', '1997-08-12', 'Tangerang', 'F', 'Comedian', '2023-03-02 13:53:40'),
(10, 'Sissy Priscillia', '', '1985-04-05', 'Jakarta', 'F', 'Actress', '2023-03-02 13:53:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `patients_bpjs`
--

CREATE TABLE `patients_bpjs` (
  `patient_id` int(11) NOT NULL,
  `bpjs_no` varchar(64) NOT NULL,
  `registered_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `patients_bpjs`
--

INSERT INTO `patients_bpjs` (`patient_id`, `bpjs_no`, `registered_date`) VALUES
(5, '123123123213', '2023-04-10'),
(9, '123123123', '2023-04-03');

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sku` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL
) ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur untuk view `daftar_checkup`
--
DROP TABLE IF EXISTS `daftar_checkup`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_checkup`  AS SELECT `a`.`id` AS `ID`, `b`.`fullname` AS `Nama Dokter`, `c`.`fullname` AS `Nama Pasien`, `a`.`checkup_date` AS `Tanggal CheckUp`, `a`.`diagnose` AS `diagnosa`, `a`.`treatment` AS `penanganan`, `a`.`cost` AS `biaya`, `a`.`total_cost` AS `Total Biaya` FROM ((`checkup` `a` join `doctors` `b` on(`a`.`doctor_id` = `b`.`id`)) join `patients` `c` on(`a`.`patient_id` = `c`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `daftar_dokter`
--
DROP TABLE IF EXISTS `daftar_dokter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_dokter`  AS SELECT `a`.`id` AS `ID`, `a`.`fullname` AS `Nama Lengkap`, `a`.`nik` AS `NIK`, `a`.`birth_date` AS `Tanggal Lahir`, `a`.`birth_place` AS `Tempat Lahir`, `a`.`sex` AS `Jenis Kelamin`, `b`.`type` AS `Spesialisasi` FROM (`doctors` `a` join `doctor_type` `b` on(`a`.`type_id` = `b`.`id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `daftar_obat`
--
DROP TABLE IF EXISTS `daftar_obat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_obat`  AS SELECT `a`.`id` AS `ID`, `a`.`name` AS `Nama Obat`, `a`.`diagnose` AS `Indikasi`, `a`.`quantity` AS `Kuantitas`, `a`.`price` AS `Harga` FROM `drugs` AS `a` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `daftar_pasien`
--
DROP TABLE IF EXISTS `daftar_pasien`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftar_pasien`  AS SELECT `a`.`id` AS `ID`, `a`.`fullname` AS `Nama Lengkap`, `a`.`nik` AS `NIk`, `a`.`birth_date` AS `Tanggal Lahir`, `a`.`birth_place` AS `Tempat Lahir`, `a`.`sex` AS `Jenis Kelamin`, `a`.`occupation` AS `Pekerjaan` FROM `patients` AS `a` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `honor_tambahan_dokter`
--
DROP TABLE IF EXISTS `honor_tambahan_dokter`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `honor_tambahan_dokter`  AS SELECT `a`.`id` AS `id`, `a`.`fullname` AS `fullname`, sum(`b`.`cost` * 0.6) AS `honor_tambahan` FROM (`doctors` `a` join `checkup` `b` on(`a`.`id` = `b`.`doctor_id`)) GROUP BY `a`.`id`, `a`.`fullname` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `invoice_pasien`
--
DROP TABLE IF EXISTS `invoice_pasien`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `invoice_pasien`  AS SELECT `a`.`id` AS `id`, `a`.`fullname` AS `fullname`, `b`.`cost`+ `c`.`quantity` * `d`.`price` AS `total_biaya` FROM (((`patients` `a` join `checkup` `b` on(`a`.`id` = `b`.`patient_id`)) join `checkup_medicine` `c` on(`b`.`id` = `c`.`checkup_id`)) join `drugs` `d` on(`c`.`drug_id` = `d`.`id`)) GROUP BY `a`.`id`, `a`.`fullname` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `invoice_pasien_1`
--
DROP TABLE IF EXISTS `invoice_pasien_1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `invoice_pasien_1`  AS SELECT `a`.`id` AS `id`, `a`.`patient_id` AS `patient_id`, `a`.`cost`+ sum(`b`.`quantity` * `c`.`price`) AS `total_biaya` FROM ((`checkup` `a` join `checkup_medicine` `b` on(`a`.`id` = `b`.`checkup_id`)) join `drugs` `c` on(`b`.`drug_id` = `c`.`id`)) GROUP BY `a`.`id`, `a`.`patient_id`, `a`.`cost` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `obat_diresepkan`
--
DROP TABLE IF EXISTS `obat_diresepkan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `obat_diresepkan`  AS SELECT DISTINCT `a`.`id` AS `id`, `a`.`name` AS `nama_obat` FROM (`drugs` `a` join `checkup_medicine` `b` on(`a`.`id` = `b`.`drug_id`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `obat_tidak_diresepkan`
--
DROP TABLE IF EXISTS `obat_tidak_diresepkan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `obat_tidak_diresepkan`  AS SELECT DISTINCT `a`.`id` AS `id`, `a`.`name` AS `nama_obat` FROM (`drugs` `a` left join `obat_diresepkan` `b` on(`a`.`id` = `b`.`id`)) WHERE `b`.`id` is null ;

-- --------------------------------------------------------

--
-- Struktur untuk view `pasien_periksa`
--
DROP TABLE IF EXISTS `pasien_periksa`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pasien_periksa`  AS SELECT `a`.`id` AS `id_periksa`, `b`.`fullname` AS `nama_pasien`, `c`.`fullname` AS `nama_dokter`, `a`.`checkup_date` AS `tanggal_periksa`, `a`.`diagnose` AS `diagnosa_dokter`, `a`.`treatment` AS `tindakan_dokter`, `a`.`cost` AS `biaya_berobat` FROM ((`checkup` `a` join `patients` `b` on(`a`.`patient_id` = `b`.`id`)) join `doctors` `c` on(`a`.`doctor_id` = `c`.`id`)) ORDER BY `b`.`fullname` ASC ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `checkup`
--
ALTER TABLE `checkup`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indeks untuk tabel `checkup_medicine`
--
ALTER TABLE `checkup_medicine`
  ADD PRIMARY KEY (`checkup_id`,`drug_id`),
  ADD KEY `drug_id` (`drug_id`);

--
-- Indeks untuk tabel `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `type_id` (`type_id`);

--
-- Indeks untuk tabel `doctor_type`
--
ALTER TABLE `doctor_type`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `drugs`
--
ALTER TABLE `drugs`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indeks untuk tabel `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `patients_bpjs`
--
ALTER TABLE `patients_bpjs`
  ADD UNIQUE KEY `patient_id` (`patient_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `checkup`
--
ALTER TABLE `checkup`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `doctor_type`
--
ALTER TABLE `doctor_type`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT untuk tabel `drugs`
--
ALTER TABLE `drugs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `checkup`
--
ALTER TABLE `checkup`
  ADD CONSTRAINT `checkup_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  ADD CONSTRAINT `checkup_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);

--
-- Ketidakleluasaan untuk tabel `checkup_medicine`
--
ALTER TABLE `checkup_medicine`
  ADD CONSTRAINT `checkup_medicine_ibfk_1` FOREIGN KEY (`checkup_id`) REFERENCES `checkup` (`id`),
  ADD CONSTRAINT `checkup_medicine_ibfk_2` FOREIGN KEY (`drug_id`) REFERENCES `drugs` (`id`);

--
-- Ketidakleluasaan untuk tabel `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `doctor_type` (`id`);

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `patients_bpjs`
--
ALTER TABLE `patients_bpjs`
  ADD CONSTRAINT `patients_bpjs_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

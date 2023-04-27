-- -------------------------------------------------------------
-- TablePlus 5.1.2(472)
--
-- https://tableplus.com/
--
-- Database: secbullion_v1
-- Generation Time: 2023-03-15 11:50:02.2600
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `tbl_app_metadata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `meta_key` varchar(50) NOT NULL,
  `meta_values` text NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_bank_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `bank_detail_id` int NOT NULL,
  `amount` int NOT NULL,
  `currency` varchar(50) NOT NULL DEFAULT 'AED',
  `reference_number` varchar(200) NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `coupon_code` varchar(50) NOT NULL,
  `discount_price` float(7,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_product_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `file` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_product_order_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit` varchar(50) NOT NULL,
  `price` float(7,2) NOT NULL,
  `currency` varchar(50) NOT NULL,
  `duration` int NOT NULL,
  `duration_type` varchar(50) DEFAULT NULL,
  `delivery_id` varchar(200) NOT NULL,
  `status` enum('store','stake','collect','deliver','delivered') NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_product_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `subtotal` float(7,2) NOT NULL,
  `total` float(8,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(50) DEFAULT NULL,
  `txn_token` text,
  `coupon_code` varchar(50) DEFAULT NULL,
  `discount_price` float(7,2) NOT NULL DEFAULT '0.00',
  `status` enum('pending','accepted') NOT NULL DEFAULT 'pending',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `about` text NOT NULL,
  `specification` text,
  `symbol` varchar(50) DEFAULT NULL,
  `price` float(7,1) DEFAULT NULL,
  `last_price` float(7,2) NOT NULL DEFAULT '0.00',
  `quantity` float(3,1) NOT NULL,
  `unit` enum('gr','kl','oz','tolas','swiss francs') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'gr',
  `status` int NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_bank_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `account_holder_name` varchar(200) NOT NULL,
  `iban` varchar(200) NOT NULL,
  `bank_name` varchar(100) NOT NULL,
  `branch` varchar(100) NOT NULL,
  `swift_code` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_carts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `type` enum('store','stake','collect','deliver') NOT NULL DEFAULT 'store',
  `quantity` int NOT NULL,
  `unit` varchar(50) NOT NULL,
  `duration` int NOT NULL DEFAULT '0',
  `duration_type` varchar(50) DEFAULT NULL,
  `symbol` varchar(50) DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `history_key` varchar(255) NOT NULL,
  `history_message` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_metadata` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `meta_key` varchar(200) NOT NULL,
  `meta_values` text,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_wallet_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `transaction_type` enum('deposit','purchase') NOT NULL,
  `type` enum('balance','commodities','staking') NOT NULL,
  `amount` float(8,2) NOT NULL,
  `reference_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_user_wallets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `cash_balance` float(10,2) NOT NULL DEFAULT '0.00',
  `commodities` float(10,2) NOT NULL DEFAULT '0.00',
  `staking` float(10,2) NOT NULL DEFAULT '0.00',
  `currency` enum('AED','USD') NOT NULL DEFAULT 'AED',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tbl_users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_type` enum('user','admin','reseller','test','sponsor') NOT NULL DEFAULT 'user',
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `status` int NOT NULL DEFAULT '0' COMMENT '0="not verified",1="active",2=blocked,4=deleted',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

INSERT INTO `tbl_app_metadata` (`id`, `meta_key`, `meta_values`, `status`, `created_at`) VALUES
(1, 'privacy-and-policy', '\"<p>SEC Bullion does not distribute, sell, rent, or loan any Customer information to any third party. Your information is only used for your SEC Bullion account. SEC Bullion only collects personal information when necessary either for the completion of a Transaction or as required by law.</p>\\r\\n<p>If you have voluntarily provided personally identifiable information, including but not limited to, your name, organization, phone number, or email address (business or personal), you have provided an expressed consent to SEC Bullion and therefore agreed to the collection and use of your personally identifiable information as described in this privacy policy.</p>\\r\\n<p>SEC Bullion will not use personally identifiable information for any purpose outside of the implied business relationship. In order to achieve the goals of the anti-spam legislation, SEC Bullion will ensure to act in compliance with Anti-Spam Legislation. To enable compliance, commercial electronic messages (including email marketing messages) will be actively distributed only to the individuals that have provided their expressed consent by submitting their personal information via a web form. SEC Bullion preserves its rights to send commercial electronic messages to the groups of individuals that have not provided their expressed consent in the case when we have a pre-existing business relationship with the individual as in these particular cases consent is considered to be implied.</p>\\r\\n<p>Individuals that “Unsubscribe” from receiving emails from our company, and/or Partners and Associates will be automatically removed from any further communications and their expressed consent will be considered revoked as of that date.</p>\"', 1, '2023-01-13 08:05:42'),
(2, 'terms-of-use', '\"<h3>1. ADVICE</h3>\\r\\n<p>The Customer warrants that SEC Bullion has not offered or provided any investment advice and/or any opinion to the Customer in regards to the suitability of any of its products or services.</p>\\r\\n<h3>2. POSSIBLE SYSTEM FAILURE</h3>\\r\\n<p>Online order entry systems are designed to provide efficient and reliable methods for placing orders. However, internet service providers are not 100% reliable. The Customer acknowledges that SEC Bullion is not responsible for the failure of any of these systems.</p>\\r\\n<h3>3. INTERNET SECURITY</h3>\\r\\n<p>We are committed to maintaining the highest security measures to protect Customer information against theft, loss, corruption and to protect against the misuse of this information. We use only the highest industry standard secure server (SSL) for transferring client and credit card information across the internet. All of the customer data we collect is protected against unauthorized access.</p>\\r\\n<h3>4. INTELLECTUAL PROPERTY, BRANDING, AND TRADEMARKS</h3>\\r\\n<p>All of the intellectual property including trademarks, trade names, copyrights and other rights on this website are and will remain the sole property of SEC Bullion. All information and material supplied by SEC Bullion is part of confidential information. No Customer may reproduce, copy, or disclose said information without prior written consent from SEC Bullion.</p>\\r\\n<h3>5. COMPLIANCE AND DUE DILIGENCE</h3>\\r\\n<p>The Customer is solely responsible for conforming to all laws in the jurisdiction from which the Customer accesses the SEC Bullion website. The Customer ensures that the purchase or the sale of Precious Metals is in compliance with all laws of the Customer’s jurisdiction and the acceptance of the Order and Cancellation Policy by the Customer and the entrance into a Customer Purchase Transaction, or a Customer Sale Transaction, is in compliance with all federal, provincial, state or applicable regulations to the Customer.</p>\\r\\n<h3>6. RESERVATIONS OF RIGHT</h3>\\r\\n<p>SEC Bullion reserves the following rights unto its self:</p>\\r\\n<h3>7. RIGHT TO REFUSE SERVICE TO ANYONE</h3>\\r\\n<p>SEC Bullion reserves the right to refuse service to anyone.</p>\\r\\n<h3>8. RIGHT TO CORRECT ERRONEOUS ORDERS</h3>\\r\\n<p>SEC Bullion reserves the right to correct any order for errors or computer-related problems. We will make a good faith effort to notify you of any correction of your order.</p>\\r\\n<h3>9. RIGHT TO CANCEL ANY PENDING SALES</h3>\\r\\n<p>SEC Bullion reserves the right to cancel any pending sale at any time for any reason. If we exercise this right, we shall cancel your order, including delivery of your bullion, and we shall notify you and refund you all monies you may have paid to us on your order, less any costs and fees associated with cancelling your order.</p>\\r\\n<h3>10. RIGHT TO ACCEPT OR REJECT ANY LATE OR DEFECTIVE PAYMENT AFTER MARKET COMPARISON</h3>\\r\\n<p>SEC Bullion reserves the right to either, (1) accept any late or defective payment, including liquidation payments, after a market comparison to determine what is most advantageous for us, or (2) reject any such late or other defective payment, including liquidation payments, that don’t comply with the terms of this Agreement.</p>\\r\\n<h3>11. RIGHT TO WITHHOLD SHIPMENT FOR UNPAID MULTIPLE ORDERS RIGHT OF OFFSET</h3>\\r\\n<p>In the event you place multiple orders with us and pay for one or more orders, but fail to properly pay for other orders, we reserve the right to withhold shipment on any paid orders, until the unpaid orders have been resolved to our satisfaction, including the Right of Offset.</p>\\r\\n<p>The “Right of Offset”, shall mean our right to apply any customer’s paid order’s proceeds and product against any of that customer’s other unpaid order’s proceeds and product. If the customer shall thereafter have a net balance owed to us, we may thereafter involuntarily liquidate the remaining net balance owed as provided herein. If the customer shall have a net balance remaining for shipment, then we shall ship the remaining portion of the order as provided herein.</p>\\r\\n<h3>12. RIGHT TO CHARGE CREDIT CARD</h3>\\r\\n<p>SEC Bullion reserves the right to charge the credit card you have provided for any market losses incurred by SEC Bullion as a result of your failure to fulfill any obligation.</p>\\r\\n<h3>13. RIGHT TO CHANGE BULLION TERMS OF SALE</h3>\\r\\n<p>SEC Bullion reserves the right to change the Bullion Terms and Conditions at any time without notice.</p>\"', 1, '2023-01-13 08:04:48');

INSERT INTO `tbl_bank_transaction` (`id`, `user_id`, `bank_detail_id`, `amount`, `currency`, `reference_number`, `status`, `created_at`) VALUES
(1, 3, 1, 50000, 'USD', '11727', 1, '2023-01-27 12:12:49'),
(2, 3, 2, 200000, 'USD', '37384949', 1, '2023-01-27 12:19:09'),
(3, 9, 3, 500000, 'USD', '22838839', 1, '2023-01-27 13:25:36'),
(4, 11, 5, 100000, 'USD', '3333', 1, '2023-01-31 07:01:55'),
(5, 2, 4, 5000, 'USD', 'werwrweretr', 1, '2023-01-31 07:04:31'),
(6, 1, 6, 10000, 'USD', 'test ', 1, '2023-01-31 07:07:49'),
(7, 2, 4, 100000, 'USD', 'qwdqwdqwdwdwe', 1, '2023-02-02 07:53:33'),
(8, 1, 2, 1000, 'USD', 'asasasasasasasasf', 1, '2023-03-10 10:32:13'),
(9, 1, 2, 1000, 'USD', 'asasasasasasasasfiii', 1, '2023-03-10 11:02:53'),
(10, 1, 2, 1000, 'USD', 'iiasasasasasasasasfiii', 1, '2023-03-10 11:06:23');

INSERT INTO `tbl_coupons` (`id`, `coupon_code`, `discount_price`, `created_at`) VALUES
(1, 'SEC50', 50.00, '2023-01-18 16:25:01');

INSERT INTO `tbl_product_categories` (`id`, `title`, `status`, `created_at`) VALUES
(3, 'Others', 1, '2023-03-02 12:49:01'),
(4, 'Gold', 1, '2023-03-07 06:56:28'),
(5, 'Silver', 1, '2023-03-07 06:57:54');

INSERT INTO `tbl_product_files` (`id`, `product_id`, `file`, `created_at`) VALUES
(1, 1, 'https://storage.googleapis.com/inceptivestudio/1673433628032.png', '2022-12-30 17:26:53'),
(2, 1, 'https://storage.googleapis.com/inceptivestudio/1673433628032.png', '2022-12-30 17:26:53'),
(3, 1, 'https://storage.googleapis.com/inceptivestudio/1673433628032.png', '2022-12-30 17:26:53'),
(4, 2, 'https://storage.googleapis.com/inceptivestudio/1673433775662.png', '2022-12-30 17:28:21'),
(5, 2, 'https://storage.googleapis.com/inceptivestudio/1673433775662.png', '2022-12-30 17:28:21'),
(6, 2, 'https://storage.googleapis.com/inceptivestudio/1673433775662.png', '2022-12-30 17:28:21'),
(7, 3, 'https://storage.googleapis.com/inceptivestudio/1673433870995.png', '2023-01-05 12:25:18'),
(8, 3, 'https://storage.googleapis.com/inceptivestudio/1673433870995.png', '2023-01-05 12:25:18'),
(9, 3, 'https://storage.googleapis.com/inceptivestudio/1673433870995.png', '2023-01-05 12:25:18'),
(10, 4, 'https://storage.googleapis.com/inceptivestudio/1673434911572.png', '2023-01-10 09:44:42'),
(11, 4, 'https://storage.googleapis.com/inceptivestudio/1673434911572.png', '2023-01-10 09:44:42'),
(12, 4, 'https://storage.googleapis.com/inceptivestudio/1673434911572.png', '2023-01-10 09:44:42'),
(13, 5, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:45:04'),
(14, 5, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:45:05'),
(15, 5, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:45:05'),
(16, 6, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:06'),
(17, 6, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:06'),
(18, 6, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:07'),
(19, 7, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:17'),
(20, 7, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:18'),
(21, 7, 'https://storage.googleapis.com/inceptivestudio/1673436285208.png', '2023-01-10 09:47:18'),
(22, 8, 'https://storage.googleapis.com/inceptivestudio/1673435001370.png', '2023-01-10 13:14:08'),
(23, 8, 'https://storage.googleapis.com/inceptivestudio/1673435001370.png', '2023-01-10 13:14:09'),
(24, 8, 'https://storage.googleapis.com/inceptivestudio/1673435001370.png', '2023-01-10 13:14:09'),
(25, 9, 'https://storage.googleapis.com/inceptivestudio/1673435184477.png', '2023-01-10 13:21:55'),
(26, 9, 'https://storage.googleapis.com/inceptivestudio/1673435184477.png', '2023-01-10 13:21:56'),
(27, 9, 'https://storage.googleapis.com/inceptivestudio/1673435184477.png', '2023-01-10 13:21:56'),
(28, 10, 'https://storage.googleapis.com/inceptivestudio/1673435259846.png', '2023-01-10 13:28:49'),
(29, 10, 'https://storage.googleapis.com/inceptivestudio/1673435259846.png', '2023-01-10 13:28:49'),
(30, 10, 'https://storage.googleapis.com/inceptivestudio/1673435259846.png', '2023-01-10 13:28:50'),
(31, 11, 'https://storage.googleapis.com/inceptivestudio/1673435319987.png', '2023-01-10 13:39:31'),
(32, 11, 'https://storage.googleapis.com/inceptivestudio/1673435319987.png', '2023-01-10 13:39:32'),
(33, 11, 'https://storage.googleapis.com/inceptivestudio/1673435319987.png', '2023-01-10 13:39:33'),
(34, 12, 'https://storage.googleapis.com/inceptivestudio/1673435398303.png', '2023-01-11 07:09:41'),
(35, 12, 'https://storage.googleapis.com/inceptivestudio/1673435398303.png', '2023-01-11 07:09:42'),
(36, 12, 'https://storage.googleapis.com/inceptivestudio/1673435398303.png', '2023-01-11 07:09:42'),
(37, 13, 'https://storage.googleapis.com/inceptivestudio/1673435481797.png', '2023-01-11 07:26:08'),
(38, 13, 'https://storage.googleapis.com/inceptivestudio/1673435481797.png', '2023-01-11 07:26:08'),
(39, 13, 'https://storage.googleapis.com/inceptivestudio/1673435481797.png', '2023-01-11 07:26:09'),
(40, 14, 'https://storage.googleapis.com/inceptivestudio/1673435579989.png', '2023-01-11 07:32:25'),
(41, 14, 'https://storage.googleapis.com/inceptivestudio/1673435579989.png', '2023-01-11 07:32:25'),
(42, 14, 'https://storage.googleapis.com/inceptivestudio/1673435579989.png', '2023-01-11 07:32:26'),
(43, 15, 'https://storage.googleapis.com/inceptivestudio/1673435651833.png', '2023-01-11 07:35:50'),
(44, 15, 'https://storage.googleapis.com/inceptivestudio/1673435651833.png', '2023-01-11 07:35:51'),
(45, 15, 'https://storage.googleapis.com/inceptivestudio/1673435651833.png', '2023-01-11 07:35:52'),
(46, 16, 'https://storage.googleapis.com/inceptivestudio/1673435707404.png', '2023-01-11 07:40:35'),
(47, 16, 'https://storage.googleapis.com/inceptivestudio/1673435707404.png', '2023-01-11 07:40:36'),
(48, 16, 'https://storage.googleapis.com/inceptivestudio/1673435707404.png', '2023-01-11 07:40:37'),
(49, 17, 'https://storage.googleapis.com/inceptivestudio/1673435791023.png', '2023-01-11 07:44:12'),
(50, 17, 'https://storage.googleapis.com/inceptivestudio/1673435791023.png', '2023-01-11 07:44:13'),
(51, 17, 'https://storage.googleapis.com/inceptivestudio/1673435791023.png', '2023-01-11 07:44:13'),
(52, 18, 'https://storage.googleapis.com/inceptivestudio/1673435875143.png', '2023-01-11 07:51:08'),
(53, 18, 'https://storage.googleapis.com/inceptivestudio/1673435875143.png', '2023-01-11 07:51:09'),
(54, 18, 'https://storage.googleapis.com/inceptivestudio/1673435875143.png', '2023-01-11 07:51:09'),
(55, 19, 'https://storage.googleapis.com/inceptivestudio/1673432784104.png', '2023-01-11 10:31:01'),
(56, 19, 'https://storage.googleapis.com/inceptivestudio/1673432784104.png', '2023-01-11 10:31:01'),
(57, 19, 'https://storage.googleapis.com/inceptivestudio/1673432784104.png', '2023-01-11 10:31:02'),
(58, 20, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-01 07:38:10'),
(59, 20, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-01 07:38:11'),
(60, 20, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-01 07:38:11'),
(61, 21, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 12:46:52'),
(62, 21, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 12:46:53'),
(63, 21, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 12:46:54'),
(64, 22, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 13:06:49'),
(65, 22, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 13:06:50'),
(66, 22, 'https://storage.googleapis.com/inceptivestudio/1672405753688.png', '2023-03-02 13:06:50');

INSERT INTO `tbl_product_order_details` (`id`, `user_id`, `order_id`, `product_id`, `quantity`, `unit`, `price`, `currency`, `duration`, `duration_type`, `delivery_id`, `status`, `updated_at`, `created_at`) VALUES
(1, 3, 1, 14, 1, 'oz', 2065.48, 'USD', 0, '', 'ghjhdg', 'deliver', '2023-01-27 12:28:31', '2023-01-27 12:28:31'),
(2, 3, 1, 1, 1, 'oz', 2065.48, 'USD', 0, '', 'ghjhdg', 'deliver', '2023-01-27 12:28:32', '2023-01-27 12:28:32'),
(3, 1, 2, 1, 1, 'oz', 2033.96, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:08', '2023-01-31 07:12:34'),
(4, 1, 2, 1, 1, 'oz', 2033.96, 'USD', 1, 'Month', '0', 'stake', '2023-03-15 07:35:08', '2023-01-31 07:12:35'),
(5, 1, 2, 1, 1, 'oz', 2051.60, 'USD', 0, '', '0', 'collect', '2023-01-31 07:12:36', '2023-01-31 07:12:36'),
(6, 1, 2, 1, 1, 'oz', 2051.60, 'USD', 0, '', 'BusinessBay', 'deliver', '2023-01-31 07:12:37', '2023-01-31 07:12:37'),
(7, 11, 3, 1, 1, 'oz', 2043.12, 'USD', 0, '', '2003 Fairmont hotel ', 'deliver', '2023-01-31 09:35:25', '2023-01-31 09:35:25'),
(8, 11, 4, 13, 1, 'swiss francs', 1258.12, 'USD', 0, '', '0', 'collect', '2023-01-31 09:56:05', '2023-01-31 09:56:05'),
(10, 3, 6, 16, 1, 'gr', 61.25, 'USD', 0, '', 'ghjj', 'deliver', '2023-01-31 11:10:02', '2023-01-31 11:10:02'),
(11, 3, 6, 1, 1, 'oz', 2041.38, 'USD', 0, '', 'ghjj', 'deliver', '2023-01-31 11:10:03', '2023-01-31 11:10:03'),
(12, 3, 6, 2, 1, 'gr', 339.23, 'USD', 0, '', 'ghjj', 'deliver', '2023-01-31 11:10:04', '2023-01-31 11:10:04'),
(13, 3, 7, 1, 2, 'oz', 2033.96, 'USD', 1, 'Month', '0', 'stake', '2023-03-15 07:35:08', '2023-01-31 11:10:29'),
(14, 3, 7, 1, 1, 'oz', 2041.38, 'USD', 0, '', '0', 'collect', '2023-01-31 11:10:30', '2023-01-31 11:10:30'),
(16, 2, 8, 1, 2, 'oz', 2068.24, 'USD', 0, '', 'rwetert', 'deliver', '2023-02-07 10:05:47', '2023-02-01 12:25:57'),
(17, 2, 9, 2, 3, 'gr', 348.34, 'USD', 0, '', '0', 'deliver', '2023-02-07 11:36:40', '2023-02-02 07:34:17'),
(18, 2, 10, 2, 3, 'gr', 348.26, 'USD', 0, '', '0', 'deliver', '2023-02-07 11:36:40', '2023-02-02 07:45:14'),
(19, 2, 11, 2, 3, 'gr', 348.80, 'USD', 0, '', '0', 'deliver', '2023-02-07 11:36:40', '2023-02-02 08:18:10'),
(20, 2, 12, 11, 2, 'gr', 180.11, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 12:11:04'),
(22, 2, 14, 11, 2, 'gr', 180.19, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 12:29:42'),
(23, 2, 15, 11, 2, 'gr', 180.19, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 12:31:26'),
(24, 2, 16, 11, 2, 'gr', 180.20, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 12:43:01'),
(25, 2, 17, 11, 2, 'gr', 180.09, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 12:58:53'),
(26, 2, 18, 11, 2, 'gr', 180.06, 'USD', 0, '', '131', 'deliver', '2023-02-07 10:06:45', '2023-02-02 13:08:26'),
(29, 2, 19, 2, 1, 'gr', 340.98, 'USD', 0, '', '0', 'collect', '2023-02-03 13:19:01', '2023-02-03 13:19:01'),
(30, 2, 19, 2, 3, 'gr', 340.98, 'USD', 0, '', '131', 'deliver', '2023-02-07 11:36:40', '2023-02-03 13:19:02'),
(31, 2, 8, 1, 2, 'oz', 2033.96, 'USD', 1, 'Month', '0', 'stake', '2023-03-15 07:35:08', '2023-02-03 13:21:12'),
(34, 2, 20, 1, 1, 'oz', 2008.82, 'USD', 0, '', '0', 'collect', '2023-02-07 08:25:41', '2023-02-07 08:25:41'),
(35, 2, 20, 1, 2, 'oz', 2008.82, 'USD', 0, '', '130', 'deliver', '2023-02-07 10:05:47', '2023-02-07 08:25:42'),
(36, 2, 19, 2, 1, 'gr', 338.00, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:09', '2023-02-07 10:10:53'),
(37, 2, 21, 2, 1, 'gr', 333.50, 'USD', 0, '', '151', 'deliver', '2023-02-07 11:37:56', '2023-02-07 11:37:56'),
(38, 3, 22, 16, 2, 'gr', 60.22, 'USD', 0, '', '155', 'deliver', '2023-02-07 11:57:29', '2023-02-07 11:57:29'),
(39, 3, 22, 18, 1, 'gr', 668.04, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:18', '2023-02-07 11:57:31'),
(40, 3, 22, 18, 1, 'gr', 668.04, 'USD', 1, 'Month', '0', 'stake', '2023-03-15 07:35:18', '2023-02-07 11:57:32'),
(41, 3, 23, 2, 1, 'gr', 333.50, 'USD', 0, '', '0', 'collect', '2023-02-07 12:09:37', '2023-02-07 12:09:37'),
(42, 3, 23, 2, 1, 'gr', 333.50, 'USD', 0, '', '156', 'deliver', '2023-02-07 12:09:39', '2023-02-07 12:09:39'),
(43, 11, 5, 17, 1, 'oz', 1952.36, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:17', '2023-02-28 10:31:28'),
(45, 2, 24, 1, 1, 'oz', 2033.96, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:08', '2023-03-02 10:54:24'),
(46, 2, 25, 1, 1, 'oz', 2033.96, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:08', '2023-03-02 10:56:27'),
(47, 1, 26, 4, 1, 'gr', 338.00, 'AED', 6, 'Month', '1', 'stake', '2023-03-15 07:35:10', '2023-03-02 10:59:00'),
(48, 1, 26, 4, 5, 'gr', 326.30, 'AED', 0, '', '1', 'deliver', '2023-03-02 10:59:01', '2023-03-02 10:59:01'),
(49, 1, 26, 4, 2, 'gr', 326.30, 'AED', 0, '', '0', 'collect', '2023-03-02 10:59:02', '2023-03-02 10:59:02'),
(50, 1, 26, 4, 5, 'gr', 338.00, 'AED', 0, '', '0', 'store', '2023-03-15 07:35:10', '2023-03-02 10:59:03'),
(51, 1, 27, 4, 1, 'gr', 338.00, 'AED', 6, 'Month', '1', 'stake', '2023-03-15 07:35:10', '2023-03-02 11:03:23'),
(52, 1, 27, 4, 5, 'gr', 326.32, 'AED', 0, '', '1', 'deliver', '2023-03-02 11:03:24', '2023-03-02 11:03:24'),
(53, 1, 27, 4, 2, 'gr', 326.32, 'AED', 0, '', '0', 'collect', '2023-03-02 11:03:25', '2023-03-02 11:03:25'),
(54, 1, 27, 4, 5, 'gr', 338.00, 'AED', 0, '', '0', 'store', '2023-03-15 07:35:10', '2023-03-02 11:03:26'),
(55, 1, 28, 4, 1, 'gr', 338.00, 'AED', 6, 'Month', '1', 'stake', '2023-03-15 07:35:10', '2023-03-02 11:04:20'),
(56, 1, 28, 4, 5, 'gr', 326.31, 'AED', 0, '', '1', 'deliver', '2023-03-02 11:04:21', '2023-03-02 11:04:21'),
(57, 1, 28, 4, 2, 'gr', 326.31, 'AED', 0, '', '0', 'collect', '2023-03-02 11:04:22', '2023-03-02 11:04:22'),
(58, 1, 28, 4, 5, 'gr', 338.00, 'AED', 0, '', '0', 'store', '2023-03-15 07:35:10', '2023-03-02 11:04:23'),
(59, 2, 29, 1, 1, 'oz', 2033.96, 'USD', 0, '', '0', 'store', '2023-03-15 07:35:08', '2023-03-02 11:08:07');

INSERT INTO `tbl_product_orders` (`id`, `user_id`, `subtotal`, `total`, `currency`, `txn_token`, `coupon_code`, `discount_price`, `status`, `updated_at`, `created_at`) VALUES
(1, 3, 4130.96, 4130.96, 'USD', 'wallet-3-250000-4130.96', '', 0.00, 'pending', '2023-01-27 12:28:30', '2023-01-27 12:28:30'),
(2, 1, 8206.40, 8206.40, 'USD', 'wallet-1-10000-8206.40', '', 0.00, 'pending', '2023-01-31 07:12:33', '2023-01-31 07:12:33'),
(3, 11, 2043.12, 2043.12, 'USD', 'wallet-11-100000-2043.12', '', 0.00, 'pending', '2023-01-31 09:35:25', '2023-01-31 09:35:25'),
(4, 11, 1258.12, 1258.12, 'USD', 'wallet-11-97956.88-1258.12', '', 0.00, 'pending', '2023-01-31 09:56:04', '2023-01-31 09:56:04'),
(5, 11, 1961.23, 1961.23, 'USD', 'wallet-11-96698.76-1961.23', '', 0.00, 'pending', '2023-01-31 10:01:59', '2023-01-31 10:01:59'),
(6, 3, 2441.86, 2441.86, 'USD', 'wallet-3-245869.05-2441.86', '', 0.00, 'pending', '2023-01-31 11:10:01', '2023-01-31 11:10:01'),
(7, 3, 6124.14, 6124.14, 'USD', 'wallet-3-243427.19-6124.14', '', 0.00, 'pending', '2023-01-31 11:10:28', '2023-01-31 11:10:28'),
(8, 2, 4136.48, 4136.48, 'USD', 'wallet-2-5000-4136.48', '', 0.00, 'pending', '2023-02-01 12:25:55', '2023-02-01 12:25:55'),
(9, 2, 348.34, 348.34, 'USD', 'wallet-2-863.52-348.34', '', 0.00, 'pending', '2023-02-02 07:34:16', '2023-02-02 07:34:16'),
(10, 2, 348.35, 348.35, 'USD', 'wallet-2-515.18-348.35', '', 0.00, 'pending', '2023-02-02 07:45:14', '2023-02-02 07:45:14'),
(11, 2, 348.68, 348.68, 'USD', 'wallet-2-100166.83-348.68', '', 0.00, 'pending', '2023-02-02 08:18:10', '2023-02-02 08:18:10'),
(12, 2, 180.11, 180.11, 'USD', 'wallet-2-99818.15-180.11', '', 0.00, 'pending', '2023-02-02 12:11:03', '2023-02-02 12:11:03'),
(13, 2, 180.16, 130.16, 'USD', 'wallet-2-99638.04-130.16', 'sec50', 50.00, 'pending', '2023-02-02 12:12:26', '2023-02-02 12:12:26'),
(14, 2, 180.19, 180.19, 'USD', 'wallet-2-99507.88-180.19', '', 0.00, 'pending', '2023-02-02 12:29:41', '2023-02-02 12:29:41'),
(15, 2, 180.19, 180.19, 'USD', 'wallet-2-99327.69-180.19', '', 0.00, 'pending', '2023-02-02 12:31:25', '2023-02-02 12:31:25'),
(16, 2, 180.21, 130.21, 'USD', 'wallet-2-99147.5-130.21', 'sec50', 50.00, 'pending', '2023-02-02 12:43:00', '2023-02-02 12:43:00'),
(17, 2, 180.09, 180.09, 'USD', 'wallet-2-99017.29-180.09', 'sec50', 50.00, 'pending', '2023-02-02 12:58:52', '2023-02-02 12:58:52'),
(18, 2, 180.06, 130.06, 'USD', 'wallet-2-98837.2-130.06', 'sec50', 50.00, 'pending', '2023-02-02 13:08:25', '2023-02-02 13:08:25'),
(19, 2, 1704.90, 1654.90, 'USD', 'wallet-2-98707.14-1654.90', 'sec50', 50.00, 'pending', '2023-02-03 13:18:58', '2023-02-03 13:18:58'),
(20, 2, 8035.28, 8035.28, 'USD', 'wallet-2-97052.24-8035.28', '', 0.00, 'pending', '2023-02-07 08:25:38', '2023-02-07 08:25:38'),
(21, 2, 333.50, 333.50, 'USD', 'wallet-2-89016.96-333.50', '', 0.00, 'pending', '2023-02-07 11:37:55', '2023-02-07 11:37:55'),
(22, 3, 1438.80, 1438.80, 'USD', 'wallet-3-237303.05-1438.80', '', 0.00, 'pending', '2023-02-07 11:57:29', '2023-02-07 11:57:29'),
(23, 3, 667.00, 667.00, 'USD', 'wallet-3-235864.25-667.00', '', 0.00, 'pending', '2023-02-07 12:09:37', '2023-02-07 12:09:37'),
(24, 2, 1963.51, 1963.51, 'USD', 'wallet-2-88683.46-1963.51', '', 0.00, 'pending', '2023-03-02 10:54:23', '2023-03-02 10:54:23'),
(25, 2, 1963.56, 1963.56, 'USD', 'wallet-2-86719.95-1963.56', '', 0.00, 'pending', '2023-03-02 10:56:26', '2023-03-02 10:56:26'),
(26, 1, 100.00, 100.00, 'AED', 'wallet-1-1793.6-100', 'SEC50', 50.00, 'pending', '2023-03-02 10:58:59', '2023-03-02 10:58:59'),
(27, 1, 100.00, 100.00, 'AED', 'wallet-1-1693.6-100', 'SEC50', 50.00, 'pending', '2023-03-02 11:03:22', '2023-03-02 11:03:22'),
(28, 1, 100.00, 100.00, 'AED', 'wallet-1-1593.6-100', 'SEC50', 50.00, 'pending', '2023-03-02 11:04:19', '2023-03-02 11:04:19'),
(29, 2, 1963.64, 1963.64, 'USD', 'wallet-2-84756.39-1963.64', '', 0.00, 'pending', '2023-03-02 11:08:06', '2023-03-02 11:08:06');

INSERT INTO `tbl_products` (`id`, `category_id`, `title`, `description`, `about`, `specification`, `symbol`, `price`, `last_price`, `quantity`, `unit`, `status`, `created_at`) VALUES
(1, 1, 'Al Etihad, FLOWER BASKET', '1oz Gold Bar 999.9', 'About Al Etihad Gold: a significant new gold refiner and bar manufacturer in the UAE, was established in Dubai in 2009. Al Etihad is one of the region\'s most versatile full-service gold and silver refineries with expertise in gold and silver refining, smelting, assaying and minting.', 'Manufacturer: Al-Etihad Gold\r\nPurity: 999.9\r\nWeight(gm): 1oz', 'PAMPSuisse-1oz', NULL, 2033.96, 1.0, 'oz', 1, '2022-12-30 17:26:53'),
(2, 1, 'Al Etihad', '5gm Gold Oval Pendant 999.9', 'About Al Etihad Gold: a significant new gold refiner and bar manufacturer in the UAE, was established in Dubai in 2009. Al Etihad is one of the region\'s most versatile full-service gold and silver refineries with expertise in gold and silver refining, smelting, assaying and minting.', 'Manufacturer: PAMP Suisse \r\nPurity: 999.9\r\nWeight(gr): 5gm', 'PAMPSuisse-5gm', 0.5, 338.00, 5.0, 'gr', 1, '2022-12-30 17:28:21'),
(3, 1, 'PAMP Suisse', '1kg Gold Bar 999.9', 'About PAMP Suisse: Founded in 1977 as an independent refinery and located in Ticino, Switzerland, it is now part of the larger Geneva-based MKS Group. MKS is a global financial services and precious metals firm. \r\nPAMP Suisse gold bars are available for sale around the world to investors and its refinery logo and distinctive Fortuna design are easily recognizable as symbols of quality and purity. \r\nOn the international gold market, PAMP Suisse gold bars are considered to be the best gold bars.  ', 'Manufacturer: PAMP Suisse                                                                            \r\nWeight (gm): 1,000.00 gm                                                                                         \r\nWeight (oz): 32.148 oz                                                                                                 \r\nThickness: 9.2mm                                                                                                   \r\nLength: 115.50 mm                                                                                                         \r\nPurity: 999.9                                                                                                                   \r\nWidth: 52.50 mm ', 'GOLD.1kg9999', 0.5, 60966.79, 1.0, 'kl', 1, '2023-01-05 12:25:18'),
(4, 1, 'PAMP Suisse - The Rose', '5gm Gold Bar 999.9', 'About PAMP Suisse: Founded in 1977 as an independent refinery and located in Ticino, Switzerland, it is now part of the larger Geneva-based MKS Group. MKS is a global financial services and precious metals firm. \r\nPAMP Suisse gold bars are available for sale around the world to investors and its refinery logo and distinctive Fortuna design are easily recognizable as symbols of quality and purity. \r\nOn the international gold market, PAMP Suisse gold bars are considered to be the best gold bars. ', 'Manufacturer: PAMP Suisse\r\nThickness: 0.79 mm\r\nPurity: 999.9\r\nWeight (gm): 5.00 gm\r\nWeight (oz): 0.161 oz\r\nLength: 23.30 mm\r\nWidth: 14.00 mm', 'PAMPSuisse-5gm', 0.0, 338.00, 5.0, 'gr', 1, '2023-01-10 09:44:41'),
(5, 2, ' Silver Bar', '12 x 1gr Multi-Gram', 'Lady fortuna Lady fortuna Lady fortuna', 'Lady fortuna Lady fortuna Lady fortuna Lady fortuna Lady fortuna', NULL, 0.0, 60.00, 1.0, 'gr', 1, '2023-01-10 09:45:04'),
(8, 1, 'Valcambi Suisse', '20gm Gold Bar 999.9', 'About Valcambi Suisse: Founded in Balerna, Switzerland in 1961 as Valori & Cambi. The purchase of the young company by Credit Suisse resulted in the brand name known today around the world (Valcambi Suisse) and the improvement of the refinery to London and Comex Good Delivery standards. These cast gold bullion bars are produced by Valcambi, one of Switzerland\'s most prominent precious metals refineries which offers a wide range of minted and cast gold bars.', 'Manufacturer: Valcambi\r\nPurity: 999.9 \r\nWeight(oz): 0.643 Oz\r\nWeight (gm): 20 gm\r\nSize:3 1.00 x 18.00 mm\r\nThickness: 2.2 mm', 'PAMPSuisse-20gm', 0.5, 1316.93, 20.0, 'gr', 1, '2023-01-10 13:14:08'),
(9, 1, 'Valcambi', '100g Gold Bar 999.9', 'About Valcambi Suisse: Founded in Balerna, Switzerland in 1961 as Valori & Cambi. The purchase of the young company by Credit Suisse resulted in the brand name known today around the world (Valcambi Suisse) and the improvement of the refinery to London and Comex Good Delivery standards. These cast gold bullion bars are produced by Valcambi, one of Switzerland\'s most prominent precious metals refineries which offers a wide range of minted and cast gold bars.', 'Manufacturer: Valcambi \r\nPurity: 999.9 \r\nWeight(oz): 3.215 oz\r\nWeight (gr): 100 gr  \r\nSize: 26.00 x 44.00 mm \r\nThickness: 2.2 mm', 'GOLD.1kg9999', 45.0, 60966.79, 100.0, 'gr', 1, '2023-01-10 13:21:54'),
(10, 1, 'Al Etihad, BUTTERFLY', '5gm Gold Bar 999.9', 'About Al Etihad Gold: a significant new gold refiner and bar manufacturer in the UAE, was established in Dubai in 2009. Al Etihad is one of the region\'s most versatile full-service gold and silver refineries with expertise in gold and silver refining, smelting, assaying and minting.', 'Manufacturer: Al-Etihad Gold\r\nPurity: 999.9\r\nWeight(g): 5gm', 'PAMPSuisse-5gm', 0.5, 338.00, 5.0, 'gr', 1, '2023-01-10 13:28:48'),
(11, 1, 'Al Etihad, MECCA', '2.5gm Gold Bar 999.9', 'About Al Etihad Gold: a significant new gold refiner and bar manufacturer in the UAE, was established in Dubai in 2009. Al Etihad is one of the region\'s most versatile full-service gold and silver refineries with expertise in gold and silver refining, smelting, assaying and minting.', 'Manufacturer: Al-Etihad Gold\r\nPurity: 999.9\r\nWeight(g): 2gm', 'PAMPSuisse-2.5gm', 0.5, 174.95, 2.5, 'gr', 1, '2023-01-10 13:39:31'),
(12, 1, 'Valcambi Cast', '1kg Gold Bar 999.9', 'About Valcambi Suisse: Founded in Balerna, Switzerland in 1961 as Valori & Cambi. The purchase of the young company by Credit Suisse resulted in the brand name known today around the world (Valcambi Suisse) and the improvement of the refinery to London and Comex Good Delivery standards. These cast gold bullion bars are produced by Valcambi, one of Switzerland\'s most prominent precious metals refineries which offers a wide range of minted and cast gold bars.', 'Manufacturer: Valcamb\r\nPurity: 999.9\r\nWeight(oz): 32.15 oz\r\nWeight (gm): 1,000 gm\r\nWidth (mm): 53 mm\r\nHeight (mm): 117 mm\r\nThickness (mm): 9 mm', 'GOLD.1kg9999', 0.5, 60966.79, 1.0, 'kl', 1, '2023-01-11 07:09:40'),
(13, 1, 'Swissmint - Helvetia Vreneli', '20 Swiss Francs Gold Coin 900.0', 'About Swissmint: It is the official mont of the Swiss Confederation. Swissmint manufactures coins for the Swiss government and also bullions, medals and other memorabilia.', 'Year: 1897 - 1949\r\nManufacturer: Swismint\r\nPurity: 900.0\r\nWeight (gr): 5.81 gr\r\nWeight (oz): 0.187 oz\r\nDiameter: 21.00 mm', 'HELVETIA-VRENELI-900', 0.7, 1252.43, 20.0, 'swiss francs', 1, '2023-01-11 07:26:07'),
(14, 1, 'Royal Canadian Mint', '1oz 999.9 Fine Gold Bar', 'About Royal Canadian Mint: Canada’s official mint, The Royal Canadian Mint (RCM), makes some of the most popular gold bullion and silver bullion coins on the market. RCM operates two minting facilities that produce everything from Canada’s circulation coins to bullion coins, medals, and circulation coins on behalf of other nations. It was founded in 1908, and operates as a Crown Corporation of Canada. These organizations are state-owned but generally enjoy greater freedom from direct political control than government departments. Canada’s mint is somewhat unusual because it is expected to turn a profit even though it is not privately owned.', 'Manufacturer: Royal Canadian Mint\r\nPurity: 999.9\r\nWeight: 31.1035 gr\r\nWeight(oz): 1 oz\r\nThickness: 1.5 mm\r\nSize (mm): 50 x 28 mm', 'PAMPSuisse-1oz', 15.0, 2033.96, 1.0, 'oz', 1, '2023-01-11 07:32:24'),
(15, 1, 'Emirates', '50gm Gold Bar 999.9', 'About Emirates Gold: It is a precious metal refinery, bullion manufacturer, and dealer based in Dubai, United Arab Emirates. Working primarily with gold and silver, the company produces its own bullion (such as 995 and 999.9 purity kilobars) that is recognized internationally, as well as other products such as investment bars in sizes ranging from 1 gram to 100 grams, and customized coins and medals. Founded in 1992, it is one of the largest refineries in the Middle East. Dubai is a very famous market for gold buying and selling and attracts investors interested in making profits.', 'Manufacturer: Emirates Gold\r\nSize: 47.00 x 27.00 mm\r\nThickness: 2.13 mm\r\nPurity: 999.9\r\nWeight(gm): 50 gm\r\nWeight(oz):  1.60 oz', 'PAMPSuisse-50gm', 28.1, 3266.34, 5.0, 'tolas', 1, '2023-01-11 07:35:50'),
(16, 1, 'Emirites', '5 Tolas Gold Bar', 'One of the mid-point bars in the Emirates Gold range, this 5 Tola (58.32 gr) investment gold bar displays the attention to detail and craftsmanship associated with this well-respected manufacturer. The front of the bar is stamped with the Emirates Gold logo together with the weight and fineness (999.9) of the bar. The reverse of the bar is beautifully decorated with a ‘Rose of Dubai’ image on a mirror finish background. The front of the bar features the Emirates logo, with the bar\'s weight, fineness and serial number below.', 'Manufacturer: Emirates Gold\r\nSize: 47 x 27 mm \r\nThickness: 2.50 mm\r\nPurity: 999.9\r\nWeight(gm): 58.32 gm\r\nWeight(oz) 1.875 oz', 'GOLD.1g', 0.5, 61.03, 50.0, 'gr', 1, '2023-01-11 07:40:35'),
(17, 1, 'American Eagle BU', '1oz Fine Gold Coin 916.7', 'Carefully crafted coins by the US Mint.', 'Year: Mixed Years\r\nMint Mark: United States Mint\r\nThickness: 2.83\r\nPurity: 916.7\r\nWeight (gr): 31.10 gr\r\nWeight (oz): 1.000 oz\r\nDiameter: 32.70 mm', 'AMERICAN-EAGLE-BU-916-7', 20.0, 1952.36, 1.0, 'oz', 1, '2023-01-11 07:44:12'),
(18, 1, 'Al Etihad, FLOWER BASKET', '10gm Gold Bar 999.9', 'About Al Etihad Gold: a significant new gold refiner and bar manufacturer in the UAE, was established in Dubai in 2009. Al Etihad is one of the region\'s most versatile full-service gold and silver refineries with expertise in gold and silver refining, smelting, assaying and minting.', 'Manufacturer: Al-Etihad Gold\r\nPurity: 999.9\r\nWeight(gm): 10gm', 'PAMPSuisse-10gm', 0.5, 668.04, 10.0, 'gr', 1, '2023-01-11 07:51:08'),
(19, 1, 'PAMP Suisse - Lady Fortuna Veriscan', '1oz Fine Gold Bar 999.9', 'About PAMP Suisse: Founded in 1977 as an independent refinery and located in Ticino, Switzerland, it is now part of the larger Geneva-based MKS Group. MKS is a global financial services and precious metals firm. PAMP Suisse gold bars are available for sale around the world to investors and its refinery logo and distinctive Fortuna design are easily recognizable as symbols of quality and purity. On the international gold market, PAMP Suisse gold bars are considered to be the best gold bars.  ', 'Manufacturer: PAMP Suisse\r\nThickness: 1.66                                                                                                           \r\npurity: 999.9                                                                                      \r\nWeight (gm): 31.10 gm\r\nWeight (oz): 1.000 oz\r\nLength: 41.00 mm\r\nWidth: 24.00 mm', 'PAMPSuisse-1oz', 15.0, 2033.96, 1.0, 'oz', 1, '2023-01-11 10:31:00'),
(21, 1, 'Lady fortuna', 'Lady fortuna Lady fortuna Lady fortuna Lady fortuna Lady fortuna', 'Lady fortuna Lady fortuna Lady fortuna', 'Lady fortuna Lady fortuna Lady fortuna Lady fortuna Lady fortuna', NULL, NULL, 0.00, 2.0, 'gr', 1, '2023-03-02 12:46:52'),
(22, 1, 'Lady fortuna Veriscans', 'Lady fortuna Lady fortuna Lady fortuna Lady fortuna Lady fortunass', 'Lady fortuna Lady fortuna Lady fortuna', 'Lady fortuna Lady fortuna Lady fortuna Lady fortuna Lady fortuna', NULL, NULL, 0.00, 2.0, 'gr', 1, '2023-03-02 13:06:48');

INSERT INTO `tbl_user_bank_details` (`id`, `user_id`, `account_holder_name`, `iban`, `bank_name`, `branch`, `swift_code`, `created_at`) VALUES
(1, 3, 'fathima', 'vhhhffg', 'ghycbk', 'bhjbvfi', 'vann ', '2023-01-27 12:12:22'),
(2, 3, 'geueik', 'vdhdidio', 'bshdiskn', 'xjddlksn', ' sjsjk', '2023-01-27 12:18:51'),
(3, 9, 'ancy', 'ghj', 'bjjinb', 'vuik', 'jbhj', '2023-01-27 13:25:16'),
(4, 2, 'gyguuy', 'tret', 'etr', 'text', 'tert', '2023-01-30 08:30:03'),
(5, 11, 'Rishi', 'ae8888888888363737', 'mashreq', 'dubai', 'hhjj', '2023-01-31 07:01:23'),
(6, 1, 'abcd', 'ancd', 'adcb', 'karama', '123455', '2023-01-31 07:07:33');

INSERT INTO `tbl_user_carts` (`id`, `user_id`, `product_id`, `type`, `quantity`, `unit`, `duration`, `duration_type`, `symbol`, `updated_at`, `created_at`) VALUES
(3, 9, 3, 'store', 1, 'kl', 0, NULL, 'GOLD.1kg9999', '2023-01-27 16:23:39', '2023-01-27 16:23:39'),
(4, 9, 3, 'collect', 1, 'kl', 0, NULL, 'GOLD.1kg9999', '2023-01-27 16:23:39', '2023-01-27 16:23:39'),
(15, 1, 1, 'store', 1, 'oz', 0, NULL, 'PAMPSuisse-1oz', '2023-01-31 07:27:58', '2023-01-31 07:27:41');

INSERT INTO `tbl_user_history` (`id`, `user_id`, `history_key`, `history_message`, `created_at`) VALUES
(1, 3, 'otp_code', '930917', '2023-01-31 06:43:20'),
(2, 3, 'otp_code', '165879', '2023-01-31 07:01:19'),
(3, 3, 'otp_code', '548328', '2023-02-01 10:15:52');

INSERT INTO `tbl_user_metadata` (`id`, `user_id`, `meta_key`, `meta_values`, `updated_at`, `created_at`) VALUES
(1, 3, 'utility_bill', NULL, '2023-01-27 12:01:46', '2023-01-27 12:01:46'),
(2, 3, 'otp_code', '792826', '2023-02-01 10:23:34', '2023-01-27 12:01:46'),
(3, 3, 'user_id', '3', '2023-01-27 12:01:47', '2023-01-27 12:01:47'),
(4, 1, 'full_name', 'Abdul', '2023-01-27 12:03:46', '2023-01-27 12:03:46'),
(5, 1, 'email', 'dev@ishro.com', '2023-01-27 12:03:47', '2023-01-27 12:03:47'),
(6, 1, 'mobile', '+971585083135', '2023-01-27 13:57:08', '2023-01-27 12:03:47'),
(7, 1, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-27 12:03:48', '2023-01-27 12:03:48'),
(8, 1, 'confirm_password', '12345678', '2023-01-27 12:03:49', '2023-01-27 12:03:49'),
(9, 1, 'nationality', 'AE', '2023-01-27 12:03:50', '2023-01-27 12:03:50'),
(10, 1, 'passport', 'PASS12333', '2023-01-27 12:03:51', '2023-01-27 12:03:51'),
(11, 1, 'emirates_id', '12223232323232', '2023-01-27 12:03:52', '2023-01-27 12:03:52'),
(12, 1, 'utility_bill', NULL, '2023-01-27 12:03:52', '2023-01-27 12:03:52'),
(13, 1, 'otp_code', '667383', '2023-01-27 12:04:15', '2023-01-27 12:03:53'),
(14, 1, 'user_id', '1', '2023-01-27 12:03:53', '2023-01-27 12:03:53'),
(15, 2, 'full_name', 'shweta kale', '2023-02-03 13:20:04', '2023-01-27 12:05:20'),
(16, 2, 'email', 'shweta@ishro.com', '2023-01-30 11:06:56', '2023-01-27 12:05:21'),
(17, 2, 'mobile', '+971568627971', '2023-01-27 12:05:22', '2023-01-27 12:05:22'),
(18, 2, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-27 12:05:23', '2023-01-27 12:05:23'),
(19, 2, 'confirm_password', '12345678', '2023-01-27 12:05:24', '2023-01-27 12:05:24'),
(20, 2, 'nationality', 'AD', '2023-02-03 13:19:48', '2023-01-27 12:05:25'),
(21, 2, 'passport', '', '2023-01-27 12:05:25', '2023-01-27 12:05:25'),
(22, 2, 'emirates_id', '', '2023-01-27 12:05:26', '2023-01-27 12:05:26'),
(23, 2, 'utility_bill', NULL, '2023-01-27 12:05:27', '2023-01-27 12:05:27'),
(24, 2, 'otp_code', '571642', '2023-01-30 08:24:36', '2023-01-27 12:05:28'),
(25, 2, 'user_id', '2', '2023-01-27 12:05:28', '2023-01-27 12:05:28'),
(26, 3, 'full_name', 'Fathima ', '2023-01-27 12:07:36', '2023-01-27 12:07:36'),
(27, 3, 'email', 'secbullionjewelry@gmail.com', '2023-01-27 12:07:37', '2023-01-27 12:07:37'),
(28, 3, 'mobile', '+971543999916', '2023-01-27 12:07:38', '2023-01-27 12:07:38'),
(29, 3, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-27 12:07:38', '2023-01-27 12:07:38'),
(30, 3, 'confirm_password', 'sec@1234', '2023-01-27 12:07:39', '2023-01-27 12:07:39'),
(31, 3, 'nationality', 'AE', '2023-01-27 12:07:40', '2023-01-27 12:07:40'),
(32, 3, 'passport', '1233', '2023-01-27 12:07:41', '2023-01-27 12:07:41'),
(33, 3, 'emirates_id', '', '2023-01-27 12:07:42', '2023-01-27 12:07:42'),
(34, 3, 'otp_code', '792826', '2023-02-01 10:23:34', '2023-01-27 12:07:43'),
(35, 3, 'user_id', '3', '2023-01-27 12:07:44', '2023-01-27 12:07:44'),
(36, 4, 'full_name', 'Abdul Ihshan', '2023-01-27 12:13:07', '2023-01-27 12:13:07'),
(37, 4, 'email', 'dev@irooo.com', '2023-01-27 12:13:08', '2023-01-27 12:13:08'),
(38, 4, 'mobile', '+971585113104', '2023-01-27 12:13:08', '2023-01-27 12:13:08'),
(39, 4, 'otp_code', '665943', '2023-01-27 12:13:09', '2023-01-27 12:13:09'),
(40, 4, 'user_id', '4', '2023-01-27 12:13:10', '2023-01-27 12:13:10'),
(41, 5, 'full_name', 'Abdul Ihshan', '2023-01-27 12:14:18', '2023-01-27 12:14:18'),
(42, 5, 'email', 'dev@iroo.com', '2023-01-27 12:14:19', '2023-01-27 12:14:19'),
(43, 5, 'mobile', '+971115113104', '2023-01-27 12:14:19', '2023-01-27 12:14:19'),
(44, 5, 'passport', 'tfrtyr', '2023-01-27 12:14:20', '2023-01-27 12:14:20'),
(45, 5, 'otp_code', '266890', '2023-01-27 12:14:21', '2023-01-27 12:14:21'),
(46, 5, 'user_id', '5', '2023-01-27 12:14:21', '2023-01-27 12:14:21'),
(47, 6, 'full_name', 'Abdul Ihshan', '2023-01-27 12:14:49', '2023-01-27 12:14:49'),
(48, 6, 'email', 'dev@isho.com', '2023-01-27 12:14:49', '2023-01-27 12:14:49'),
(49, 6, 'mobile', '+971585343134', '2023-01-27 12:14:50', '2023-01-27 12:14:50'),
(50, 6, 'passport', 'efwefwe', '2023-01-27 12:14:51', '2023-01-27 12:14:51'),
(51, 6, 'otp_code', '553366', '2023-01-27 12:14:52', '2023-01-27 12:14:52'),
(52, 6, 'user_id', '6', '2023-01-27 12:14:52', '2023-01-27 12:14:52'),
(53, 7, 'full_name', 'Abdul Ihshan', '2023-01-27 12:16:29', '2023-01-27 12:16:29'),
(54, 7, 'email', 'dev@ishuo.com', '2023-01-27 12:16:29', '2023-01-27 12:16:29'),
(55, 7, 'mobile', '+971589043134', '2023-01-27 12:16:30', '2023-01-27 12:16:30'),
(56, 7, 'passport', 'efwefwe4666', '2023-01-27 12:16:31', '2023-01-27 12:16:31'),
(57, 7, 'otp_code', '607567', '2023-01-27 12:16:32', '2023-01-27 12:16:32'),
(58, 7, 'user_id', '7', '2023-01-27 12:16:32', '2023-01-27 12:16:32'),
(59, 8, 'full_name', 'abcd', '2023-01-27 12:16:41', '2023-01-27 12:16:41'),
(60, 8, 'email', 'abc@email.com', '2023-01-27 12:16:42', '2023-01-27 12:16:42'),
(61, 8, 'mobile', '+971251436784', '2023-01-27 12:16:43', '2023-01-27 12:16:43'),
(62, 8, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-27 12:16:43', '2023-01-27 12:16:43'),
(63, 8, 'confirm_password', '12345678', '2023-01-27 12:16:44', '2023-01-27 12:16:44'),
(64, 8, 'nationality', 'AE', '2023-01-27 12:16:45', '2023-01-27 12:16:45'),
(65, 8, 'passport', 'QWERTY123', '2023-01-27 12:16:46', '2023-01-27 12:16:46'),
(66, 8, 'emirates_id', '', '2023-01-27 12:16:47', '2023-01-27 12:16:47'),
(67, 8, 'utility_bill', NULL, '2023-01-27 12:16:47', '2023-01-27 12:16:47'),
(68, 8, 'otp_code', '142840', '2023-01-27 12:16:48', '2023-01-27 12:16:48'),
(69, 8, 'user_id', '8', '2023-01-27 12:16:49', '2023-01-27 12:16:49'),
(70, 9, 'full_name', 'ancy', '2023-01-27 13:24:07', '2023-01-27 13:24:07'),
(71, 9, 'email', 'amj@secbullion.com', '2023-01-27 13:24:08', '2023-01-27 13:24:08'),
(72, 9, 'mobile', '+971521437972', '2023-01-27 13:24:09', '2023-01-27 13:24:09'),
(73, 9, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-27 13:24:09', '2023-01-27 13:24:09'),
(74, 9, 'confirm_password', 'ancy9605', '2023-01-27 13:24:10', '2023-01-27 13:24:10'),
(75, 9, 'nationality', 'AE', '2023-01-27 13:24:11', '2023-01-27 13:24:11'),
(76, 9, 'passport', '', '2023-01-27 13:24:12', '2023-01-27 13:24:12'),
(77, 9, 'emirates_id', '', '2023-01-27 13:24:13', '2023-01-27 13:24:13'),
(78, 9, 'utility_bill', NULL, '2023-01-27 13:24:13', '2023-01-27 13:24:13'),
(79, 9, 'otp_code', '738411', '2023-01-27 13:24:31', '2023-01-27 13:24:14'),
(80, 9, 'user_id', '9', '2023-01-27 13:24:15', '2023-01-27 13:24:15'),
(81, 2, 'otp_code', '571642', '2023-01-30 08:24:36', '2023-01-30 08:24:12'),
(82, 2, 'otp_code', '485614', '2023-01-30 11:07:23', '2023-01-30 11:07:23'),
(83, 2, 'otp_code', '443681', '2023-01-30 11:30:09', '2023-01-30 11:30:09'),
(84, 2, 'otp_code', '167872', '2023-01-30 12:22:35', '2023-01-30 12:22:35'),
(85, 1, 'otp_code', '254550', '2023-01-30 12:59:15', '2023-01-30 12:59:15'),
(86, 2, 'otp_code', '635414', '2023-01-31 06:43:25', '2023-01-31 06:43:25'),
(87, 2, 'otp_code', '704735', '2023-01-31 06:49:57', '2023-01-31 06:49:57'),
(88, 10, 'full_name', 'Anu Vijay ', '2023-01-31 06:50:49', '2023-01-31 06:50:49'),
(89, 10, 'email', 'av@sec.group', '2023-01-31 06:50:50', '2023-01-31 06:50:50'),
(90, 10, 'mobile', '+971588780487', '2023-01-31 06:50:50', '2023-01-31 06:50:50'),
(91, 10, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-31 06:50:51', '2023-01-31 06:50:51'),
(92, 10, 'confirm_password', 'Athens@123', '2023-01-31 06:50:52', '2023-01-31 06:50:52'),
(93, 10, 'nationality', 'AE', '2023-01-31 06:50:53', '2023-01-31 06:50:53'),
(94, 10, 'passport', 'R0520060', '2023-01-31 06:50:54', '2023-01-31 06:50:54'),
(95, 10, 'emirates_id', '', '2023-01-31 06:50:54', '2023-01-31 06:50:54'),
(96, 10, 'utility_bill', NULL, '2023-01-31 06:50:55', '2023-01-31 06:50:55'),
(97, 10, 'otp_code', '426126', '2023-01-31 06:51:13', '2023-01-31 06:50:56'),
(98, 10, 'user_id', '10', '2023-01-31 06:50:56', '2023-01-31 06:50:56'),
(99, 11, 'full_name', 'Rishi', '2023-01-31 06:58:04', '2023-01-31 06:58:04'),
(100, 11, 'email', 'das7784@gmail.com', '2023-01-31 06:58:05', '2023-01-31 06:58:05'),
(101, 11, 'mobile', '+971507562018', '2023-01-31 06:58:06', '2023-01-31 06:58:06'),
(102, 11, 'country_code', '{\"callingCode\":\"+971\",\"val\":\"AE\"}', '2023-01-31 06:58:07', '2023-01-31 06:58:07'),
(103, 11, 'confirm_password', 'zxcv@1234', '2023-01-31 06:58:07', '2023-01-31 06:58:07'),
(104, 11, 'nationality', 'AE', '2023-01-31 06:58:08', '2023-01-31 06:58:08'),
(105, 11, 'passport', 'Z4214064', '2023-01-31 06:58:09', '2023-01-31 06:58:09'),
(106, 11, 'emirates_id', '', '2023-01-31 06:58:10', '2023-01-31 06:58:10'),
(107, 11, 'utility_bill', NULL, '2023-01-31 06:58:11', '2023-01-31 06:58:11'),
(108, 11, 'otp_code', '232196', '2023-01-31 06:58:39', '2023-01-31 06:58:12'),
(109, 11, 'user_id', '11', '2023-01-31 06:58:12', '2023-01-31 06:58:12'),
(110, 2, 'otp_code', '844680', '2023-01-31 14:03:48', '2023-01-31 14:03:48'),
(111, 1, 'address', 'Deira, Dubai, United Arab Emirates', '2023-02-01 07:59:12', '2023-02-01 07:59:12'),
(112, 1, 'address', '{\"county\":\"United Arab Emirates\",\"city\":\"Dubai\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-01 08:06:14', '2023-02-01 08:06:14'),
(113, 1, 'address', '{\"county\":\"United Arab Emirates\",\"city\":\"Dubai\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-01 08:08:14', '2023-02-01 08:08:14'),
(114, 1, 'address', '{\"county\":\"United Arab Emirates\",\"city\":\"Dubai\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-01 08:08:23', '2023-02-01 08:08:23'),
(115, 1, 'address', '{\"county\":\"United Arab Emirates\",\"city\":\"Dubai\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-01 08:08:34', '2023-02-01 08:08:34'),
(116, 3, 'otp_code', '301347', '2023-02-01 10:26:52', '2023-02-01 10:26:52'),
(117, 3, 'otp_code', '700702', '2023-02-01 10:31:36', '2023-02-01 10:31:36'),
(118, 3, 'otp_code', '451535', '2023-02-01 10:34:05', '2023-02-01 10:34:05'),
(119, 2, 'otp_code', '894906', '2023-02-01 10:55:43', '2023-02-01 10:55:43'),
(120, 2, 'otp_code', '744709', '2023-02-01 12:25:17', '2023-02-01 12:25:17'),
(121, 2, 'otp_code', '229264', '2023-02-01 13:31:56', '2023-02-01 13:31:56'),
(122, 2, 'otp_code', '110296', '2023-02-01 13:34:43', '2023-02-01 13:34:43'),
(123, 1, 'address', '{\"county\":\"\",\"city\":\"Dubai\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-02 06:52:17', '2023-02-02 06:52:17'),
(124, 1, 'address', '{\"county\":\"\",\"city\":\"\",\"area\":\"Businessbay\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-02 06:52:28', '2023-02-02 06:52:28'),
(125, 1, 'address', '{\"county\":\"\",\"city\":\"\",\"area\":\"\",\"land_mark\":\"Near Ubora\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-02 06:52:34', '2023-02-02 06:52:34'),
(126, 1, 'address', '{\"county\":\"\",\"city\":\"\",\"area\":\"\",\"land_mark\":\"\",\"building\":\"308\",\"room\":\"606\"}', '2023-02-02 06:52:41', '2023-02-02 06:52:41'),
(127, 1, 'address', '{\"county\":\"\",\"city\":\"\",\"area\":\"\",\"land_mark\":\"\",\"building\":\"\",\"room\":\"606\"}', '2023-02-02 06:52:48', '2023-02-02 06:52:48'),
(128, 1, 'address', '{\"county\":\"\",\"city\":\"\",\"area\":\"\",\"land_mark\":\"\",\"building\":\"\",\"room\":\"\"}', '2023-02-02 06:53:52', '2023-02-02 06:53:52'),
(129, 1, 'address', '{\"country\":\"\",\"city\":\"\",\"area\":\"\",\"land_mark\":\"\",\"building\":\"\",\"room\":\"\"}', '2023-02-02 07:37:55', '2023-02-02 07:37:55'),
(130, 2, 'address', '{\"country\":\"UAE\",\"city\":\"Dubai\",\"area\":\"business bay\",\"land_mark\":\"u bora\",\"building\":\"sobha\",\"room\":\"30\"}', '2023-02-02 09:02:54', '2023-02-02 09:02:54'),
(131, 2, 'address', '{\"country\":\"UAE\",\"city\":\"Dubai\",\"area\":\"U-Bora\",\"land_mark\":\"U-Bora\",\"building\":\"abc\",\"room\":\"30\"}', '2023-02-02 11:05:10', '2023-02-02 11:05:10'),
(132, 2, 'otp_code', '390547', '2023-02-03 13:17:32', '2023-02-03 13:17:32'),
(133, 3, 'otp_code', '611265', '2023-02-04 16:09:57', '2023-02-04 16:09:57'),
(134, 2, 'otp_code', '791321', '2023-02-06 09:14:49', '2023-02-06 09:14:49'),
(135, 2, 'otp_code', '317918', '2023-02-06 09:15:54', '2023-02-06 09:15:54'),
(136, 2, 'otp_code', '277516', '2023-02-06 09:18:52', '2023-02-06 09:18:52'),
(137, 2, 'otp_code', '261425', '2023-02-06 10:48:56', '2023-02-06 10:48:56'),
(138, 2, 'otp_code', '186434', '2023-02-06 11:35:42', '2023-02-06 11:35:42'),
(139, 2, 'otp_code', '904368', '2023-02-06 11:55:46', '2023-02-06 11:55:46'),
(140, 2, 'otp_code', '118240', '2023-02-06 13:11:20', '2023-02-06 13:11:20'),
(141, 2, 'otp_code', '217195', '2023-02-06 13:50:21', '2023-02-06 13:50:21'),
(142, 2, 'otp_code', '737305', '2023-02-06 13:51:55', '2023-02-06 13:51:55'),
(143, 2, 'otp_code', '768484', '2023-02-06 14:18:55', '2023-02-06 14:18:55'),
(144, 2, 'otp_code', '241196', '2023-02-07 07:26:00', '2023-02-07 07:26:00'),
(145, 2, 'otp_code', '756401', '2023-02-07 07:35:08', '2023-02-07 07:35:08'),
(146, 2, 'otp_code', '793107', '2023-02-07 07:39:40', '2023-02-07 07:39:40'),
(147, 2, 'otp_code', '659420', '2023-02-07 07:43:46', '2023-02-07 07:43:46'),
(148, 2, 'otp_code', '378252', '2023-02-07 08:11:10', '2023-02-07 08:11:10'),
(149, 2, 'otp_code', '502139', '2023-02-07 09:02:38', '2023-02-07 09:02:38'),
(150, 2, 'otp_code', '504412', '2023-02-07 09:15:24', '2023-02-07 09:15:24'),
(151, 2, 'address', '{\"country\":\"werwe\",\"city\":\"wer\",\"area\":\"wrwe\",\"land_mark\":\"ccvv\",\"building\":\"fff\",\"room\":\"xxc\"}', '2023-02-07 10:06:44', '2023-02-07 10:06:44'),
(152, 2, 'otp_code', '512255', '2023-02-07 11:21:13', '2023-02-07 11:21:13'),
(153, 2, 'otp_code', '548667', '2023-02-07 11:35:58', '2023-02-07 11:35:58'),
(154, 3, 'otp_code', '971823', '2023-02-07 11:55:55', '2023-02-07 11:55:55'),
(155, 3, 'address', '{\"country\":\"red\",\"city\":\"yhnsj\",\"area\":\"ddss\",\"land_mark\":\"sed\",\"building\":\"dsss\",\"room\":\"sssd\"}', '2023-02-07 11:57:26', '2023-02-07 11:57:26'),
(156, 3, 'address', '{\"country\":\"United Arab emirates\",\"city\":\"dubai\",\"area\":\"world trade center\",\"land_mark\":\"trade center\",\"building\":\"fairmont\",\"room\":\"723\"}', '2023-02-07 12:09:34', '2023-02-07 12:09:34'),
(157, 3, 'otp_code', '857478', '2023-02-09 07:10:51', '2023-02-09 07:10:51'),
(158, 4, 'passport', 'jgjgjgu', '2023-03-09 12:51:49', '2023-03-09 12:51:49');

INSERT INTO `tbl_user_wallet_history` (`id`, `user_id`, `transaction_type`, `type`, `amount`, `reference_id`, `created_at`) VALUES
(1, 3, 'deposit', 'balance', 4130.96, '1', '2023-01-27 12:28:33'),
(2, 1, 'deposit', 'balance', 8206.40, '2', '2023-01-31 07:12:38'),
(3, 11, 'deposit', 'balance', 2043.12, '3', '2023-01-31 09:35:26'),
(4, 11, 'deposit', 'balance', 1258.12, '4', '2023-01-31 09:56:06'),
(5, 11, 'deposit', 'balance', 1961.23, '5', '2023-01-31 10:02:00'),
(6, 3, 'deposit', 'balance', 2441.86, '6', '2023-01-31 11:10:05'),
(7, 3, 'deposit', 'balance', 6124.14, '7', '2023-01-31 11:10:31'),
(8, 2, 'deposit', 'balance', 4136.48, '8', '2023-02-01 12:25:58'),
(9, 2, 'deposit', 'balance', 348.34, '9', '2023-02-02 07:34:18'),
(10, 2, 'deposit', 'balance', 348.35, '10', '2023-02-02 07:45:15'),
(11, 2, 'deposit', 'balance', 348.68, '11', '2023-02-02 08:18:11'),
(12, 2, 'deposit', 'balance', 180.11, '12', '2023-02-02 12:11:04'),
(13, 2, 'deposit', 'balance', 130.16, '13', '2023-02-02 12:12:27'),
(14, 2, 'deposit', 'balance', 180.19, '14', '2023-02-02 12:29:43'),
(15, 2, 'deposit', 'balance', 180.19, '15', '2023-02-02 12:31:27'),
(16, 2, 'deposit', 'balance', 130.21, '16', '2023-02-02 12:43:02'),
(17, 2, 'deposit', 'balance', 180.09, '17', '2023-02-02 12:58:54'),
(18, 2, 'deposit', 'balance', 130.06, '18', '2023-02-02 13:08:27'),
(19, 2, 'deposit', 'balance', 1654.90, '19', '2023-02-03 13:19:03'),
(20, 2, 'deposit', 'balance', 8035.28, '20', '2023-02-07 08:25:43'),
(21, 2, 'deposit', 'balance', 333.50, '21', '2023-02-07 11:37:57'),
(22, 3, 'deposit', 'balance', 1438.80, '22', '2023-02-07 11:57:32'),
(23, 3, 'deposit', 'balance', 667.00, '23', '2023-02-07 12:09:39'),
(24, 3, 'deposit', 'balance', 50000.00, '11727', '2023-03-02 08:51:32'),
(25, 3, 'deposit', 'balance', 50000.00, '11727', '2023-03-02 08:53:14'),
(26, 3, 'deposit', 'balance', 50000.00, '11727', '2023-03-02 08:54:32'),
(27, 3, 'deposit', 'balance', 50000.00, '11727', '2023-03-02 08:54:54'),
(28, 1, 'purchase', 'balance', 100.00, '28', '2023-03-02 11:04:23'),
(29, 2, 'purchase', 'balance', 1963.64, '29', '2023-03-02 11:08:08'),
(30, 1, 'deposit', 'balance', 1000.00, 'asasasasasasasasf', '2023-03-10 10:58:11'),
(31, 1, 'deposit', 'balance', 1000.00, 'asasasasasasasasfiii', '2023-03-10 11:03:47'),
(32, 1, 'deposit', 'balance', 1000.00, 'iiasasasasasasasasfiii', '2023-03-10 11:06:50');

INSERT INTO `tbl_user_wallets` (`id`, `user_id`, `cash_balance`, `commodities`, `staking`, `currency`, `created_at`) VALUES
(2, 1, 7493.60, 0.00, 0.00, 'USD', '2023-01-27 12:03:54'),
(3, 2, 82792.75, 0.00, 0.00, 'USD', '2023-01-27 12:05:29'),
(4, 3, 100000.00, 0.00, 0.00, 'USD', '2023-01-27 12:07:44'),
(5, 4, 0.00, 0.00, 0.00, 'USD', '2023-01-27 12:13:10'),
(6, 5, 0.00, 0.00, 0.00, 'USD', '2023-01-27 12:14:22'),
(7, 6, 0.00, 0.00, 0.00, 'USD', '2023-01-27 12:14:53'),
(8, 7, 0.00, 0.00, 0.00, 'USD', '2023-01-27 12:16:33'),
(9, 8, 0.00, 0.00, 0.00, 'USD', '2023-01-27 12:16:49'),
(10, 9, 500000.00, 0.00, 0.00, 'USD', '2023-01-27 13:24:15'),
(11, 10, 0.00, 0.00, 0.00, 'USD', '2023-01-31 06:50:57'),
(12, 11, 94737.53, 0.00, 0.00, 'USD', '2023-01-31 06:58:13');

INSERT INTO `tbl_users` (`user_id`, `user_type`, `password`, `status`) VALUES
(1, 'user', '$2a$10$WuzZm5bceJbGXMJE8MF2xePmac6a/VYBPI.gdMz/BSnMQE03UImUm', 1),
(2, 'user', '$2a$10$0F0b.stTC5HeclTOm5EgY.Eww2DW3Gb/E1pm38H7wC4X6LUhZ3Fva', 1),
(3, 'user', '$2a$10$bt93PaNtpC4LmjEZLNc92uCw3CId9EHVF36U5GQ99k3mf14N0OFc2', 1),
(4, 'user', '$2a$10$mSn7Wlbe8sF7.L6n2Qs69OvvCf0LpDGkYhFzb.AvCZKoBYTXdx.Ae', 1),
(5, 'user', '$2a$10$xjxn3nAImhAO0oQKRfaqROaq95LYPzp3dCwjI5OoazLYULY/yl/t.', 0),
(6, 'user', '$2a$10$0nijsben8IxbjYTRX.P9iewSh00x4VcVZ67K0nmDektgW57u7JTO2', 0),
(7, 'user', '$2a$10$G6xMqMh0eslFdaAoTeEfqe103ghlMXavbU2PE8rIf3Sn2rl4NFdtm', 0),
(8, 'user', '$2a$10$zAnwThFC4Cf8DAjlZwaXMuXb4KwKlN4wWKNjWNdzfZfbgGd6GduHi', 0),
(9, 'user', '$2a$10$ZNEgsUG7QLWvlcu8zK7oLe3dLkdvOGfrBWCtGz.ZpyUXpTue/.W.m', 1),
(10, 'user', '$2a$10$8WV04ReBNR0zhB01ps5gKOm9qWD3xiJEeNK2z7klnt87/XQoGCOf6', 1),
(11, 'user', '$2a$10$rjC0Rky1WwQv7PfgSfZgb.po0O.8a.DLVWHSiMC6O4VFOW3VBkJ02', 1);



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
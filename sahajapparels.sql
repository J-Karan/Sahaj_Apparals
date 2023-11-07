-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2023 at 07:19 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sahajapparels`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addToCart` (IN `cartPhoneNumber` VARCHAR(15), IN `cartProductCode` INT, OUT `resultMessage` VARCHAR(50))   BEGIN
    DECLARE cartQuantity INT;
    
    -- Check if the combination of Phone Number and ProductCode exists in the Cart
    SELECT Quantity INTO cartQuantity FROM Cart
    WHERE Phone_Number = cartPhoneNumber AND ProductCode = cartProductCode;
    
    -- If the combination exists, increment the quantity by one
    IF cartQuantity IS NOT NULL THEN
        UPDATE Cart
        SET Quantity = cartQuantity + 1
        WHERE Phone_Number = cartPhoneNumber AND ProductCode = cartProductCode;
        SET resultMessage = 'Done';
    ELSE
        -- If the combination doesn't exist, insert a new row with quantity 1
        INSERT INTO Cart (Phone_Number, ProductCode, Quantity)
        VALUES (cartPhoneNumber, cartProductCode, 1);
        SET resultMessage = 'Done';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buy` (IN `phoneNumber` VARCHAR(15), OUT `resultMessage` VARCHAR(50))   BEGIN
    DECLARE rowsAffected INT;

    -- Delete rows from the cart table with the specified phone number
    DELETE FROM cart WHERE Phone_Number = phoneNumber;

    -- Get the number of rows affected by the DELETE operation
    SET rowsAffected = ROW_COUNT();

    -- Check the number of affected rows to determine if the operation was successful
    IF rowsAffected > 0 THEN
        SET resultMessage = 'Done';
    ELSE
        SET resultMessage = 'Not Done';
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RemoveCartItem` (IN `PhoneNumber` VARCHAR(15), IN `Product_Code` INT, OUT `resultMessage` VARCHAR(50))   BEGIN
    DECLARE cartQuantity INT;

    -- Find the quantity of the specified product in the cart
    SELECT Quantity INTO cartQuantity
    FROM Cart
    WHERE Phone_Number = PhoneNumber AND ProductCode = Product_Code;

    -- If the combination exists, update or delete based on quantity
    IF cartQuantity IS NOT NULL THEN
        IF cartQuantity = 1 THEN
            -- If quantity is exactly 1, remove the whole row
            DELETE FROM Cart
            WHERE Phone_Number = PhoneNumber AND ProductCode = Product_Code;
            SET resultMessage = 'Done';
        ELSEIF cartQuantity > 1 THEN
            -- If quantity is greater than 1, decrement it by 1
            UPDATE Cart
            SET Quantity = cartQuantity - 1
            WHERE Phone_Number = PhoneNumber AND ProductCode = Product_Code;
            SET resultMessage = 'Done';
        END IF;
    ELSE
        -- If the combination doesn't exist, indicate it's not done
        SET resultMessage = 'Not Done';
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `Phone_Number` varchar(15) NOT NULL,
  `ProductCode` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`ID`, `name`, `description`) VALUES
(1, 'Men', 'Category for men\'s clothing.'),
(2, 'Women', 'Women Stylish Clothing and Designer Clothing ');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `Phone_Number` varchar(15) NOT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `HashedPassword` varchar(255) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Marital_Status` varchar(50) DEFAULT NULL,
  `Shipping_Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`Phone_Number`, `Email`, `HashedPassword`, `Name`, `Marital_Status`, `Shipping_Address`) VALUES
('7276814051', 'buckshotlol1172@gmail.com', '$argon2id$v=19$m=15360,t=2,p=1$gG50AHRFWosWFO7iYUxexrTcez5D5Hz2amAA44n16aZW4W2OkWgljME52rIeiD7szSf0ePmedLjz4IejTN9niQ$1Se2r3MPAwl7NXpDj7D0ZeDwIK0YJkrW0EOIHzvsYXY', 'Karan Jain', 'Single', 'Sr No:84,C2-6,Manik Moti Complex, More Baug, Katraj, Pune - 46');

-- --------------------------------------------------------

--
-- Table structure for table `productinventory`
--

CREATE TABLE `productinventory` (
  `ProductCode` int(11) DEFAULT NULL,
  `ImageURL` varchar(255) NOT NULL,
  `Size` varchar(10) DEFAULT NULL,
  `Color` varchar(20) DEFAULT NULL,
  `InventoryQuantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `productinventory`
--

INSERT INTO `productinventory` (`ProductCode`, `ImageURL`, `Size`, `Color`, `InventoryQuantity`) VALUES
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/R4fd/6525266eddf77915192fb557/-1117Wx1400H-466691165-offwhite-MODEL.jpg', 'S', 'White', 15),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/R4fd/6525266eddf77915192fb557/-1117Wx1400H-466691165-offwhite-MODEL.jpg', 'M', 'White', 11),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/R4fd/6525266eddf77915192fb557/-1117Wx1400H-466691165-offwhite-MODEL.jpg', 'L', 'White', 9),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/R4fd/6525266eddf77915192fb557/-1117Wx1400H-466691165-offwhite-MODEL.jpg', 'XL', 'White', 13),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/FEPI/65252605ddf77915192fa7ea/-1117Wx1400H-466691165-blue-MODEL.jpg', 'M', 'Blue', 35),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/FEPI/65252605ddf77915192fa7ea/-1117Wx1400H-466691165-blue-MODEL.jpg', 'L', 'Blue', 45),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/FEPI/65252605ddf77915192fa7ea/-1117Wx1400H-466691165-blue-MODEL.jpg', 'XL', 'Blue', 30),
(1, 'https://assets.ajio.com/medias/sys_master/root/20231010/FEPI/65252605ddf77915192fa7ea/-1117Wx1400H-466691165-blue-MODEL.jpg', 'S', 'Blue', 20),
(2, 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', 'S', 'White', 2),
(2, 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', 'M', 'White', 3),
(2, 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', 'L', 'White', 4),
(2, 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', 'XL', 'White', 5),
(2, 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', 'XXL', 'White', 2),
(3, 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', 'S', 'Cream', 26),
(3, 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', 'L', 'Cream', 34),
(3, 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', 'XL', 'Cream', 29),
(3, 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', 'X', 'Cream', 0),
(3, 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', 'XXL', 'Cream', 0);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductCode` int(11) NOT NULL,
  `ProductName` varchar(255) NOT NULL,
  `ImageURL` varchar(255) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Rating` int(11) NOT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `ProductDescription` text DEFAULT NULL,
  `Brand` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductCode`, `ProductName`, `ImageURL`, `Price`, `Rating`, `CategoryID`, `ProductDescription`, `Brand`) VALUES
(1, 'Men Relaxed Fit Shirt with Short Sleeves', 'https://assets.ajio.com/medias/sys_master/root/20231010/R4fd/6525266eddf77915192fb557/-1117Wx1400H-466691165-offwhite-MODEL.jpg', '380.00', 4, 1, 'Elevate your casual look with our Men\'s Relaxed Fit Shirt with Short Sleeves. Designed for both comfort and style, it\'s the perfect choice for any occasion. Stay relaxed and effortlessly chic with this versatile wardrobe essential.', 'UrbanStyle'),
(2, 'Spread Collared Checked Shirt', 'https://assets.ajio.com/medias/sys_master/root/20230808/9x9d/64d2474aeebac147fcb45a7b/-1117Wx1400H-466434087-white-MODEL.jpg', '384.00', 5, 1, 'The Spread Collared Checked Shirt is a versatile and stylish addition to your wardrobe. With its classic checkered pattern and comfortable fit, it\'s perfect for both casual and semi-formal occasions. Whether you\'re dressing up or down, this shirt offers a timeless and sophisticated look that never goes out of style.', 'FashionForward'),
(3, 'Men Printed Regular Fit Shirt with Patch Pocket', 'https://assets.ajio.com/medias/sys_master/root/20231012/HdPl/65281deaddf779151937f8a1/-1117Wx1400H-466701367-cream-MODEL.jpg', '400.00', 4, 1, 'The Men Printed Regular Fit Shirt with Patch Pocket is a fashion-forward choice for modern gentlemen. Its contemporary design features an eye-catching print and a practical patch pocket. With a comfortable regular fit, this shirt combines style and functionality, making it a versatile addition to any wardrobe', 'TrendyThreads'),
(4, 'Men Leaf Printed Regular Fit Shirt', 'https://assets.ajio.com/medias/sys_master/root/20230603/5uHj/647a6c0c42f9e729d720af4c/-1117Wx1400H-466232790-cream-MODEL.jpg', '500.00', 3, 1, 'The Men Leaf Printed Regular Fit Shirt offers a unique and stylish look with its leaf-printed design. It provides a comfortable regular fit, making it a great choice for both casual and semi-formal occasions. This shirt is a perfect blend of fashion and comfort, adding a touch of nature-inspired elegance to your wardrobe', 'NatureWear'),
(5, 'LookMark Men\'s Cotton Blend Printed Stitched Half Sleeve Shirt', 'https://m.media-amazon.com/images/I/51zkKVzqlcL.jpg', '269.00', 4, 1, 'The LookMark Men\'s Cotton Blend Printed Stitched Half Sleeve Shirt combines comfort and style in one package. With its trendy printed design, this shirt is a versatile addition to your wardrobe, ideal for casual outings and everyday wear. Its half sleeves provide a relaxed look, making it a great choice for staying cool and fashionable.', 'CasualElegance'),
(6, 'LookMark Men\'s Poly Cotton Digital Printed Half Sleeve Shirt', 'https://m.media-amazon.com/images/I/618mePDIfML._UY879_.jpg', '288.00', 2, 1, 'The LookMark Men\'s Poly Cotton Digital Printed Half Sleeve Shirt is a contemporary choice for the fashion-forward individual. Its digital print design adds a modern touch to your outfit, making it suitable for various occasions. With half sleeves, it offers a relaxed and stylish look, perfect for staying comfortable and on-trend.', 'ContemporaryTrends'),
(7, 'Men Mid-Rise Cotton Cargo Trousers', 'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/23934126/2023/7/8/70980ceb-9768-452a-b188-c0f3001d7be71688808524788ReslagMenSilver-TonedCargosTrousers1.jpg', '1229.00', 3, 1, 'Men\'s Mid-Rise Cotton Cargo Trousers are a practical and versatile addition to your wardrobe. These trousers offer a comfortable mid-rise fit and come with multiple cargo pockets for added utility. Whether for outdoor activities or casual urban wear, they provide both style and functionality, making them a go-to choice for everyday adventures.', 'OutdoorEssentials'),
(8, 'Men Khaki Tapered Fit Chinos', 'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/2290043/2018/2/7/11517998932648-HIGHLANDER-Men-Khaki-Tapered-Fit-Solid-Chinos-8701517998932466-2.jpg', '712.00', 4, 1, 'Highlander Men Khaki Tapered Fit Chinos offer a blend of style and comfort. With their khaki color and tapered fit, they provide a fashionable and modern look. These chinos are a versatile choice for various occasions, ensuring you look sharp and feel comfortable throughout the day.', 'ModernComfort'),
(9, 'The Life Co. Men Chinos Trousers', 'https://assets.myntassets.com/h_1440,q_90,w_1080/v1/assets/images/21773614/2023/6/7/b10fa967-92ac-47f3-8cea-1f312beac0501686122919907-Roadster-Men-Trousers-1881686122919353-2.jpg', '407.00', 5, 1, 'The Life Co. Men Chinos Trousers offer a timeless and classic addition to your wardrobe. With their versatile design and comfortable fit, these chinos are suitable for a wide range of occasions, from casual outings to semi-formal events. Elevate your style with these chinos, providing a smart and polished look for any setting.', 'ClassicChoices'),
(10, 'Typographic Print Slim Fit Hooded T-Shirt with Flap Pocket', 'https://assets.ajio.com/medias/sys_master/root/20230628/ythN/649b67c6eebac147fc132488/-1117Wx1400H-465647923-black-MODEL.jpg', '425.00', 4, 1, 'The Typographic Print Slim Fit Hooded T-Shirt with Flap Pocket combines style and functionality. Its unique typographic print and slim fit offer a trendy and contemporary look, while the hood and flap pocket add practical elements to the design. This t-shirt is the perfect choice for those seeking a fashionable and versatile addition to their casual wardrobe.', 'StreetStyle'),
(11, 'Floral Print A-line Kurta', 'https://assets.ajio.com/medias/sys_master/root/20230621/LzLq/6492de3dd55b7d0c639a670a/-1117Wx1400H-464342145-blue-MODEL.jpg', '560.00', 3, 2, 'The Floral Print A-line Kurta is a chic and feminine choice for any occasion. Its A-line silhouette, adorned with a delightful floral print, exudes elegance and grace. This kurta is perfect for adding a touch of sophistication and style to your outfit, making it ideal for both casual and formal settings.', 'ElegantEssence'),
(12, 'Printed Flared Kurta', 'https://assets.ajio.com/medias/sys_master/root/20230306/Wzkj/6405dc7ff997dde6f4de49e4/-1117Wx1400H-465859265-lime-MODEL2.jpg', '999.00', 4, 2, 'The Printed Flared Kurta is a stylish and fashionable addition to your ethnic wear collection. Its flared design and captivating print create a graceful and trendy look, perfect for a variety of occasions. This kurta offers a combination of comfort and style, making it an excellent choice for those who want to make a statement with their traditional attire.', 'ChicStyles'),
(13, 'Floral Print Round-Neck Flared Kurta', 'https://assets.ajio.com/medias/sys_master/root/20230624/34lo/6496a0eba9b42d15c9e429dd/-1117Wx1400H-465557426-indigo-MODEL.jpg', '999.00', 1, 2, 'The Floral Print Round-Neck Flared Kurta is a charming and elegant piece for your ethnic wardrobe. With its flared silhouette and delightful floral print, it offers a graceful and feminine look. This kurta is designed to make you stand out at special occasions, providing a blend of comfort and style.', 'TimelessFashion'),
(14, 'Striped Straight Kurta', 'https://assets.ajio.com/medias/sys_master/root/20230624/XXjC/649695cfa9b42d15c9e2dad5/-1117Wx1400H-465453046-purple-MODEL.jpg', '665.00', 3, 2, 'The Striped Straight Kurta is a classic and versatile addition to your ethnic wear collection. With its straight-cut design and timeless striped pattern, it exudes a simple yet elegant look. This kurta is suitable for various occasions, offering a blend of sophistication and comfort for a classic appearance.', 'VersatileWardrobe');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`Phone_Number`,`ProductCode`),
  ADD KEY `ProductCode` (`ProductCode`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`Phone_Number`);

--
-- Indexes for table `productinventory`
--
ALTER TABLE `productinventory`
  ADD KEY `ProductCode` (`ProductCode`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductCode`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `ProductCode` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`Phone_Number`) REFERENCES `customers` (`Phone_Number`),
  ADD CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`ProductCode`) REFERENCES `products` (`ProductCode`);

--
-- Constraints for table `productinventory`
--
ALTER TABLE `productinventory`
  ADD CONSTRAINT `productinventory_ibfk_1` FOREIGN KEY (`ProductCode`) REFERENCES `products` (`ProductCode`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css" />
    <script src="https://kit.fontawesome.com/0e53af926d.js" crossorigin="anonymous"></script>
    <title>Shopping Cart</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .cart-item {
            display: flex;
            margin: 20px 0;
            background-color: #fff;
            border-radius: 5px;
            padding: 10px;
        }

        .product-image {
            flex: 1;
        }

        .product-image img {
            max-width: 100%;
            height: auto;
        }

        .product-details {
            flex: 2;
            padding: 10px;
        }

        .product-title {
            font-size: 18px;
            font-weight: bold;
            margin: 0;
        }

        .product-price {
            font-size: 16px;
        }

        .product-quantity {
            font-size: 16px;
            margin: 10px 0;
        }

        .product-actions {
            flex: 1;
            text-align: center;
        }

        .product-actions button {
            background-color: #e74c3c;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .product-actions button:hover {
            background-color: #c0392b;
        }

        h1 {
            margin-top: 80px;
            text-align: center;
            background-color: rgb(206, 172, 149);
            color: white;
        }

        .checkout-button {
            text-align: center;
            margin-top: 20px;
        }

        .checkout-button button {
            background-color: #3498db;
            color: #fff;
            border: none;
            padding: 15px 30px;
            border-radius: 5px;
            cursor: pointer;
        }

        .checkout-button button:hover {
            background-color: #2980b9;
        }

        .cart-container {
            display: flex;
        }

        .cart-products {
            flex: 2;
            padding: 10px;
        }

        .cart-summary {
            flex: 1;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
        }

        .order-summary {
            text-align: left;
        }

        .order-summary h2 {
            font-size: 28px;
            font-weight: bold;
        }

        .order-summary ul {
            list-style: none;
            padding: 0;
        }

        .order-summary li {
            font-size: 16px;
            margin-bottom: 5px;
        }

        .total {
            text-align: right;
            margin-top: 22px;
        }
    </style>
</head>

<body>
    <header>
        <div id="header">
            <div class="header-logo">
                <div style="float: left;"><a href="index.html"><img class="imglogo"
                            src="C:\Users\rajka\Downloads\Sahaj Apperals\Sahaj Apperals\images\logo1.png"
                            alt="Sahaj Apparels"></a></div>
                <div style="float: right; margin-top: 30px;"><a href="index.html">Sahaj Apperals</a></div>
            </div>
            <div class="header-list">
                <nav class="header-list-nav">
                    <ul>
                        <li>
                            <a class="categories">Categories</a>
                            <ul class="sub-menu">
                                <li><a href="#">Men</a></li>
                                <li><a href="#">Women</a></li>
                                <li><a href="#">Kids</a></li>
                            </ul>
                        </li>
                        <li><a class="active" href="index.html">Home</a></li>
                        <li><a href="products.html">Shop</a></li>
                        <li><a href="about.html">About</a></li>
                        <li><a href="login.html">Login</a></li>
                        <li><a href="signup.html">SignUp</a></li>
                        <li><a href="logout.html">Logout</a></li>
                    </ul>
                </nav>
                <div class="header-list-icon">
                    <a href=""><i class="fa fa-bag-shopping"></i></a>
                </div>
            </div>
        </div>
    </header>

    <h1>Your Shopping Cart</h1>
    <div class="container">
        <div class="cart-container">
            <div class="cart-products">
                <div class="cart-item">
                    <div class="product-image">
                        <img src="C:\Users\rajka\Downloads\Sahaj Apperals\Sahaj Apperals\Sahaj Apperals\images\products\f1.jpg"
                            alt="Product 1">
                    </div>
                    <div class="product-details">
                        <h2 class="product-title">Product Title 1</h2>
                        <p class="product-price">$19.99</p>
                        <p class="product-quantity">Quantity: 2</p>
                    </div>
                    <div class="product-actions">
                        <button style="margin-top: 30px;">Remove</button><br>
                        <button style="margin-top: 30px; background-color: #3498db;">Buy Now</button>
                    </div>
                </div>
                <div class="cart-item">
                    <div class="product-image">
                        <img src="C:\Users\rajka\Downloads\Sahaj Apperals\Sahaj Apperals\Sahaj Apperals\images\products\f7.jpg"
                            alt="Product 1">
                    </div>
                    <div class="product-details">
                        <h2 class="product-title">Product Title 2</h2>
                        <p class="product-price">$29.99</p>
                        <p class="product-quantity">Quantity: 1</p>
                    </div>
                    <div class="product-actions">
                        <button style="margin-top: 30px;">Remove</button><br>
                        <button style="margin-top: 30px; background-color: #3498db;">Buy Now</button>
                    </div>
                </div>
            </div>
            <!-- Right side: Summary of orders and total -->
            <div class="cart-summary" style="margin-top: 29px;">
                <!-- Display a summary of orders here -->
                <div class="order-summary">
                    <h2>Order Summary</h2>
                    <ul>
                        <li>Product 1:</li>
                        <li>Product 2:</li>
                        <!-- Add similar entries for other products -->
                    </ul>
                </div>
                <hr>
                <div class="total">
                    <p style="text-decoration: underline;">Total: </p> <!-- Calculate the total and display it here -->
                </div>
                <div class="checkout-button">
                    <button>Proceed to Buy</button>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
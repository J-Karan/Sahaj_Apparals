<%@ page import="products_data.ProductDAO" %>
<%@ page import="products_data.CartItem" %>
<%@ page import="java.util.ArrayList" %>


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
        <%@ include file="navbar.jsp" %>

        <h1>Your Shopping Cart</h1>
        <div class="container">
            <div class="cart-container">
                <div class="cart-products">
                    <%
                        String Number = (String) session.getAttribute("user");
                        List<CartItem> cartItems = new ArrayList<>(); // Initialize cartItems
                        double totalAmount = 0;
                        if (Number != null) {
                            cartItems = new ProductDAO().getCart(Number);
                            for (CartItem cart : cartItems) {
                    %>
                    <div class="cart-item">
                        <div class="product-image">
                            <img src="<%= cart.getProductURL() %>" alt="<%= cart.getProductTitle() %>">
                        </div>
                        <div class="product-details">
                            <h2 class="product-title"><%= cart.getProductTitle() %></h2>
                            <p class="product-price">$<%= cart.getProductPrice() %></p>
                            <p class="product-quantity">Quantity: <%= cart.getQuantity() %></p>
                            <p><%= cart.getDesc() %></p>
                        </div>
                        <div class="product-actions">
                            <button style="margin-top: 30px;">Remove</button><br>
                        </div>
                    </div>
                    <%
                            totalAmount += (cart.getQuantity() * cart.getProductPrice());
                        }
                    } else {
                        request.setAttribute("Message", "login Please");
                        request.setAttribute("indication", false);
                        request.setAttribute("redirectURL", "Login.jsp");
                        RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                        dispatcher.forward(request, response);
                    }
                    %>
                </div>
                <div class="cart-summary" style="margin-top: 29px;">
                    <!-- Display a summary of orders here -->
                    <div class="order-summary">
                        <h2>Order Summary</h2>
                        <ul>
                            <%
                                for (CartItem cart : cartItems) {
                            %>
                            <li><%= cart.getProductTitle() %>: $<%= cart.getProductPrice() %></li>
                                <%
                                    }
                                %>
                        </ul>
                    </div>
                    <hr>
                    <div class="total">
                        <p style="text-decoration: underline;">Total: $<%= totalAmount %></p>
                    </div>
                    <div class="checkout-button">
                        <button>Proceed to Buy</button>
                    </div>
                </div>
            </div>
        </div>
    </body>

</html>

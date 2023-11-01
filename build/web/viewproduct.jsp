<%@ page import="products_data.Product" %>
<%@ page import="products_data.ProductDAO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Object user = session.getAttribute("user");
    String currentURL = request.getRequestURL().toString() + "?productCode=" + request.getParameter("productCode");
    String trimmedURL = currentURL.replace("http://localhost:8080/Sahaj_Apperals/", "");
    String redirect = "Login.jsp?redirectTo="+trimmedURL;
    
    if (user != null) {
        redirect = "addToCart?productCode=" + request.getParameter("productCode");
    }
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Single Product</title>
        <link rel="stylesheet" href="style.css" />
        <link rel="stylesheet" href="singprod.css" />

        <script src="https://kit.fontawesome.com/0e53af926d.js" crossorigin="anonymous"></script>
        <style>
            body {
                background-color: rgb(248, 241, 236);
                ;
                font-family: Arial, sans-serif;
                margin: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }

            .product-container {
                background-color: white;
                display: flex;
                align-items: center;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 20px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                margin-top: 70px;
                height: 80%;
                width: 90%;
                max-width: 900px;
            }

            .product-image {
                flex: 1;
                margin-right: 20px;
                max-width: 40%;
                height: auto;
            }

            .product-details {
                flex: 1;
            }

            .product-title {
                font-size: 24px;
                font-weight: bold;
                margin: 0;
                margin-bottom: 10px;
            }

            .product-color-size {
                margin-top: 10px;
            }

            .color-options label {
                display: inline-block;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                margin-right: 10px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .color-icon.blue {
                background-color: blue;
            }

            .color-icon.red {
                background-color: red;
            }

            .color-icon.green {
                background-color: green;
            }

            .color-options label.selected {

                color: #fff;
            }

            .size-options {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            .size-options label {
                display: inline-block;
                background-color: #f4f4f4;
                padding: 10px 15px;
                border-radius: 5px;
                margin-right: 10px;
                cursor: pointer;
                font-weight: bold;
                user-select: none;
                transition: background-color 0.3s;
            }

            .size-options label.selected {
                background-color: rgb(215, 192, 176);
                color: #fff;
            }

            .product-button {
                margin-top: 20px;
                background-color: rgb(215, 192, 176);
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 18px;
                transition: background-color 0.3s;
            }

            .product-button:hover {
                background-color: #d0a181;
            }
        </style>
    </head>
    <body>
        <jsp:include page="navbar.jsp" />

        <div class="product-container">
            <%
                int productCodeToSearch = Integer.valueOf(request.getParameter("productCode")); 
                ProductDAO productDAO = new ProductDAO();
                Product product = productDAO.getProductDetails(productCodeToSearch);

                if (product != null) {
            %>
            <img class="product-image" src="<%= product.getImageURL() %>" alt="Product Image">
            <div class="product-details">
                <h1 class="product-title"><%= product.getName() %></h1>
                <p class="product-info"><%= product.getDescription() %></p>
                <div class="product-color-size">

                    <label>Size:</label>
                    <div class="size-options">
                        <label class="selected">S</label>
                        <label>M</label>
                        <label>L</label>
                        <label>XL</label>
                    </div>
                </div>
                <a href=<%= redirect %>><button class="product-button">Add to Cart</button>
            </div>
            <%
                } else {
            %>
            <p>Product not found.</p>
            <%
                }
            %>
        </div>
        <script>
            // JavaScript to handle the color and size selection
            const colorOptions = document.querySelectorAll('.color-options label');
            const sizeOptions = document.querySelectorAll('.size-options label');

            colorOptions.forEach((option) => {
                option.addEventListener('click', () => {
                    colorOptions.forEach((otherOption) => {
                        otherOption.classList.remove('selected');
                    });
                    option.classList.add('selected');
                });
            });

            sizeOptions.forEach((option) => {
                option.addEventListener('click', () => {
                    sizeOptions.forEach((otherOption) => {
                        otherOption.classList.remove('selected');
                    });
                    option.classList.add('selected');
                });
            });
        </script>
    </body>
</html>

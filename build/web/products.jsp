<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="products_data.Product" %>
<%@ page import="products_data.ProductDAO" %>
<%@ page import="java.util.Iterator" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Products - Sahaj Apperals</title>
        <link rel="stylesheet" href="style.css" />
        <script src="https://kit.fontawesome.com/0e53af926d.js" crossorigin="anonymous"></script>
        <style>

        </style>
    </head>

    <body>

        <jsp:include page="navbar.jsp" />

        <section class="product-section" class="section-p1" style="margin-top: 90px;">

            <div class="pro-collection">

                <%
                        Integer categoryId = null;

                        String categoryIdString = request.getParameter("categoryId");

                        if (categoryIdString != null && !categoryIdString.isEmpty()) {
                            try {
                                categoryId = Integer.valueOf(categoryIdString);
                            } catch (NumberFormatException e) {
                                categoryId = null;
                            }
                        } else {
                            categoryId = null;
                        }

                        List<Product> productList = new ProductDAO().populate(0, categoryId);
                        Iterator<Product> iterator = productList.iterator();

                        while (iterator.hasNext()) {
                            Product product = iterator.next();
                %>
                <a href="viewproduct.jsp?productCode=<%= product.getProductCode() %>" style="text-decoration: none;">
                    <div class="product-cart">
                        <img src="<%= product.getImageURL() %>" alt="product image" />
                        <span><%= product.getBrand() %></span>
                        <h4><%= product.getName() %></h4>
                        <div class="stars">
                            <% for (int i = 0; i < product.getRating(); i++) { %>
                            <i class="fa-solid fa-star"></i>
                            <% } %>
                        </div>
                        <h4 class="price">$<%= String.format("%.2f", product.getPrice()*0.012) %></h4>
                    </div>
                </a>
                <%
                    iterator.remove();
                }
                %>
            </div>
            <footer>
                <div id="footer">
                    <div class="contact">
                        <a href="index.html" class="footer_logo">Sahaj Apperals</a>
                        <br> <br>
                        <br>
                        <h3>Contact</h3>
                        <address>
                            <p><b>Address:</b> Plot No 24, oasis Complex</p>
                            <p><b>Phone:</b> Vidyavihar, Mumbai - 400086</p>
                            <p><b>Hours</b> 10:00 - 18:00. Mon - Sat</p>
                        </address>
                        <h3>Follow Us</h3>
                        <br>
                        <div class="socials">
                            <a href="#"><i class="fa-brands fa-facebook-square"></i></a>
                            <a href="#"><i class="fa-brands fa-youtube"></i></a>
                            <a href="#"><i class="fa-brands fa-telegram"></i></a>
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-twitter"></i></a>
                        </div>
                    </div>
                    <div class="about">
                        <h3>About</h3>
                        <br>
                        <a href="#">About Us</a>
                        <a href="#">Delivery Information</a>
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms & Conditions</a>
                        <a href="#">Contact Us</a>
                    </div>
                    <div class="myaccount ">
                        <h3>My account</h3>
                        <br>
                        <a href="#">Sign In</a>
                        <a href="#">View Cart</a>
                        <a href="#">My Wishlist</a>
                        <a href="#">Track My Order</a>
                        <a href="#">Help</a>
                    </div>
                    <div class="install">
                        <h3>Install App</h3>
                        <br>
                        <p>From App Store or Google Play</p>
                        <div class="download">
                            <a href="#"><img src="images/pay/app.jpg" alt=""></a>
                            <a href="#"><img src="images/pay/play.jpg" alt=""></a>
                        </div>
                        <p>Secured Payment Gateways</p>
                        <img src="images/pay/pay.png" alt="">
                    </div>

                </div>
            </footer>
            <script src="script.js"></script>
    </body>

</html>
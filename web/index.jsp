<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="products_data.Product" %>
<%@ page import="products_data.ProductDAO" %>
<%@ page import="java.util.Iterator" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Sahaj Apperals</title>
        <link rel="stylesheet" href="style.css" />
        <script src="https://kit.fontawesome.com/0e53af926d.js" crossorigin="anonymous"></script>
    </head>

    <body>
        <jsp:include page="navbar.jsp" />

        <!--main section-->

        <main>
            <section id="hero" class="background-animation">
                <h4>Trade-in-offer</h4>
                <h2>Super value deals</h2>
                <h1>On all products</h1>
                <p>save more coupons & up to 70% off!</p>
                <a href="products.jsp"><button>Shop now</button></a>
            </section>

            <section id="features" class="section-p1">
                <div class="f-box">
                    <img src="https://i.ibb.co/Zc5ZmKd/f1.png" alt="free shipping" />
                    <h6>Free shipping</h6>
                </div>
                <div class="f-box">
                    <img src="https://i.ibb.co/7p0WRHy/f2.png" alt="online order" />
                    <h6>online order</h6>
                </div>
                <div class="f-box">
                    <img src="https://i.ibb.co/r2vVhrF/f3.png" alt="save money" />
                    <h6>save money</h6>
                </div>
                <div class="f-box">
                    <img src="https://i.ibb.co/h2vL3BH/f4.png" alt="promotions" />
                    <h6>promotions</h6>
                </div>
                <div class="f-box">
                    <img src="https://i.ibb.co/vLbbXn5/f5.png" alt="happy sell" />
                    <h6>happy sell</h6>
                </div>
                <div class="f-box">
                    <img src="https://i.ibb.co/1bMrmGJ/f6.png" alt="24/7 support" />
                    <h6>24/7 support</h6>
                </div>
            </section>

            <section class="product-section" class="section-p1">
                <h1>Featured Products</h1>
                <p>New Modern Design Collection</p>
                <div class="pro-collection">

                    <%
                        List<Product> productList = new ProductDAO().populate(14,null);
                        Iterator<Product> iterator = productList.iterator();
                        int productsUsed = 0;

                        while (iterator.hasNext() && productsUsed < 7) {
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
                        productsUsed++;
                        iterator.remove();
                    }
                    %>

                </div>
            </section>

            <section id="off-banner" class="section-m1">
                <h4>Repaire Services</h4>
                <h2>Up to 70% Off - All t-Shirts & Accessories</h2>
                <button class="normal">Explore More</button>
            </section>

            <section class="product-section" class="section-p1">
                <h1>New Arrivals</h1>
                <p>New Designer Collection</p>
                <div class="pro-collection">

                    <%
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
                            <a href="#"><i class="fa-solid fa-cart-shopping buy-icon"></i></a>
                        </div>
                    </a>    
                    <%
                        iterator.remove();
                    }
                    %>

                </div>
            </section>

            <section id="banners" class="section-p1">
                <div class="big-banners">
                    <div class="big-banners-1">
                        <h4>crazy deals</h4>
                        <h2>buy 1 get 1 free</h2>
                        <span>The best classic dress is on sale at coro</span>
                        <button class="banner-btn">Learn More</button>
                    </div>
                    <div class="big-banners-2">
                        <h4>spring/summer</h4>
                        <h2>Up Coming season</h2>
                        <span>The best classic dress is on sale at cara</span>
                        <button class="banner-btn">Collection</button>
                    </div>
                </div>

            </section>

            <section id="newsletter">
                <div class="newsletter-text">
                    <h3>Sign Up For Newsletters</h3>
                    <h5>get e-mail updates about out latest shop and <span>special offers</span></h5>
                </div>
                <div class="form">
                    <input type="email" placeholder="Your email address" id="email-address-input">
                    <button>Sign Up</button>
                </div>
            </section>

        </main>

        <!--footer section-->

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
                    <a href="#">My Wish List</a>
                    <a href="#">Track My Order</a>
                    <a href="#">Help</a>
                </div>
                <div class="install">
                    <h3>Install App</h3>
                    <br>
                    <p>From App Store or Google Play</p>
                    <div class="download">
                        <a href="#"><img src="https://i.ibb.co/dbbn9NN/app.jpg" alt=""></a>
                        <a href="#"><img src="https://i.ibb.co/MBDBQB0/play.jpg" alt=""></a>
                    </div>
                    <p>Secured Payment Gateways</p>
                    <img src="https://i.ibb.co/BwJ2qnY/pay.png" alt="">
                </div>

            </div>
        </footer>

        <script src="script.js"></script>
    </body>

</html>
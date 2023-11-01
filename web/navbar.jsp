<%@ page import="java.util.List" %>
<%@ page import="products_data.Product" %>
<%@ page import="products_data.ProductDAO" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<header>
    <div id="header">
        <div class="header-logo">
            <div style="float: left;">
                <a href="index.jsp">
                    <img class="imglogo" src="https://i.ibb.co/yYd4MWg/Logo.png" alt="Sahaj Apparels">
                </a>
            </div>
            <div style="float: right; margin-top: 30px;">
                <a href="index.jsp">Sahaj Apperals</a>
            </div>
        </div>
        <div class="header-list">
            <nav class="header-list-nav">
                <ul>
                    <li>
                        <a class="categories">Categories</a>
                        <ul class="sub-menu">
                            <%
                                List<Map<Integer, String>> categories = new ProductDAO().getCategories();
                                for (Map<Integer, String> category : categories) {
                                    int categoryId = category.keySet().iterator().next();
                                    String categoryName = category.get(categoryId);
                            %>
                            <li><a href="products.jsp?categoryId=<%= categoryId %>"><%= categoryName %></a></li>
                                <%
                                }
                                %>


                        </ul>
                    </li>
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="products.jsp">Shop</a></li>

                    <%
                        Object user = session.getAttribute("user");
                        if (user == null) {
                    %>
                    <li><a href="Login.jsp">Login & SignUp</a></li>
                        <%
                            } else {
                        %>
                    <li><a href="Logout" >Logout</a></li>
                        <%
                            }
                        %>

                </ul>
            </nav>
            <div class="header-list-icon">
                <a href="<%
                    if (user == null) {
                   %>Login.jsp<%
                    } else {
                   %>Cart.jsp<%
                    }
                   %>">
                    <i class="fa fa-bag-shopping"></i>
                </a>
            </div>
        </div>
    </div>
</header>

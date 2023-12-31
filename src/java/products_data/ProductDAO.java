package products_data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map; 

public class ProductDAO {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/sahajapparels";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public List<Product> populate() {
        return populate(-1, null);
    }

    public List<Product> populate(int limit, Integer categoryId) {
        List<Product> productList = new ArrayList<>();
        Connection connection = null;

        try {
            connection = getConnection();
            String sql = "SELECT * FROM products";
            if (categoryId != null) {
                sql += " WHERE CategoryID = ?";
            }
            if (limit > 0) {
                sql += " LIMIT ?";
            }
            PreparedStatement statement = connection.prepareStatement(sql);

            if (categoryId != null) {
                statement.setInt(1, categoryId);
            }
            if (limit > 0) {
                if (categoryId != null) {
                    statement.setInt(2, limit);
                } else {
                    statement.setInt(1, limit);
                }
            }

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Integer productCode = resultSet.getInt("ProductCode");
                String name = resultSet.getString("ProductName");
                Double price = resultSet.getDouble("Price");
                String imageURL = resultSet.getString("ImageURL");
                String description = resultSet.getString("ProductDescription");
                Integer rating = resultSet.getInt("Rating");
                String brand = resultSet.getString("Brand");

                Product product = new Product(productCode, name, brand, price, imageURL, description, rating);
                productList.add(product);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.toString());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }
        }
        Collections.shuffle(productList);
        return productList;
    }

    public List<Map<Integer, String>> getCategories() {
        List<Map<Integer, String>> categoryList = new ArrayList<>();
        Connection connection = null;

        try {
            connection = getConnection();
            String sql = "SELECT ID, name FROM category";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int categoryId = resultSet.getInt("ID");
                String categoryName = resultSet.getString("name");

                Map<Integer, String> categoryPair = new HashMap<>();
                categoryPair.put(categoryId, categoryName);
                categoryList.add(categoryPair);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.toString());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }
        }
        return categoryList;
    }

    public Product getProductDetails(int productCode) {
        Product product = null;
        Connection connection = null;

        try {
            connection = getConnection();
            String sql = "SELECT * FROM products WHERE ProductCode = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, productCode);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("ProductName");
                String brand = resultSet.getString("Brand");
                Double price = resultSet.getDouble("Price");
                String imageURL = resultSet.getString("ImageURL");
                String description = resultSet.getString("ProductDescription");
                Integer rating = resultSet.getInt("Rating");

                product = new Product(productCode, name, brand, price, imageURL, description, rating);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.toString());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }
        }

        return product;
    }

    public List<CartItem> getCart(String phoneNumber) {
        List<CartItem> cartItems = new ArrayList<>();
        Connection connection = null;

        try {
            connection = getConnection();
            String sql = "SELECT cart.ProductCode , ProductDescription , ProductName, ImageURL, Price, Quantity FROM cart, products WHERE Phone_Number = ? AND products.ProductCode = cart.ProductCode";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, phoneNumber);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String productName = resultSet.getString("ProductName");
                String productURL = resultSet.getString("ImageURL");
                String productDescription = resultSet.getString("ProductDescription");
                int quantity = resultSet.getInt("Quantity");
                Double price = resultSet.getDouble("Price");
                int productCode=resultSet.getInt("ProductCode");

                CartItem cart = new CartItem(productName, productURL, quantity, price,productDescription,productCode);
                cartItems.add(cart);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.toString());
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
            }
        }

        return cartItems;
    }

}

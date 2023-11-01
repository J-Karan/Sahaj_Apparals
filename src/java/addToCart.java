
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

@WebServlet("/addToCart")
public class addToCart extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object user = session.getAttribute("user");

        if (user == null) {
            // Handle the case where the user is not logged in
            response.sendRedirect("Login.jsp");
            return;
        }

        String phoneNumber = (String) user; // Assuming the user is stored as a String in the session
        String productCode = request.getParameter("productCode");

        // Ensure that productCode is not null and is a valid number
        if (productCode != null && !productCode.isEmpty()) {
            int productCodeInt = Integer.parseInt(productCode);

            final String JDBC_URL = "jdbc:mysql://localhost:3306/sahajapparels";
            final String DB_USER = "root";
            final String DB_PASSWORD = "";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

                // Prepare the callable statement for the addToCart procedure
                String addToCartProcedure = "{call addToCart(?, ?, ?)}";  // Note the addition of the third parameter
                CallableStatement callableStatement = conn.prepareCall(addToCartProcedure);
                callableStatement.setString(1, phoneNumber);
                callableStatement.setInt(2, productCodeInt);
                callableStatement.registerOutParameter(3, java.sql.Types.VARCHAR); // Register the OUT parameter

                // Execute the procedure
                callableStatement.execute();

                String resultMessage = callableStatement.getString(3);

                conn.close();

                if ("Done".equals(resultMessage)) {
                    request.setAttribute("Message", "Added successful");
                    request.setAttribute("indication", true);
                    request.setAttribute("redirectURL", "Cart.jsp");
                } else {
                    request.setAttribute("Message", "Adding to Cart Unsuccessful");
                    request.setAttribute("indication", false);
                    request.setAttribute("redirectURL", "viewproducts.jsp?productCode=" + productCode);
                }

                RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                dispatcher.forward(request, response);
            } catch (ServletException | IOException | ClassNotFoundException | SQLException e) {
                // Handle database connection or query execution errors here
                request.setAttribute("Message", e.toString());
                request.setAttribute("indication", false);
                request.setAttribute("redirectURL", "viewproducts.jsp?productCode=" + productCode);
                RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            request.setAttribute("Message", "Adding to Cart Unsuccessful");
            request.setAttribute("indication", false);
            request.setAttribute("redirectURL", "viewproducts.jsp?productCode=" + productCode);
            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
            dispatcher.forward(request, response);
        }
    }
}

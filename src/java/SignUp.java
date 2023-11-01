
import com.password4j.Hash;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.password4j.Password;
import jakarta.servlet.RequestDispatcher;

@WebServlet("/SignUp")
public class SignUp extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sahajapparels";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneNumber = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String dob = null;
        String maritalStatus = request.getParameter("marital_status");
        String shippingAddress = request.getParameter("shipping_address");

        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);

            Hash hashedPassword = Password.hash(password).addPepper("shared-secret").addRandomSalt().withArgon2();
            String hashedPasswordStr = hashedPassword.getResult();

            String insertSql = "INSERT INTO Customers (Phone_Number, Email, HashedPassword, Name, DOB, Marital_Status, Shipping_Address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insertStatement = conn.prepareStatement(insertSql);
            insertStatement.setString(1, phoneNumber);
            insertStatement.setString(2, email);
            insertStatement.setString(3, hashedPasswordStr);
            insertStatement.setString(4, name);
            insertStatement.setString(5, dob);
            insertStatement.setString(6, maritalStatus);
            insertStatement.setString(7, shippingAddress);
            int rowsInserted = insertStatement.executeUpdate();

            if (rowsInserted > 0) {
                request.setAttribute("Message", "Sign up successful! Hashed Password: " + hashedPasswordStr);
                request.setAttribute("indication", true);
                request.setAttribute("redirectURL", "Login.jsp");
            } else {
                request.setAttribute("Message", "Sign up failed due to a server error.");
                request.setAttribute("indication", false);
                request.setAttribute("redirectURL", "Login.jsp");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
            dispatcher.forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("Message", "An error occurred: " + e.getMessage());
            request.setAttribute("indication", false);
            request.setAttribute("redirectURL", "Login.jsp");

            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
            dispatcher.forward(request, response);
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                request.setAttribute("Message", "An error occurred: " + e.getMessage());
                request.setAttribute("indication", false);
                request.setAttribute("redirectURL", "Login.jsp");

                RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import com.password4j.Password;
import jakarta.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sahajapparels";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneNumber = request.getParameter("phone_number");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT hashedPassword FROM Customers WHERE Phone_Number = ?";
                try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
                    preparedStatement.setString(1, phoneNumber);

                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        if (resultSet.next()) {
                            String storedHashedPassword = resultSet.getString("hashedPassword");

                            if (Password.check(password, storedHashedPassword).addPepper("shared-secret").withArgon2()) {
                                HttpSession session = request.getSession();
                                session.setAttribute("user", phoneNumber);
                                request.setAttribute("Message", "Login successful");
                                request.setAttribute("indication", true);
                                request.setAttribute("redirectURL", "index.jsp");
                            } else {
                                request.setAttribute("Message", "Login unsuccessful");
                                request.setAttribute("indication", false);
                                request.setAttribute("redirectURL", "Login.jsp");
                            }

                            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            request.setAttribute("Message", "Login failed. Phone number not found.");
                            request.setAttribute("indication", false);
                            request.setAttribute("redirectURL", "Login.jsp");
                            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                            dispatcher.forward(request, response);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("Message", "An error occurred: " + e.getMessage());
            request.setAttribute("indication", false);
            RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
            dispatcher.forward(request, response);
        }
    }
}


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/buyCart")
public class buyCart extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/sahajapparels";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String phoneNumber = (String) session.getAttribute("user");

            if (phoneNumber != null) {

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String resultMessage;
                    try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                        CallableStatement cstmt = connection.prepareCall("{call buy(?, ?)}");
                        cstmt.setString(1, phoneNumber);
                        cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
                        cstmt.execute();
                        resultMessage = cstmt.getString(2);
                    }
                    if ("Done".equals(resultMessage)) {
                        request.setAttribute("Message", "Ordered successfully");
                        request.setAttribute("indication", true);
                        request.setAttribute("redirectURL", "index.jsp");
                    } else {
                        request.setAttribute("Message", "Empty Cart");
                        request.setAttribute("indication", false);
                        request.setAttribute("redirectURL", "cart.jsp");
                    }
                    RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                    dispatcher.forward(request, response);
                } catch (SQLException | ClassNotFoundException e) {
                    request.setAttribute("Message", e.toString());
                    request.setAttribute("indication", false);
                    request.setAttribute("redirectURL", "Cart.jsp");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("Message", "Login Required");
                request.setAttribute("indication", false);
                request.setAttribute("redirectURL", "Login.jsp");
                RequestDispatcher dispatcher = request.getRequestDispatcher("loading.jsp");
                dispatcher.forward(request, response);
            }
        }
    }
}

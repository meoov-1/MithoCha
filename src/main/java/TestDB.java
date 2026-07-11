import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/mithocha?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String user = "root";
        String password = "";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✓ Driver loaded");
            
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✓ Connected to database");
            
            // Try creating a test table
            Statement stmt = conn.createStatement();
            stmt.execute("CREATE TABLE IF NOT EXISTS test_table (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100))");
            System.out.println("✓ Can create tables");
            
            conn.close();
            System.out.println("✓ All tests passed!");
        } catch (Exception e) {
            System.out.println("✗ ERROR: " + e.getClass().getName());
            System.out.println("Message: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

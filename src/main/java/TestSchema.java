import com.mithocha.util.SchemaInitializer;
import java.sql.DriverManager;
import java.sql.Connection;

public class TestSchema {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/mithocha?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String user = "root";
        String password = "";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✓ Driver loaded");
            
            System.out.println("Testing schema initialization...");
            SchemaInitializer.ensureSchema(url, user, password);
            System.out.println("✓ Schema initialized successfully!");
            
        } catch (Exception e) {
            System.out.println("✗ ERROR during schema initialization:");
            System.out.println("Type: " + e.getClass().getName());
            System.out.println("Message: " + e.getMessage());
            System.out.println("\nFull stack trace:");
            e.printStackTrace();
            
            // Print cause if exists
            if (e.getCause() != null) {
                System.out.println("\nCaused by: " + e.getCause().getClass().getName());
                System.out.println("Cause message: " + e.getCause().getMessage());
                e.getCause().printStackTrace();
            }
        }
    }
}

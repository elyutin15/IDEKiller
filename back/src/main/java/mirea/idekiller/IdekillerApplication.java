package mirea.idekiller;

import jakarta.servlet.annotation.WebServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import javax.sql.DataSource;

@SpringBootApplication
public class IdekillerApplication {

	public static void main(String[] args) {
		SpringApplication.run(IdekillerApplication.class, args);
	}

}

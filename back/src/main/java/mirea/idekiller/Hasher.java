package mirea.idekiller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class Hasher {


    public static String hash(String s) {
        return s;
    }

    public static String hash(char[] s) {
        return s.toString();
    }
}
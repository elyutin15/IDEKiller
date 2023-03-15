package mirea.idekiller.auth;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import org.springframework.stereotype.Component;

@Component
public class Hasher {
    private static Argon2 argon;

    Hasher() {
        argon = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id, 32, 64);
    }


    public static String hash(char[] s) {
        if (s == null) {
            return null;
        }
        return argon.hash(2, 15 * 1024, 1, s);
    }

    public static boolean verify(char[] s, String hash) {
        return argon.verify(hash, s);
    }
}
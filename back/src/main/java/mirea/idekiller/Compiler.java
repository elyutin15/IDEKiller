package mirea.idekiller;

import mirea.idekiller.model.Code;
import mirea.idekiller.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Compiler {
    Logger log = LoggerFactory.getLogger(Compiler.class);

    public Compiler() {
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe", "/c", "cd C:\\Users\\Max\\Desktop\\IDEKiller\\util && touch Main.java");
        builder.redirectErrorStream(true);
        try {
            Process p = builder.start();
        } catch (IOException e) {
            log.error("Error when create file for compilation");
        }
    }

    public Output compile(Code code) throws IOException {
        //TODO change type command if server is windows
        StringBuilder sb = new StringBuilder();
        sb.append("cd C:\\Users\\Max\\Desktop\\IDEKiller\\util");
        sb.append(" && echo %s > Main.java");
        sb.append(" && javac Main.java && java Main");
        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe",
                "/c",
                String.format(sb.toString(), code.getCode())
        );
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        String line;
        sb.delete(0, sb.length());
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            sb.append(line);
        }
        return new Output(sb.toString());
    }
}

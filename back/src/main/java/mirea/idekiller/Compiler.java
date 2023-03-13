package mirea.idekiller;

import mirea.idekiller.model.compiler.Code;
import mirea.idekiller.model.compiler.CompilationRequest;
import mirea.idekiller.model.compiler.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

@Component
public class Compiler {
    Logger log = LoggerFactory.getLogger(Compiler.class);

    private final String utilPath;

    @Autowired
    public Compiler(@Value("${util.path}") String utilPath) {
        this.utilPath = utilPath;
        if (!Files.exists(Path.of(utilPath))) {
            try {
                Files.createDirectory(Path.of(utilPath));
            } catch (IOException e) {
                log.error("Error while creating directory util");
            }
        }
    }
    public Output compile(CompilationRequest compilationRequest) throws IOException {
        String path = writeCode(compilationRequest.getCode());

        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe",
                "/c",
                "cd " + utilPath + "//" + path + " && javac Main.java && java Main"
        );
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        BufferedWriter w = new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));

        w.write(compilationRequest.getInput().getWords());
        w.close();

        String line;
        StringBuilder sb = new StringBuilder();
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            sb.append(line);
            sb.append("\n");
        }
        if (sb.length() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        r.close();
        eraseCode(path);
        return new Output(sb.toString());
    }

    private String writeCode(Code code) {
        String format = utilPath + "//%d";
        int num = 0;
        while (Files.exists(Path.of(String.format(format, num)))) {
            num++;
        }
        try {
            String path = String.format(format, num);
            Files.createDirectory(Path.of(path));
            Files.createFile(Path.of(path+"//Main.java"));
            Files.write(Path.of(path+"//Main.java"), List.of(code.getCode()), StandardCharsets.UTF_8);
            return Integer.toString(num);
        } catch (IOException e) {
            log.error("Error while creating directory and file for thread");
        }
        return null;
    }

    private void eraseCode(String path) {
        try {
            if (path == null) {
                return;
            }
            path = utilPath + "//" + path;
            Files.deleteIfExists(Path.of(path + "//Main.java"));
            Files.deleteIfExists(Path.of(path + "//Main.class"));
            Files.deleteIfExists(Path.of(path));
        } catch (IOException e) {
            log.error("Error while deleting code file");
        }
    }
}

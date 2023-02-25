package mirea.idekiller;

import mirea.idekiller.model.Code;
import mirea.idekiller.model.CompilationRequest;
import mirea.idekiller.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Compiler {
    Logger log = LoggerFactory.getLogger(Compiler.class);

    private final String utilsPath;

    public Compiler(Environment env) {
        utilsPath = env.getProperty("utils.path");
        if (!Files.exists(Path.of(utilsPath + "//Main.java"))) {
            try {
                Files.createFile(Path.of(utilsPath + "//Main.java"));
            } catch (IOException e) {
                log.error("Error when create file for compilation" );
            }
        }
    }

    public Output compile(CompilationRequest compilationRequest) throws IOException {
        writeCode(compilationRequest.getCode());

        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe",
                "/c",
                "cd " + utilsPath + " && javac Main.java && java Main"
        );
        builder.redirectErrorStream(true);
        Process p = builder.start();
        BufferedReader r = new BufferedReader(new InputStreamReader(p.getInputStream()));
        BufferedWriter w = new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));

        for (String word : compilationRequest.getInput().getWords()) {
            w.write(word);
        }
        w.close();
        String line;
        StringBuilder sb = new StringBuilder();
        while (true) {
            line = r.readLine();
            if (line == null) { break; }
            sb.append(line);
        }
        return new Output(sb.toString());
    }

    private void writeCode(Code code) {
        try {
            Files.write(Path.of(utilsPath + "//Main.java"), List.of(code.getCode()), StandardCharsets.UTF_8);
        } catch (IOException e) {
            log.error("Error when writing code on file");
        }
    }
}

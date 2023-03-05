package mirea.idekiller;

import mirea.idekiller.model.compiler.Code;
import mirea.idekiller.model.compiler.CompilationRequest;
import mirea.idekiller.model.compiler.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

@Component
public class Compiler {
    Logger log = LoggerFactory.getLogger(Compiler.class);

    private final String utilsPath = "..//util";
    private final String utilsMainJavaPath = "..//util//Main.java";

    public Compiler() {
        if (!Files.exists(Path.of(utilsMainJavaPath))) {
            try {
                Files.createFile(Path.of(utilsMainJavaPath));
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

        w.write(compilationRequest.getInput().getWords());
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
            Files.write(Path.of(utilsMainJavaPath), List.of(code.getCode()), StandardCharsets.UTF_8);
        } catch (IOException e) {
            log.error("Error when writing code on file");
        }
    }
}

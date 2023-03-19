package mirea.idekiller.compiler;

import mirea.idekiller.compiler.model.Code;
import mirea.idekiller.compiler.model.CompilationRequest;
import mirea.idekiller.compiler.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
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
    public Output compile(CompilationRequest compilationRequest, ServerSocket serverSocket) throws IOException {
        String path = writeCode(compilationRequest.getCode());

        ProcessBuilder builder = new ProcessBuilder(
                "cmd.exe",
                "/c",
                "cd " + utilPath + "//" + path + " && javac Main.java && java Main"
        );
        builder.redirectErrorStream(true);
        Process p = builder.start();

        Socket client = serverSocket.accept();

        client.setKeepAlive(true);
        BufferedReader pr = new BufferedReader(new InputStreamReader(p.getInputStream()));
        BufferedWriter pw = new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
        BufferedReader cr = new BufferedReader(new InputStreamReader(client.getInputStream()));
        BufferedWriter cw = new BufferedWriter(new OutputStreamWriter(client.getOutputStream()));


        StringBuilder sb = new StringBuilder();
        while (true) {
            try {
                p.exitValue();
                cw.write("e");
                cw.flush();
                break;
            } catch (IllegalThreadStateException ignored) {}

            if (cr.ready()) {
                var a1 = cr.read();
                if (a1 > 0) {
                    pw.write((char) a1);
                    pw.flush();
                }
                continue;
            }
            if (pr.ready()) {
                var a2 = pr.read();
                if (a2 <= 0) {
                    break;
                }
                sb.append((char) a2);
            }

        }
        if (sb.length() > 0) {
            sb.deleteCharAt(sb.length() - 1);
        }
        //process p is died

        cr.close();
        client.close();

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

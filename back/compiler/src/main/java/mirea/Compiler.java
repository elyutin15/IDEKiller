package mirea;

import mirea.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

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
    public Output compile(CompilationRequest compilationRequest, UUID uuid) throws IOException, InterruptedException {
        String path = writeCode(compilationRequest.getCode(), uuid);

        ProcessBuilder builder = getProcessBuilder(compilationRequest.getCode().getLanguage(), path);
        if (builder == null) {
            return null;
        }
        Process p = builder.start();

        Path inFile = Path.of(path + "//in.txt");
        Path outFile = Path.of(path + "//out.txt");

        Files.write(inFile, compilationRequest.getInput().getWords().getBytes());
        BufferedReader processReader = new BufferedReader(new InputStreamReader(p.getInputStream(), StandardCharsets.UTF_8));

        while (p.isAlive()) {
            List<String> input = Files.readAllLines(inFile);
            if (input.size() != 0) {
                BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
                for (String word : input) {
                    writer.write(word);
                    writer.newLine();
                }
                writer.flush();
                Files.write(inFile, "".getBytes(), StandardOpenOption.TRUNCATE_EXISTING);
                continue;
            }
            readProcessOutput(processReader, outFile);
        }
        readProcessOutput(processReader, outFile);

        final StringBuilder result = new StringBuilder();
        Files.readAllLines(outFile).forEach(i -> result.append(i).append("\n"));
        eraseCode(path);
        result.deleteCharAt(result.length() - 1);
        return new Output(result.toString());
    }

    private ProcessBuilder getProcessBuilder(Language language, String path) throws IOException, InterruptedException {

        ProcessBuilder builder;
        switch (language) {
            case JAVA:
                builder = new ProcessBuilder(
                        "cmd.exe",
                        "/c",
                        "cd " + path + " && javac Main.java && java Main"
                );
                builder.redirectErrorStream(true);
                return builder;
            case CPLUSPLUS:
                builder = new ProcessBuilder(
                        "cmd.exe",
                        "/c",
                        "cd " + path + " && g++ -Wall -o Main Main.cpp && Main.exe"
                );
                builder.redirectErrorStream(true);
                return builder;
            case C:
                builder = new ProcessBuilder(
                        "cmd.exe",
                        "/c",
                        "cd " + path + " && gcc -Wall -o Main Main.c && Main.exe"
                );
                builder.redirectErrorStream(true);
                return builder;
            case PYTHON:
                builder = new ProcessBuilder(
                        "cmd.exe",
                        "/c",
                        "cd " + path + " && python Main.py"
                );
                builder.redirectErrorStream(true);
                return builder;
            default:
                return null;
        }

    }

    public void appendInput(Input input, UUID uuid, int attempt) throws InterruptedException {
        if (attempt == 5) {
            return;
        }
        try {
            String path = utilPath + "//" + uuid.toString() + "//in.txt";
            Files.write(Path.of(path), input.getWords().getBytes(), StandardOpenOption.APPEND);
        } catch (Exception e) {
            e.printStackTrace();
            TimeUnit.MILLISECONDS.sleep(100);
            appendInput(input, uuid, attempt+1);
        }
    }

    private void readProcessOutput(BufferedReader processReader, Path outFile) throws IOException {
        while (processReader.ready()) {
            String line = processReader.readLine();
            if (line == null)
                break;
            line += "\n";
            Files.write(outFile, line.getBytes(), StandardOpenOption.APPEND);
        }
    }

    private String writeCode(Code code, UUID uuid) {
        String path = utilPath + "//" + uuid.toString();
        try {
            Files.createDirectory(Path.of(path));
            Files.createFile(Path.of(path+"//Main" + code.getLanguage().end));
            Files.createFile(Path.of(path+"//in.txt"));
            Files.createFile(Path.of(path+"//out.txt"));
            Files.write(Path.of(path+"//Main" + code.getLanguage().end), List.of(code.getCode()), StandardCharsets.UTF_8);
            return path;
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
            for (Path p : Files.list(Path.of(path)).toList()) {
                Files.deleteIfExists(p);
            }
            Files.deleteIfExists(Path.of(path));
        } catch (IOException e) {
            log.error("Error while deleting code file");
        }
    }
}

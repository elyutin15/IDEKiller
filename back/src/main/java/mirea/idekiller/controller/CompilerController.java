package mirea.idekiller.controller;

import mirea.idekiller.Compiler;
import mirea.idekiller.model.compiler.CompilationRequest;
import mirea.idekiller.model.compiler.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
public class CompilerController {
    private final Compiler compiler;

    Logger log = LoggerFactory.getLogger(CompilerController.class);


    CompilerController() {
        compiler = new Compiler();
    }

    @CrossOrigin(origins = {"${frontend.url}"})
    @ResponseBody
    @PostMapping("/")
    public Output compileCode(@RequestBody CompilationRequest compilationRequest) throws IOException {
        log.info("Requested compilation");
        Output out = compiler.compile(compilationRequest);
        log.info("Outputted code: {}", out.getOutput());
        return out;
    }
}

package mirea.idekiller.compiler.controller;

import mirea.idekiller.compiler.Compiler;
import mirea.idekiller.compiler.model.CompilationRequest;
import mirea.idekiller.compiler.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
public class CompilerController {

    @Autowired
    private Compiler compiler;

    Logger log = LoggerFactory.getLogger(CompilerController.class);


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
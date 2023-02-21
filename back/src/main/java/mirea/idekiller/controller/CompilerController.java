package mirea.idekiller.controller;

import mirea.idekiller.Compiler;
import mirea.idekiller.model.Code;
import mirea.idekiller.model.Output;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

@Controller
public class CompilerController {
    private final Compiler compiler;
    Logger log = LoggerFactory.getLogger(CompilerController.class);

    CompilerController() {
        compiler = new Compiler();
    }

    @PostMapping("/")
    @ResponseBody
    public Output compileCode(@RequestBody Code code) throws IOException {

        log.info("Requested compilation");
        Output out = compiler.compile(code);
        log.info("Outputted code: {}", out.getOutput());
        return out;
    }
}

package mirea.idekiller.controller;

import mirea.idekiller.model.CodeModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CompilatorController {

    Logger log = LoggerFactory.getLogger(CompilatorController.class);

    @PostMapping("/")
    @ResponseBody
    public String compileCode(@RequestBody CodeModel codeModel) {

        log.info("Requested compilation for code: {}", codeModel.getCode());
        return codeModel.toString();
    }
}

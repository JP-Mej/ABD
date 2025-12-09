package demo.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ViewController {

    @GetMapping("/project")
    public String projectTest() {
        return "project"; // project.html
    }

    @GetMapping("/employee")
    public String employeeTest() {
        return "employee"; // employee.html
    }

    @GetMapping("/beneficiary")
    public String beneficiaryTest() {
        return "beneficiary"; // beneficiary.html
    }
}

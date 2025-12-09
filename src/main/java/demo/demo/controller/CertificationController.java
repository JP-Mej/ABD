package demo.demo.controller;

import demo.demo.service.CertificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/certification")
@CrossOrigin(origins = "*")
public class CertificationController {

    @Autowired
    private CertificationService service;

    @PostMapping("/vencidos")
    public ResponseEntity<String> mostrarVencidos() {
        service.mostrarCertificadosVencidos();
        return ResponseEntity.ok("Certificados vencidos procesados");
    }
}

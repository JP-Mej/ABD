package demo.demo.controller;

import demo.demo.model.Beneficiary;
import demo.demo.service.BeneficiaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/beneficiary")
@CrossOrigin(origins = "*")
public class BeneficiaryController {

    @Autowired
    private BeneficiaryService service;

    @PostMapping("/registrar")
    public ResponseEntity<String> registrar(@RequestBody Beneficiary b) {
        service.registrarBeneficiarioSP(b);
        return ResponseEntity.ok("Beneficiario registrado correctamente");
    }

    @GetMapping("/dni/{dni}")
    public ResponseEntity<Boolean> validarDni(@PathVariable String dni) {
        return ResponseEntity.ok(service.dniExiste(dni));
    }


    @GetMapping("/listar")
    public ResponseEntity<List<Beneficiary>> listarTodos() {
        List<Beneficiary> lista = service.listarTodos();
        return ResponseEntity.ok(lista);
    }
}

package demo.demo.controller;

import demo.demo.model.Institution;
import demo.demo.service.InstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/institution")
@CrossOrigin(origins = "*")
public class InstitutionController {

    @Autowired
    private InstitutionService service;

    @GetMapping
    public List<Institution> listar() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Institution> buscar(@PathVariable Long id) {
        Institution inst = service.getById(id);
        return inst != null ? ResponseEntity.ok(inst) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Institution> guardar(@RequestBody Institution institution) {
        return ResponseEntity.ok(service.save(institution));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}

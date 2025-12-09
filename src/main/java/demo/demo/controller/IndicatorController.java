package demo.demo.controller;

import demo.demo.model.Indicator;
import demo.demo.service.IndicatorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/indicator")
@CrossOrigin(origins = "*")
public class IndicatorController {

    @Autowired
    private IndicatorService service;

    @GetMapping
    public List<Indicator> listar() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Indicator> buscar(@PathVariable Long id) {
        Indicator ind = service.getById(id);
        return ind != null ? ResponseEntity.ok(ind) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Indicator> guardar(@RequestBody Indicator indicator) {
        return ResponseEntity.ok(service.save(indicator));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}

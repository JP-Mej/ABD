package demo.demo.controller;

import demo.demo.model.Resources;
import demo.demo.service.ResourcesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/resources")
@CrossOrigin(origins = "*")
public class ResourcesController {

    @Autowired
    private ResourcesService service;

    @GetMapping
    public List<Resources> listar() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Resources> buscar(@PathVariable Long id) {
        Resources res = service.getById(id);
        return res != null ? ResponseEntity.ok(res) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Resources> guardar(@RequestBody Resources resources) {
        return ResponseEntity.ok(service.save(resources));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}

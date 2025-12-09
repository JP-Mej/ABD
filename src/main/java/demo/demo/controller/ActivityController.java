package demo.demo.controller;

import demo.demo.model.Activity;
import demo.demo.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/activity")
@CrossOrigin(origins = "*")
public class ActivityController {

    @Autowired
    private ActivityService service;

    @GetMapping
    public List<Activity> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Activity> buscarPorId(@PathVariable Long id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Activity> crear(@RequestBody Activity a) {
        return ResponseEntity.ok(service.crear(a));
    }

    @PutMapping
    public ResponseEntity<Activity> actualizar(@RequestBody Activity a) {
        return ResponseEntity.ok(service.actualizar(a));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}

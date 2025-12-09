package demo.demo.controller;

import demo.demo.model.Volunteer;
import demo.demo.service.VolunteerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/volunteer")
@CrossOrigin(origins = "*")
public class VolunteerController {

    @Autowired
    private VolunteerService service;

    @GetMapping
    public List<Volunteer> listar() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Volunteer> buscar(@PathVariable Long id) {
        Volunteer v = service.getById(id);
        return v != null ? ResponseEntity.ok(v) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Volunteer> guardar(@RequestBody Volunteer volunteer) {
        return ResponseEntity.ok(service.save(volunteer));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}

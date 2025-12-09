package demo.demo.controller;

import demo.demo.model.Location;
import demo.demo.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/location")
@CrossOrigin(origins = "*")
public class LocationController {

    @Autowired
    private LocationService service;

    @GetMapping
    public List<Location> listar() {
        return service.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Location> buscar(@PathVariable Long id) {
        Location loc = service.getById(id);
        return loc != null ? ResponseEntity.ok(loc) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<Location> guardar(@RequestBody Location location) {
        return ResponseEntity.ok(service.save(location));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.delete(id);
        return ResponseEntity.noContent().build();
    }
}

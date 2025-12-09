package demo.demo.controller;

import demo.demo.model.Employee;
import demo.demo.service.EmployeeService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/employee")
@CrossOrigin(origins = "*")
public class EmployeeController {

    private final EmployeeService service;

    public EmployeeController(EmployeeService service) {
        this.service = service;
    }

    @GetMapping
    public List<Employee> listar() {
        return service.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Employee> buscar(@PathVariable Long id) {
        return service.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<Employee> crear(@RequestBody Employee e) {
        return ResponseEntity.ok(service.crear(e));
    }

    @PutMapping
    public ResponseEntity<Employee> actualizar(@RequestBody Employee e) {
        return ResponseEntity.ok(service.actualizar(e));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/promedio-salario")
    public ResponseEntity<Double> promedioSalario() {
        return ResponseEntity.ok(service.obtenerPromedioSalario());
    }
}

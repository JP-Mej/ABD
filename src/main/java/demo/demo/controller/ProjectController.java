package demo.demo.controller;

import demo.demo.model.Project;
import demo.demo.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/project")
@CrossOrigin(origins = "*")
public class ProjectController {

    @Autowired
    private ProjectService service;

    // ✅ Listar todos los proyectos
    @GetMapping
    public List<Project> listar() {
        return service.getAll();
    }

    // ✅ Guardar proyecto (Trigger automático)
    @PostMapping
    public ResponseEntity<Project> guardar(@RequestBody Project project) {
        return ResponseEntity.ok(service.save(project));
    }

    // ✅ Registrar proyecto mediante PROCEDURE
    @PostMapping("/registrar-sp")
    public ResponseEntity<String> registrarProyectoSP(@RequestBody Project project) {
        service.registrarProyectoSP(project);
        return ResponseEntity.ok("✅ Proyecto registrado correctamente por SP");
    }
}

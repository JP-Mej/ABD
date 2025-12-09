package demo.demo.controller;

import demo.demo.service.ReporteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/reporte")
@CrossOrigin(origins = "*")
public class ReporteController {

    @Autowired
    private ReporteService service;

    // ✅ Ejecuta SP Top 5 Proyectos
    @GetMapping("/top5-proyectos")
    public ResponseEntity<String> top5Proyectos() {
        service.top5Proyectos();
        return ResponseEntity.ok("✅ Reporte Top 5 Proyectos ejecutado");
    }

    // ✅ Ejecuta SP Voluntarios Activos
    @GetMapping("/voluntarios-activos")
    public ResponseEntity<String> voluntariosActivos() {
        service.voluntariosActivos();
        return ResponseEntity.ok("✅ Reporte Voluntarios Activos ejecutado");
    }
}

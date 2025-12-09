package demo.demo.controller;

import demo.demo.model.Funding;
import demo.demo.service.FundingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/funding")
@CrossOrigin(origins = "*")
public class FundingController {

    @Autowired
    private FundingService service;

    // ✅ Listar todos los financiamientos
    @GetMapping
    public List<Funding> listar() {
        return service.getAll();
    }

    // ✅ Guardar financiamiento (Trigger automático)
    @PostMapping
    public ResponseEntity<Funding> guardar(@RequestBody Funding funding) {
        return ResponseEntity.ok(service.save(funding));
    }

    // ✅ Validar total de financiamiento con función
    @GetMapping("/validar-total/{fundingId}")
    public ResponseEntity<Boolean> validarTotal(@PathVariable Long fundingId) {
        return ResponseEntity.ok(service.totalFundingCorrecto(fundingId));
    }

    // ✅ Obtiene porcentaje por partner
    @GetMapping("/porcentaje/{fundId}/{partnerId}")
    public ResponseEntity<Double> porcentajePartner(
            @PathVariable Long fundId,
            @PathVariable Long partnerId
    ) {
        return ResponseEntity.ok(service.porcentajePartner(fundId, partnerId));
    }
}

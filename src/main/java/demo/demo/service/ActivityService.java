package demo.demo.service;

import demo.demo.model.Activity;
import demo.demo.repository.ActivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class ActivityService {

    @Autowired
    private ActivityRepository repository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // ✅ Listar todas las actividades
    public List<Activity> listar() {
        return repository.findAll();
    }

    // ✅ Buscar por ID
    public Optional<Activity> buscarPorId(Long id) {
        return repository.findById(id);
    }

    // ✅ Crear actividad (validación en backend + triggers si tuvieras)
    @Transactional
    public Activity crear(Activity a) {

        if (a.getActivityDate() == null)
            throw new RuntimeException("La fecha de la actividad es obligatoria.");

        if (a.getActivityDate().isAfter(LocalDate.now().plusYears(1)))
            throw new RuntimeException("La fecha de la actividad no puede ser tan futura.");

        return repository.save(a);
    }

    // ✅ Actualizar actividad
    @Transactional
    public Activity actualizar(Activity a) {

        if (a.getActivityDate() == null)
            throw new RuntimeException("La fecha de la actividad es obligatoria.");

        return repository.save(a);
    }

    // ✅ Eliminar actividad
    @Transactional
    public void eliminar(Long id) {
        repository.deleteById(id);
    }
}

package demo.demo.service;

import demo.demo.model.Employee;
import demo.demo.repository.EmployeeRepository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {

    private final EmployeeRepository repository;
    private final JdbcTemplate jdbc;

    public EmployeeService(EmployeeRepository repository, JdbcTemplate jdbc) {
        this.repository = repository;
        this.jdbc = jdbc;
    }

    public List<Employee> listar() {
        return repository.findAll();
    }

    public Optional<Employee> buscarPorId(Long id) {
        return repository.findById(id);
    }

    /**
     * INSERT normal, el trigger valida edad >= 18
     */
    @Transactional
    public Employee crear(Employee e) {
        if (e.getSalary() < 0)
            throw new RuntimeException("El salario no puede ser negativo.");

        if (e.getEndDateE() != null && e.getEndDateE().isBefore(e.getStartDateE()))
            throw new RuntimeException("Fechas de contrato inválidas.");

        return repository.save(e); // TRIGGER valida edad
    }

    @Transactional
    public Employee actualizar(Employee e) {
        return repository.save(e);
    }

    @Transactional
    public void eliminar(Long id) {
        repository.deleteById(id);
    }

    /**
     * Llamada a tu FUNCTION de Oracle
     */
    public Double obtenerPromedioSalario() {
        return jdbc.queryForObject(
            "SELECT fn_promedio_salario_empleados FROM dual",
            Double.class
        );
    }
}

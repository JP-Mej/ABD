package demo.demo.service;

import demo.demo.model.Project;
import demo.demo.repository.ProjectRepository;
import jakarta.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectService {

    @Autowired
    private ProjectRepository repository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<Project> getAll() {
        return repository.findAll();
    }

    public Project save(Project project) {
        return repository.save(project); // validado por triggers
    }
    @Transactional
    public void registrarProyectoSP(Project p) {
        jdbcTemplate.update("""
            CALL PA_REGISTRAR_PROYECTO(?,?,?,?,?,?,?,?,?,?,?,?)
        """,
                p.getProjectId(),
                p.getActivityId(),
                p.getFundingId(),
                p.getIndicatorId(),
                p.getLocationId(),
                p.getNameP(),
                p.getDescriptionP(),
                p.getBudgetAmount(),
                p.getStrategicArea(),
                p.getStartDateP(),
                p.getEndDateP(),
                p.getStatus()
        );
    }
}

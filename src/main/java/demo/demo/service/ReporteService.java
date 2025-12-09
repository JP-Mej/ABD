
package demo.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class ReporteService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void top5Proyectos() {
        jdbcTemplate.execute("CALL prc_top_5_proyectos_presupuesto()");
    }

    public void voluntariosActivos() {
        jdbcTemplate.execute("CALL prc_voluntarios_activos()");
    }
}

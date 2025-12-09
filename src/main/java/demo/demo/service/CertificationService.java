package demo.demo.service;

import demo.demo.repository.CertificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class CertificationService {

    @Autowired
    private CertificationRepository repository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void mostrarCertificadosVencidos() {
        jdbcTemplate.execute("CALL prc_certificados_vencidos()");
    }
}

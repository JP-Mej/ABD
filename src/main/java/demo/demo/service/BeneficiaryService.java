package demo.demo.service;

import demo.demo.model.Beneficiary;
import demo.demo.repository.BeneficiaryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BeneficiaryService {

    @Autowired
    private BeneficiaryRepository repository;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    // ✅ Llama a la FUNCIÓN FN_DNI_EXISTE
    public boolean dniExiste(String dni) {
        Integer result = jdbcTemplate.queryForObject(
                "SELECT FN_DNI_EXISTE(?) FROM dual",
                Integer.class,
                dni
        );
        return result != null && result > 0;
    }

    // ✅ Llama al PROCEDURE + TRIGGER automático
    @Transactional
    public void registrarBeneficiarioSP(Beneficiary b) {

        if (dniExiste(b.getDniB())) {
            throw new RuntimeException("DNI ya registrado (bloqueado por función)");
        }

        jdbcTemplate.update("""
            CALL PR_REGISTRAR_BENEFICIARIO(?,?,?,?,?,?,?,?,?,?)
        """,
                b.getBeneficiaryId(),
                b.getDniB(),
                b.getInstitutionId(),
                b.getGender(),
                b.getFirstNameB(),
                b.getLastNameB(),
                b.getBirthDateB(),
                b.getOccupation(),
                b.getPhoneB(),
                b.getEmailB()
        );
    }

    public List<Beneficiary> listarTodos() {
        return repository.findAll();
    }

}

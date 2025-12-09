package demo.demo.service;

import demo.demo.model.Funding;
import demo.demo.repository.FundingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FundingService {

    @Autowired
    private FundingRepository repository;
    private JdbcTemplate jdbcTemplate; 
    

    public List<Funding> getAll() {
        return repository.findAll();
    }

    public Funding save(Funding funding) {
        return repository.save(funding); // trigger RN-016 se ejecuta
    }

        // ✅ Llama a FN_TOTAL_FUNDING_OK
    public boolean totalFundingCorrecto(Long fundingId) {
        Integer result = jdbcTemplate.queryForObject(
                "SELECT FN_TOTAL_FUNDING_OK(?) FROM dual",
                Integer.class,
                fundingId
        );
        return result != null && result == 1;
    }

    // ✅ Llama a FN_PORCENTAJE_FINANCIAMIENTO_PARTNER
    public Double porcentajePartner(Long fundId, Long partnerId) {
        return jdbcTemplate.queryForObject(
                "SELECT FN_PORCENTAJE_FINANCIAMIENTO_PARTNER(?,?) FROM dual",
                Double.class,
                fundId, partnerId
        );
    }


}


package demo.demo.service;

import demo.demo.model.Indicator;
import demo.demo.repository.IndicatorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class IndicatorService {

    @Autowired
    private IndicatorRepository repository;

    public List<Indicator> getAll() {
        return repository.findAll();
    }

    public Indicator save(Indicator indicator) {
        return repository.save(indicator);
    }

    public Indicator getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

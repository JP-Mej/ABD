package demo.demo.service;

import demo.demo.model.Institution;
import demo.demo.repository.InstitutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InstitutionService {

    @Autowired
    private InstitutionRepository repository;

    public List<Institution> getAll() {
        return repository.findAll();
    }

    public Institution save(Institution institution) {
        return repository.save(institution);
    }

    public Institution getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

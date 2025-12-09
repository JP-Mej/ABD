package demo.demo.service;

import demo.demo.model.Resources;
import demo.demo.repository.ResourcesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResourcesService {

    @Autowired
    private ResourcesRepository repository;

    public List<Resources> getAll() {
        return repository.findAll();
    }

    public Resources save(Resources resource) {
        return repository.save(resource); // aquí se ejecuta el trigger
    }

    public Resources getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

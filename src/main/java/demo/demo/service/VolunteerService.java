package demo.demo.service;

import demo.demo.model.Volunteer;
import demo.demo.repository.VolunteerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VolunteerService {

    @Autowired
    private VolunteerRepository repository;

    public List<Volunteer> getAll() {
        return repository.findAll();
    }

    public Volunteer save(Volunteer volunteer) {
        return repository.save(volunteer);
    }

    public Volunteer getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

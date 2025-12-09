package demo.demo.service;

import demo.demo.model.Location;
import demo.demo.repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LocationService {

    @Autowired
    private LocationRepository repository;

    public List<Location> getAll() {
        return repository.findAll();
    }

    public Location save(Location location) {
        return repository.save(location);
    }

    public Location getById(Long id) {
        return repository.findById(id).orElse(null);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

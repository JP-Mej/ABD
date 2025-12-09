package demo.demo.repository;

import demo.demo.model.Resources;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourcesRepository extends JpaRepository<Resources, Long> {

    List<Resources> findByResourceType(String resourceType);

    List<Resources> findByLanguage(String language);
}

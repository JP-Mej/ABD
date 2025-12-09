package demo.demo.repository;

import demo.demo.model.Certification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CertificationRepository extends JpaRepository<Certification, Long> {

    List<Certification> findByBeneficiaryId(Long beneficiaryId);

    List<Certification> findByResourceId(Long resourceId);
}

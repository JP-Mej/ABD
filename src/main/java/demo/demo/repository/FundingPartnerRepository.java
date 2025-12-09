package demo.demo.repository;

import demo.demo.model.FundingPartner;
import demo.demo.model.FundingPartnerId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FundingPartnerRepository extends JpaRepository<FundingPartner, FundingPartnerId> {

    List<FundingPartner> findByFundingId(Long fundingId);

    List<FundingPartner> findByPartnerId(Long partnerId);
}

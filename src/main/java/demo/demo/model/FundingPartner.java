package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "FUNDING_PARTNER")
@Data
@IdClass(FundingPartnerId.class)
public class FundingPartner {

    @Id
    @Column(name = "FUNDING_ID")
    private Long fundingId;

    @Id
    @Column(name = "PARTNER_ID")
    private Long partnerId;

    @Column(name = "CONTRIBUTION_ROLE", nullable = false)
    private String contributionRole;

    @Column(name = "CONTRIBUTION_PORCENTAGE", nullable = false)
    private Double contributionPorcentage;

    @Column(name = "CONTRIBUTION_AMOUNT", nullable = false)
    private Double contributionAmount;

    @Column(name = "CURRENCY", nullable = false)
    private String currency;

    @Column(name = "CONTRIBUTION_DATE", nullable = false)
    private LocalDate contributionDate;

    @Column(name = "CONTRACT_REFERENCE", nullable = false)
    private String contractReference;
}

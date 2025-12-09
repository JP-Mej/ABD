package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "CERTIFICATION")
@Data
public class Certification {

    @Id
    @Column(name = "CERT_ID")
    private Long certId;

    @Column(name = "BENEFICIARY_ID", nullable = false)
    private Long beneficiaryId;

    @Column(name = "RESOURCE_ID", nullable = false)
    private Long resourceId;

    @Column(name = "ISSUE_DATE", nullable = false)
    private LocalDate issueDate;

    @Column(name = "EXPIRY_DATE", nullable = false)
    private LocalDate expiryDate;

    @Column(name = "GRADE", nullable = false, length = 2)
    private String grade;
}

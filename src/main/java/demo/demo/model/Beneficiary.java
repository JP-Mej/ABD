package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "BENEFICIARY")
@Data
public class Beneficiary {

    @Id
    @Column(name = "BENEFICIARY_ID")
    private Long beneficiaryId;

    @Column(name = "DNI_B", nullable = false, length = 8)
    private String dniB;

    @Column(name = "INSTITUTION_ID", nullable = false)
    private Long institutionId;

    @Column(name = "GENDER", nullable = false, length = 1)
    private String gender;

    @Column(name = "FIRST_NAME_B", nullable = false, length = 50)
    private String firstNameB;

    @Column(name = "LAST_NAME_B", nullable = false, length = 50)
    private String lastNameB;

    @Column(name = "BIRTH_DATE_B", nullable = false)
    private LocalDate birthDateB;

    @Column(name = "OCCUPATION", nullable = false, length = 20)
    private String occupation;

    @Column(name = "PHONE_B", nullable = false, length = 9)
    private String phoneB;

    @Column(name = "EMAIL_B", nullable = false, length = 35)
    private String emailB;
}

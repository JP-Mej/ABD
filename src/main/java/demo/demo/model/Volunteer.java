package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "VOLUNTEER")
@Data
public class Volunteer {

    @Id
    @Column(name = "VOLUNTEER_ID")
    private Long volunteerId;

    @Column(name = "FIRST_NAME_V", nullable = false, length = 50)
    private String firstNameV;

    @Column(name = "LAST_NAME_V", nullable = false, length = 50)
    private String lastNameV;

    @Column(name = "BIRTH_DATE_V", nullable = false)
    private LocalDate birthDateV;

    @Column(name = "EMAIL_V", nullable = false, length = 35)
    private String emailV;

    @Column(name = "PHONE_V", nullable = false, length = 9)
    private String phoneV;

    @Column(name = "EMPLOYMENT_STATUS", nullable = false, length = 10)
    private String employmentStatus;
}

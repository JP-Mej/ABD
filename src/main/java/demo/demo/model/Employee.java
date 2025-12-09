package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "EMPLOYEE")
@Data
public class Employee {

    @Id
    @Column(name = "EMPLOYEE_ID")
    private Long employeeId;

    @Column(name = "FIRST_NAME_E", nullable = false, length = 50)
    private String firstNameE;

    @Column(name = "LAST_NAME_E", nullable = false, length = 50)
    private String lastNameE;

    @Column(name = "BIRTH_DATE_E", nullable = false)
    private LocalDate birthDateE;

    @Column(name = "EMAIL_E", nullable = false, length = 35)
    private String emailE;

    @Column(name = "PHONE_E", nullable = false, length = 9)
    private String phoneE;

    @Column(name = "ADDRESS_E", nullable = false, length = 50)
    private String addressE;

    @Column(name = "EMPLOYMENT_TYPE", nullable = false, length = 20)
    private String employmentType;

    @Column(name = "SALARY", nullable = false)
    private Double salary;

    @Column(name = "START_DATE_E", nullable = false)
    private LocalDate startDateE;

    @Column(name = "END_DATE_E")
    private LocalDate endDateE;  // Puede ser null
}

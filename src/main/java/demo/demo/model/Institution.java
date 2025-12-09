package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "INSTITUTION")
@Data
public class Institution {

    @Id
    @Column(name = "INSTITUTION_ID")
    private Long institutionId;

    @Column(name = "LOCATION_ID", nullable = false)
    private Long locationId;

    @Column(name = "NAME_I", nullable = false, length = 50)
    private String nameI;

    @Column(name = "INSTITUTION_TYPE", nullable = false, length = 30)
    private String institutionType;

    @Column(name = "ADDRESS_I", nullable = false, length = 50)
    private String addressI;

    @Column(name = "CONTACT_EMAIL_I", nullable = false, length = 35)
    private String contactEmailI;
}

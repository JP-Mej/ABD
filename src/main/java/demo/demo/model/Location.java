package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "LOCATION")
@Data
public class Location {

    @Id
    @Column(name = "LOCATION_ID")
    private Long locationId;

    @Column(name = "DEPARTMENT", nullable = false, length = 20)
    private String department;

    @Column(name = "PROVINCE", nullable = false, length = 20)
    private String province;

    @Column(name = "DISTRICT", nullable = false, length = 20)
    private String district;

    @Column(name = "COUNTRY", nullable = false, length = 20)
    private String country;
}

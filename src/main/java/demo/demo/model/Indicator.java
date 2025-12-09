package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "INDICATOR")
@Data
public class Indicator {

    @Id
    @Column(name = "INDICATOR_ID")
    private Long indicatorId;

    @Column(name = "DESCRIPTION_I", nullable = false, length = 50)
    private String descriptionI;

    @Column(name = "CODE", nullable = false, length = 20)
    private String code;

    @Column(name = "VALUE", nullable = false)
    private Double value;

    @Column(name = "MEASUREMENT_DATE", nullable = false)
    private LocalDate measurementDate;

    @Column(name = "TYPE", nullable = false, length = 20)
    private String type;
}

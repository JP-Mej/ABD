package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "ACTIVITY")
@Data
public class Activity {

    @Id
    @Column(name = "ACTIVITY_ID")
    private Long activityId;

    @Column(name = "NAME_A", nullable = false, length = 50)
    private String nameA;

    @Column(name = "ACTIVITY_TYPE", nullable = false, length = 30)
    private String activityType;

    @Column(name = "ACTIVITY_DATE", nullable = false)
    private LocalDate activityDate;
}

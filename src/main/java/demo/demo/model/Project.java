package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "PROJECT")
@Data
public class Project {

    @Id
    @Column(name = "PROJECT_ID")
    private Long projectId;

    @Column(name = "ACTIVITY_ID", nullable = false)
    private Long activityId;

    @Column(name = "FUNDING_ID", nullable = false)
    private Long fundingId;

    @Column(name = "INDICATOR_ID", nullable = false)
    private Long indicatorId;

    @Column(name = "LOCATION_ID", nullable = false)
    private Long locationId;

    @Column(name = "NAME_P", nullable = false, length = 50)
    private String nameP;

    @Column(name = "DESCRIPTION_P", nullable = false, length = 200)
    private String descriptionP;

    @Column(name = "BUDGET_AMOUNT", nullable = false)
    private Double budgetAmount;

    @Column(name = "STRATEGIC_AREA", nullable = false, length = 50)
    private String strategicArea;

    @Column(name = "START_DATE_P", nullable = false)
    private LocalDate startDateP;

    @Column(name = "END_DATE_P", nullable = false)
    private LocalDate endDateP;

    @Column(name = "STATUS", nullable = false, length = 20)
    private String status;
}

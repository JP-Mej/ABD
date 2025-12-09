package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "FUNDING")
@Data
public class Funding {

    @Id
    @Column(name = "FUNDING_ID")
    private Long fundingId;

    @Column(name = "FUNDING_TYPE", nullable = false, length = 20)
    private String fundingType;

    @Column(name = "TOTAL_AMOUNT", nullable = false)
    private Double totalAmount;

    @Column(name = "FINAL_CURRENCY", nullable = false, length = 3)
    private String finalCurrency;

    @Column(name = "FUNDING_DATE", nullable = false)
    private LocalDate fundingDate;
}

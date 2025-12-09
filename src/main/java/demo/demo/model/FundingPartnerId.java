package demo.demo.model;

import java.io.Serializable;
import lombok.Data;

@Data
public class FundingPartnerId implements Serializable {
    private Long fundingId;
    private Long partnerId;
}

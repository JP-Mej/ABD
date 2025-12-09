package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "PARTNER")
@Data
public class Partner {

    @Id
    @Column(name = "PARTNER_ID")
    private Long partnerId;

    @Column(name = "NAME_PARTNER", nullable = false, length = 50)
    private String namePartner;

    @Column(name = "PARTNER_TYPE", nullable = false, length = 20)
    private String partnerType;

    @Column(name = "COUNTRY", nullable = false, length = 10)
    private String country;

    @Column(name = "CONTACT_EMAIL_P", nullable = false, length = 35)
    private String contactEmailP;
}

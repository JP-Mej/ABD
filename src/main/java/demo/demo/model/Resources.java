package demo.demo.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "RESOURCES")
@Data
public class Resources {

    @Id
    @Column(name = "RESOURCE_ID")
    private Long resourceId;

    @Column(name = "TITLE", nullable = false, length = 30)
    private String title;

    @Column(name = "RESOURCE_TYPE", nullable = false, length = 20)
    private String resourceType;

    @Column(name = "AUTHOR", nullable = false, length = 50)
    private String author;

    @Column(name = "PUBLISH_DATE", nullable = false)
    private LocalDate publishDate;

    @Column(name = "URL", nullable = false, length = 200)
    private String url;

    @Column(name = "LANGUAGE", nullable = false, length = 20)
    private String language;
}

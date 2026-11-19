package org.sasanlabs.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.sql.DataSource;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AccountLookupController {
    private final DataSource dataSource;

    public AccountLookupController(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    @GetMapping("/accounts")
    public String findAccount(@RequestParam String id) throws Exception {
        try (Connection conn = dataSource.getConnection();
             Statement stmt = conn.createStatement();
             // Deliberately vulnerable: the id is pasted straight into the SQL
             ResultSet rs = stmt.executeQuery("SELECT name FROM accounts WHERE id = '" + id + "'")) {
            return rs.next() ? rs.getString("name") : "not found";
        }
    }
}

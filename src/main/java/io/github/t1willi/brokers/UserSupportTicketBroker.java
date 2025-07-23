package io.github.t1willi.brokers;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Optional;

import io.github.t1willi.database.RestBroker;
import io.github.t1willi.entities.UserSupportTicket;
import io.github.t1willi.injector.annotation.Bean;

@Bean
public class UserSupportTicketBroker extends RestBroker<Integer, UserSupportTicket> {

    public UserSupportTicketBroker() {
        super("user_support_ticket", UserSupportTicket.class, int.class);
    }

    public boolean isIpAllowedToSubmitTicket(String ipAddress) {
        Optional<UserSupportTicket> ticketOpt = selectOne("SELECT * FROM " + table + " WHERE ip_address = ?",
                ipAddress);
        if (ticketOpt.isEmpty()) {
            return true; // No existing ticket for this IP, allow submission
        }
        UserSupportTicket ticket = ticketOpt.get();
        if (ticket.getCreatedAt().isAfter(ticket.getCreatedAt().plusHours(3))) {
            return true; // Ticket is older than 3 hours, allow submission
        }

        return false; // Ticket is still valid, deny submission
    }

    public LocalDateTime findTimeLeftToSubmitTicket(String ipAddress) {
        Optional<UserSupportTicket> ticketOpt = selectOne("SELECT * FROM " + table + " WHERE ip_address = ?",
                ipAddress);
        if (ticketOpt.isEmpty()) {
            return null;
        }
        UserSupportTicket ticket = ticketOpt.get();
        LocalDateTime createdAt = ticket.getCreatedAt();
        LocalDateTime now = LocalDateTime.now();
        long hoursPassed = Duration.between(createdAt, now).toHours();

        if (hoursPassed >= 3) {
            return null;
        }

        return createdAt.plusHours(3).minusHours(hoursPassed);
    }
}

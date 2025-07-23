package io.github.t1willi.utils;

import java.time.LocalDateTime;

import io.github.t1willi.context.JoltContext;

public class Helper {

    public static String getDomain(JoltContext ctx) {
        String scheme = ctx.rawRequest().getScheme();
        String serverName = ctx.rawRequest().getServerName();
        int serverPort = ctx.rawRequest().getServerPort();

        String domain;
        if ((scheme.equals("http") && serverPort == 80) || (scheme.equals("https") && serverPort == 443)) {
            domain = scheme + "://" + serverName;
        } else {
            domain = scheme + "://" + serverName + ":" + serverPort;
        }

        return domain;
    }

    public static String formatTimeToHMS(LocalDateTime time) {
        if (time == null) {
            return "00h 00m 00s";
        }

        long hours = time.getHour();
        long minutes = time.getMinute();
        long seconds = time.getSecond();

        return String.format("%02dh %02dm %02ds", hours, minutes, seconds);
    }
}

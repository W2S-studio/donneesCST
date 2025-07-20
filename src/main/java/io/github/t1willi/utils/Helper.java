package io.github.t1willi.utils;

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
}

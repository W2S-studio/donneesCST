package io.github.t1willi;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import io.github.t1willi.core.JoltApplication;
import io.github.t1willi.openapi.annotations.OpenApi;
import io.github.t1willi.utils.Flash;

@OpenApi
public class Main extends JoltApplication {

    public static void main(String[] args) {
        launch(Main.class);
    }

    public void init() {
        get("/api/health", ctx -> {
            Map<String, Object> response = new LinkedHashMap<>();
            response.put("status", "OK");
            response.put("message", "Jolt-Api est en cours d'exécution");
            response.put("Endpoints", getApiOnlyRegisteredRoutes(router.getRegisteredRoutes().stream()));
            return ctx.json(response);
        });

        get("/*", ctx -> {
            Flash.warning("La page demandée n'existe pas");
            return ctx.redirect("/");
        });
    }

    private List<String> getApiOnlyRegisteredRoutes(Stream<String> streamRoutes) {
        return streamRoutes.filter(route -> route.contains("/api/")).toList();
    }
}
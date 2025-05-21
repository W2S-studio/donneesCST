package io.github.t1willi.configuration;

import io.github.t1willi.injector.annotation.Configuration;
import io.github.t1willi.injector.type.ConfigurationType;
import io.github.t1willi.template.TemplateConfiguration;
import io.github.t1willi.template.engines.FreemarkerTemplateEngine;
import jakarta.annotation.PostConstruct;

@Configuration(value = ConfigurationType.TEMPLATE)
public class TemplateConfig extends TemplateConfiguration {

    @PostConstruct
    public void init() {
        // No-Op
    }

    @Override
    public void configure() {
        setTemplateClasspath("/templates");
        setCaching(false);
        setEngine(new FreemarkerTemplateEngine());
    }
}

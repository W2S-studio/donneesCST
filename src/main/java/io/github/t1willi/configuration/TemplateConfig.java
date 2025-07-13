package io.github.t1willi.configuration;

import io.github.t1willi.injector.annotation.Configuration;
import io.github.t1willi.template.TemplateConfiguration;
import io.github.t1willi.template.engines.FreemarkerTemplateEngine;

@Configuration
public class TemplateConfig extends TemplateConfiguration {

    @Override
    public void configure() {
        setTemplateClasspath("/templates");
        setCaching(false);
        setEngine(new FreemarkerTemplateEngine());
    }
}

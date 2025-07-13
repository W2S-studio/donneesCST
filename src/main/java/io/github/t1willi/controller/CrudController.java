package io.github.t1willi.controller;

import java.lang.reflect.ParameterizedType;
import java.util.List;

import io.github.t1willi.annotations.Get;
import io.github.t1willi.annotations.Path;
import io.github.t1willi.database.RestBroker;

public abstract class CrudController<T, ID, R extends RestBroker<ID, T>> {

    @Get
    public List<T> getAll() {
        return getBroker().findAll();
    }

    @Get("{id}")
    public T getOne(@Path ID id) {
        return getBroker().findById(id).orElse(null);
    }

    @SuppressWarnings("unchecked")
    public R getBroker() {
        try {
            ParameterizedType parameterizedType = (ParameterizedType) getClass().getGenericSuperclass();
            Class<R> clazz = (Class<R>) parameterizedType.getActualTypeArguments()[1];
            return clazz.getDeclaredConstructor().newInstance();
        } catch (Exception e) {
            throw new RuntimeException("Could not instantiate broker: " + e.getMessage(), e);
        }
    }
}

package module.core.annotation;

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Column {

    String name();

    boolean id() default false;
    
    boolean autoId() default true;
}

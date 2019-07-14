package app.hypermedia.testing.dsl.tests.conversion;

import app.hypermedia.testing.dsl.conversion.VariableReferenceConverter;
import static org.assertj.core.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class VariableReferenceConverterTest {
    private VariableReferenceConverter converter;
    
    @BeforeEach
    public void BeforEach() {
        converter = new VariableReferenceConverter();
    }
    
    @Test
    public void convertingParsedVariable_returnsTextWithinBrackets() {
        // when
        String value = converter.toValue("[variable]", null);
        
        // then
        assertThat(value).isEqualTo("variable");
    }
    
    @Test
    public void convertingNull_returnsNull() {
        // when
        String value = converter.toValue(null, null);
        
        // then
        assertThat(value).isNull();
    }
    
    @Test
    public void toString_returnValueWithBrackets() {
        // when
        String value = converter.toString("variable");
        
        // then
        assertThat(value).isEqualTo("[variable]");
    }
    
    @ParameterizedTest
    @ValueSource(strings = { "", "[", "[unclosed", "noBracket", "closeOnly]" })
    public void convertIncompleteValue_throws(String value) {
        assertThatThrownBy(() -> {
            converter.toValue(value, null);
        });
    }
}
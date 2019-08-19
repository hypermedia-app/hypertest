package app.hypermedia.testing.dsl.tests.core

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import app.hypermedia.testing.dsl.core.RepresentationConstraint
import static org.assertj.core.api.Assertions.*
import app.hypermedia.testing.dsl.core.PropertyConstraint
import app.hypermedia.testing.dsl.core.CustomCondition
import app.hypermedia.testing.dsl.core.StringCondition
import app.hypermedia.testing.dsl.core.IntCondition
import app.hypermedia.testing.dsl.core.BooleanCondition
import app.hypermedia.testing.dsl.core.RegexCondition

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class PropertyConstraintTest {
    @Inject extension app.hypermedia.testing.dsl.tests.ParseHelper<RepresentationConstraint>
    
    @Test
    def void condition_ParsesPropertyEqualsString() {
        val result = 'When Property "Foo" Equals "Bar"'.parse(PropertyConstraint)

        val constraint = result.assertNoErrors
        
        // then
        assertThat(constraint.name.value).isEqualTo('Foo')
        assertThat(constraint.condition).isInstanceOf(StringCondition)
    }

    @Test
    def void condition_ParsesPropertyLessThanInt() {
        val result = 'When Property "Bar" Less Than Or Equal 10'.parse(PropertyConstraint)
        
        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.name.value).isEqualTo('Bar')
        assertThat(constraint.condition).isInstanceOf(IntCondition)
    }

    @Test
    def void condition_ParsesPropertyEqualsBoolean() {
        val result = 'When Property "Bar" Equals true'.parse(PropertyConstraint)
        
        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.name.value).isEqualTo('Bar')
        assertThat(constraint.condition).isInstanceOf(BooleanCondition)
    }

    @Test
    def void condition_ParsesPropertyRegexMatch() {
        val result = 'When Property "uri" Matches "^https://"'.parse(PropertyConstraint)
        
        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.name.value).isEqualTo('uri')
        assertThat(constraint.condition).isInstanceOf(RegexCondition)
    }

    @Test
    def void condition_ParsesNegatedPropertyRegexMatch() {
        val result = 'When Property "uri" Not Matches "^https://"'.parse(PropertyConstraint)
        
        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.name.value).isEqualTo('uri')
        assertThat(constraint.negation).isNotNull()
        val regex = constraint.condition as RegexCondition
        assertThat(regex.value).isEqualTo("^https://")
    }

    @Test
    def void condition_ParsesPropertyWithCustomCode() {
        val result = '''When Property "age" => 
                ```
                age => age > 20 && age < 30
                ```
        '''.parse(PropertyConstraint)
        
        val constraint = result.assertNoErrors

        // then
        val operator = constraint.condition as CustomCondition
        assertThat(operator.value).isEqualTo('age => age > 20 && age < 30')
    }
}

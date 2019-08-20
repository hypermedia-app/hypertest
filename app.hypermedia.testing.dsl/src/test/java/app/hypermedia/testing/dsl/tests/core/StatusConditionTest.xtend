package app.hypermedia.testing.dsl.tests.core

import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import static org.assertj.core.api.Assertions.*
import app.hypermedia.testing.dsl.core.IntCondition
import app.hypermedia.testing.dsl.core.CustomCondition
import app.hypermedia.testing.dsl.core.ResponseConstraint
import app.hypermedia.testing.dsl.core.StatusConstraint

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class StatusConditionTest {
    @Inject extension app.hypermedia.testing.dsl.tests.ParseHelper<ResponseConstraint>

    @Test
    def void condition_ParsesStatusEquals() {
        val result = 'When Status Equals 200'.parse(StatusConstraint)

        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.condition).isInstanceOf(IntCondition)
        val operator = (constraint.condition as IntCondition).operator
        assertThat(operator).isEqualTo('Equals')
    }

    @Test
    def void condition_ParsesStatusLessThan() {
        val result = 'When Status Greater Than 200'.parse(StatusConstraint)

        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.condition).isInstanceOf(IntCondition)
        val operator = (constraint.condition as IntCondition).operator
        assertThat(operator).isEqualTo('Greater Than')
    }

    @Test
    def void condition_ParsesStatusCustomCondition() {
        val result = 'When Status => ```status === 404 || status === 409```'.parse(StatusConstraint)

        val constraint = result.assertNoErrors

        // then
        assertThat(constraint.condition).isInstanceOf(CustomCondition)
        val operator = constraint.condition as CustomCondition
        assertThat(operator.value).isEqualTo('status === 404 || status === 409')
    }
}

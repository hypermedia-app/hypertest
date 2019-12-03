package app.hypermedia.testing.dsl.tests.hydra

import static org.assertj.core.api.Assertions.*
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.InjectWith
import app.hypermedia.testing.dsl.tests.HydraInjectorProvider
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import com.google.inject.Inject
import app.hypermedia.testing.dsl.hydra.HydraScenario
import app.hypermedia.testing.dsl.core.EntrypointStep
import org.junit.jupiter.api.Test
import app.hypermedia.testing.dsl.tests.TestHelpers

@ExtendWith(InjectionExtension)
@InjectWith(HydraInjectorProvider)
class EntrypointParsingTest {
    @Inject extension ParseHelper<HydraScenario>

    @Test
    def void multipleEntrypointStatements_triggersValidationWarning_lastWins() {
        // when
        val result = '''
            ENTRYPOINT "path/to/resource"
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val entrypoint = result.entrypoint as EntrypointStep
        assertThat(entrypoint.path).isEqualTo('path/to/resource')
    }
}
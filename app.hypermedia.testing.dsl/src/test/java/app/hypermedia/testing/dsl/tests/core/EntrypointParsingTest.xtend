package app.hypermedia.testing.dsl.tests.core

import static org.assertj.core.api.Assertions.*
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.InjectWith
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import com.google.inject.Inject
import app.hypermedia.testing.dsl.core.CoreScenario
import app.hypermedia.testing.dsl.core.EntrypointStep
import org.junit.jupiter.api.Test
import app.hypermedia.testing.dsl.tests.TestHelpers

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class EntrypointParsingTest {
    @Inject extension ParseHelper<CoreScenario>

    @Test
    def void multipleEntrypointStatements_triggersValidationWarning_lastWins() {
        // when
        val result = '''
            ENTRYPOINT "movies/rocky-iv"
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val entrypoint = result.entrypoint as EntrypointStep
        assertThat(entrypoint.path).isEqualTo('movies/rocky-iv')
    }
}
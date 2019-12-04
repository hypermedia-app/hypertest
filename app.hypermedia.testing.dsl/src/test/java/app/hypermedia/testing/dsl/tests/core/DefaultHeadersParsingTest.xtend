package app.hypermedia.testing.dsl.tests.core

import static org.assertj.core.api.Assertions.*
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.InjectWith
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import com.google.inject.Inject
import app.hypermedia.testing.dsl.core.CoreScenario
import org.junit.jupiter.api.Test
import app.hypermedia.testing.dsl.tests.TestHelpers
import org.assertj.core.api.Condition
import app.hypermedia.testing.dsl.core.RequestHeader

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class DefaultHeadersParsingTest {
    @Inject extension ParseHelper<CoreScenario>

    @Test
    def void headerBlock_parserDefaultHeaders() {
        // when
        val result = '''
            HEADERS {
              Authorization "some token"
              User-Agent "Googlebot"
            }
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val headers = result.defaultHeaders
        assertThat(headers.headers).hasSize(2)
        assertThat(headers.headers).haveExactly(1, headerMatching("Authorization", "some token"))
        assertThat(headers.headers).haveExactly(1, headerMatching("User-Agent", "Googlebot"))
    }

    private def headerMatching(String name, String value) {
      new Condition<RequestHeader>([ header |
          name.equals(header.fieldName) && value.equals(header.value)
        ], "matching header")
    }
}
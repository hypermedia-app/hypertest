/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.tests.hydra

import app.hypermedia.testing.dsl.hydra.HydraScenario
import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import app.hypermedia.testing.dsl.tests.HydraInjectorProvider
import static org.assertj.core.api.Assertions.*
import app.hypermedia.testing.dsl.tests.TestHelpers
import app.hypermedia.testing.dsl.hydra.TemplatedLinkBlock
import app.hypermedia.testing.dsl.core.ClassBlock
import app.hypermedia.testing.dsl.core.RelaxedLinkBlock

@ExtendWith(InjectionExtension)
@InjectWith(HydraInjectorProvider)
class LinkParsingTest {
    @Inject extension ParseHelper<HydraScenario>

    @Test
    def void topLevelLink_ParsesSuccessfully() {
        // when
        val result = '''
            With Link <http://example.com/search> {
                Expect Status 200
            }
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val linkBlock = result.steps.get(0) as RelaxedLinkBlock
        assertThat(linkBlock.relation.value).isEqualTo("http://example.com/search")
        assertThat(linkBlock.children).hasSize(1)
    }

    @Test
    def void templatedLink_ParsesSuccessfully() {
        // when
        val result = '''
            With Class <http://example.com/Users> {
                With Link <http://example.com/search> (
                    <http://schema.org/name> = "Tomasz"
                ) {
                    Expect Status 200
                }
            }
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val linkBlock = classBlock.children.get(0) as TemplatedLinkBlock
        assertThat(linkBlock.relation.value).isEqualTo("http://example.com/search")
        assertThat(linkBlock.children).hasSize(1)
        assertThat(linkBlock.templateVariables).hasSize(1)
    }

    @Test
    def void templatedLinkWithPrefix_ParsesSuccessfully() {
        // when
        val result = '''
            PREFIX schema: <http://schema.org/>

            With Class <http://example.com/Users> {
                With Link <http://example.com/search> (
                    schema:name = "Tomasz"
                ) {
                    Expect Status 200
                }
            }
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val linkBlock = classBlock.children.get(0) as TemplatedLinkBlock
        assertThat(linkBlock.relation.value).isEqualTo("http://example.com/search")
        assertThat(linkBlock.children).hasSize(1)
        assertThat(linkBlock.templateVariables).hasSize(1)
    }
}

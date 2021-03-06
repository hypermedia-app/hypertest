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
import app.hypermedia.testing.dsl.hydra.OperationBlock
import app.hypermedia.testing.dsl.core.StatusStatement

@ExtendWith(InjectionExtension)
@InjectWith(HydraInjectorProvider)
class InvokeParsingTest {
    @Inject extension
    ParseHelper<HydraScenario> parseHelper

    @Test
    def void invokeWithHeaders_parsesHeadersSuccessfully() {
        // when
        val result = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    Content-Type "text/turtle"
                    ETag 'W/"<etag_value>"'
                } => {
                    Expect Status 405
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val operationBlock = result.steps.get(0) as OperationBlock
        val invocation = operationBlock.invocations.get(0)
        assertThat(invocation.request.headers).hasSize(2)
        assertThat(invocation.request.headers.get(0).fieldName).isEqualTo('Content-Type')
        assertThat(invocation.request.headers.get(1).fieldName).isEqualTo('ETag')
        assertThat(invocation.request.headers.get(0).value).isEqualTo('text/turtle')
        assertThat(invocation.request.headers.get(1).value).isEqualTo('W/"<etag_value>"')
    }

    @Test
    def void invokeWithInlineBody_parsesBodyContentsSuccessfully() {
        // when
        val result = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    ```
                    <> a api:Person .
                    ```
                } => {
                    Expect Status 405
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val operationBlock = result.steps.get(0) as OperationBlock
        val invocation = operationBlock.invocations.get(0)
        assertThat(invocation.request.body.contents).contains('<> a api:Person .')
    }

    @Test
    def void invokeWithBodyFromFile_parsesPathSuccessfully() {
        // when
        val result = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    <<< "../../sample-bodies/data.csv"
                } => {
                    Expect Status 405
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val operationBlock = result.steps.get(0) as OperationBlock
        val invocation = operationBlock.invocations.get(0)
        assertThat(invocation.request.body.reference.path).isEqualTo('../../sample-bodies/data.csv')
    }

    @Test
    def void invokeWithBodyFromFile_parsesResponeBlock() {
        // when
        val result = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    <<< "../../sample-bodies/data.csv"
                } => {
                    Expect Status 405
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val operationBlock = result.steps.get(0) as OperationBlock
        val invocation = operationBlock.invocations.get(0)
        assertThat(invocation.response.children).hasSize(1)
        val statusStatement = invocation.response.children.get(0) as StatusStatement
        assertThat(statusStatement.status).isEqualTo(405)
    }
}

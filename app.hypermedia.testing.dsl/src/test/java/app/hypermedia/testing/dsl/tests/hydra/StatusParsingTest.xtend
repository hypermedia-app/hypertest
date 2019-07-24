/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.tests.hydra

import app.hypermedia.testing.dsl.core.Model
import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.^extension.ExtendWith
import static org.assertj.core.api.Assertions.*
import app.hypermedia.testing.dsl.tests.HydraInjectorProvider
import app.hypermedia.testing.dsl.tests.TestHelpers
import app.hypermedia.testing.dsl.hydra.RelaxedOperationBlock
import app.hypermedia.testing.dsl.core.StatusStatement
import org.junit.jupiter.params.provider.MethodSource
import org.junit.jupiter.params.ParameterizedTest
import app.hypermedia.testing.dsl.hydra.InvocationBlock
import app.hypermedia.testing.dsl.core.CorePackage
import org.eclipse.xtext.testing.validation.ValidationTestHelper

@ExtendWith(InjectionExtension)
@InjectWith(HydraInjectorProvider)
class StatusParsingTest {
    @Inject extension ParseHelper<Model>
    @Inject extension ValidationTestHelper

    @ParameterizedTest
    @MethodSource("validStatuses")
    def void expectStatus_parsesSuccessfullyUnderInvoke(int status) {
        // when
        val result = '''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    Expect Status «status»
                }
            }
        '''.parse

        // then
        TestHelpers.assertModelParsedSuccessfully(result)
        
        val operationBlock = result.steps.get(0) as RelaxedOperationBlock
        val invocationBlock = operationBlock.invocations.get(0) as InvocationBlock
        val statusBlock = invocationBlock.children.get(0) as StatusStatement
        assertThat(statusBlock.status).isEqualTo(status)
    }

    @ParameterizedTest
    @MethodSource("invalidStatuses")
    def void expectStatus_failsToParseBogusStatus(int status) {
        // when
        val result = '''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    Expect Status «status»
                }
            }
        '''.parse

        // then
        result.assertError(
            CorePackage.Literals.STATUS_STATEMENT,
            null,
            "Status can be an integer between 100 and 599"
        )
    }
    
    static def invalidStatuses() {
        return #[
            1000,
            600,
            -10,
            0,
            99
        ]
    } 
    
    static def validStatuses() {
        return #[
            100, 201, 404, 599
        ]
    } 
}

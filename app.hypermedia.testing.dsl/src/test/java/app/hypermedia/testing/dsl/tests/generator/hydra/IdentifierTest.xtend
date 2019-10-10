package app.hypermedia.testing.dsl.tests.generator.hydra

import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import app.hypermedia.testing.dsl.hydra.HydraScenario
import org.junit.jupiter.api.Test
import static io.github.jsonSnapshot.SnapshotMatcher.*
import org.eclipse.xtext.generator.IGenerator2
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.AfterAll
import org.json.JSONObject
import app.hypermedia.testing.dsl.tests.HydraInjectorProvider
import org.eclipse.xtext.generator.GeneratorContext

@ExtendWith(InjectionExtension)
@InjectWith(HydraInjectorProvider)
class IdentifierTest {
    @Inject IGenerator2 generator
    @Inject extension ParseHelper<HydraScenario>
    @BeforeAll
    static def beforeAll() {
        start()
    }

    @AfterAll
    static def afterAll() {
        validateSnapshots();
    }

    @Test
    def expectType_generatesStep() {
        // given
        val model = '''
            With Class <http://example.com/CreateUser> {
                Expect Id <http://example.com/NewUser>
            }
        '''.parse

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }

    @Test
    def expectTypeWithPrefix_generatesStep() {
        // given
        val model = '''
            PREFIX ex: <http://example.com/>

            With Class ex:CreateUser {
                Expect Id ex:NewUser
            }
        '''.parse

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }
}

package app.hypermedia.testing.dsl.tests.generator.hydra

import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import app.hypermedia.testing.dsl.core.Model
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
class FollowTest {
    @Inject IGenerator2 generator
    @Inject extension ParseHelper<Model>

    @BeforeAll
    static def beforeAll() {
        start()
    }

    @AfterAll
    static def afterAll() {
        validateSnapshots();
    }

    @Test
    def followVariable_generatesStep() {
        // given
        val model = '''
            With Operation "http://example.com/vocab#CreateIssueOperation" {
                Invoke {
                    Expect Status 201
                    Expect Header Location [newIssue]

                    Follow [newIssue]
                }
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
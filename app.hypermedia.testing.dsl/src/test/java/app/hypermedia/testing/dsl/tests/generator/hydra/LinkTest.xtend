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
class LinkTest {
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
    def canGenerateForTemplatedLink() {
        // given
        val model = '''
            With Class <http://example.com/People> {
                With Link <http://example.com/search> (
                    <http://example.com/from> = "2010-12-12"
                    <http://example.com/to> = "2011-12-12"
                ) {
                    Expect Property <http://example.com/count> 5
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

    @Test
    def canGenerateForTemplatedLinkWithPrefix() {
        // given
        val model = '''
            PREFIX ex: <http://example.com/>

            With Class ex:People {
                With Link ex:search (
                    ex:from = "2010-12-12"
                    ex:to = "2011-12-12"
                ) {
                    Expect Property <http://example.com/count> 5
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

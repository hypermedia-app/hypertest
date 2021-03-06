package app.hypermedia.testing.dsl.tests.generator.core

import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.InjectWith
import com.google.inject.Inject
import org.eclipse.xtext.testing.util.ParseHelper
import app.hypermedia.testing.dsl.core.CoreScenario
import org.junit.jupiter.api.Test
import static io.github.jsonSnapshot.SnapshotMatcher.*
import org.eclipse.xtext.generator.IGenerator2
import org.junit.jupiter.api.BeforeAll
import org.junit.jupiter.api.AfterAll
import org.json.JSONObject
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider
import org.eclipse.xtext.generator.GeneratorContext

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class PropertyTest {
    @Inject IGenerator2 generator
    @Inject ParseHelper<CoreScenario> parseHelper
    @BeforeAll
    static def beforeAll() {
        start()
    }

    @AfterAll
    static def afterAll() {
        validateSnapshots();
    }

    @Test
    def withProperty_generatesNonStrictPropertyStep() {
        // given
        val model = parseHelper.parse('''
            With Class "Person" {
                With Property "author" {

                }
            }
        ''')

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }

    @Test
    def expectProperty_generatesStrictPropertyStep() {
        // given
        val model = parseHelper.parse('''
            With Class "Person" {
                Expect Property "author" {

                }
            }
        ''')

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }

    @Test
    def expectPropertyValue_generatesValue() {
        // given
        val model = parseHelper.parse('''
            With Class "Person" {
                Expect Property "name" "Tomasz"
            }
        ''')

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }

    @Test
    def expectNonStringValues_generatesValue() {
        // given
        val model = parseHelper.parse('''
            With Class "Person" {
                Expect Property "age" 21
                Expect Property "salary" 12.5
                Expect Property "employed" true
            }
        ''')

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }

    @Test
    def utf8Values_generatesCorrectOutput() {
        // given
        val model = parseHelper.parse('''
            With Class "Zwierzę" {
                Expect Property "name" "Łabędź"
            }
        ''')

        // when
        val fsa = new InMemoryFileSystemAccess()
        generator.doGenerate(model.eResource, fsa, new GeneratorContext())
        println(fsa.textFiles)

        // then
        val file = new JSONObject(fsa.textFiles.values.get(0).toString)
        expect(file).toMatchSnapshot()
    }
}

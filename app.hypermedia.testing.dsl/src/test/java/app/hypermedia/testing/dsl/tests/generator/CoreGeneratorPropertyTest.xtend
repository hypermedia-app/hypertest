package app.hypermedia.testing.dsl.tests.generator

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
import app.hypermedia.testing.dsl.tests.CoreInjectorProvider

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class CoreGeneratorPropertyTest {
    @Inject IGenerator2 generator
    @Inject ParseHelper<Model> parseHelper
    
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
}
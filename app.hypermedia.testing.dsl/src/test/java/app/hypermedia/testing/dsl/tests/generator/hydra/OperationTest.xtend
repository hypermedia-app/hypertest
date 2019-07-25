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
class OperationTest {
    @Inject IGenerator2 generator
    @Inject ParseHelper<HydraScenario> parseHelper
    
    @BeforeAll
    static def beforeAll() {
        start()
    }

    @AfterAll
    static def afterAll() {
        validateSnapshots();
    }

    @Test
    def emptyWithOperationTopLevel_generatesStep() {
        // given
        val model = parseHelper.parse('''
            With Operation <http://example.com/CreateUser>" {
                
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
    def topLevelOperationMultipleInvocations_generatesStep() {
        // given
        val model = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                }
                
                Invoke {
                }
                
                Invoke {
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
    def topLevelOperationInvocationWithStatusExpectation_generatesSteps() {
        // given
        val model = parseHelper.parse('''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    Expect Status 201
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
    def classAndOperationWithPrefixes_generatesFullyQualifiedUris() {
        // given
        val model = parseHelper.parse('''
            PREFIX test: <http://example.com/>

            With Operation test:CreateUser {
                Invoke {
                    Expect Status 201
                }
            }
            
            With Class test:User {
                With Operation test:Delete {
                    Invoke {
                    }
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
}
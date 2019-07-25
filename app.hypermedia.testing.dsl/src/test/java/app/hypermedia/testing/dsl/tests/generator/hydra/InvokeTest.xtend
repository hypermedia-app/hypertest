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
class InvokeTest {
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
    def topLevelOperation_invokeTwiceWithRequests_generatesSteps() {
        // given
        val model = '''
            With Operation <http://example.com/CreateUser> {
                Invoke {
                    Content-Type "text/csv"
                    
                    <<< "/some/path/data.csv"
                } => {
                    Expect Status 201
                }
                
                Invoke {
                    Content-Type "application/json"
                    
                    ```
                    {
                        "hello": "world",
                        "foo": "bar"
                    }
                    ```
                } => {
                    Expect Status 409
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
    def classOperation_invokeTwiceWithRequests_generatesSteps() {
        // given
        val model = '''
            With Class <http://example.com/People> {
                With Operation <http://example.com/CreateUser> {
                    Invoke {
                        Content-Type "text/csv"
                        
                        <<< "/some/path/data.csv"
                    } => {
                        Expect Status 201
                    }
                    
                    Invoke {
                        Content-Type "application/json"
                        
                        ```
                        {
                            "hello": "world",
                            "foo": "bar"
                        }
                        ```
                    } => {
                        Expect Status 409
                    }
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
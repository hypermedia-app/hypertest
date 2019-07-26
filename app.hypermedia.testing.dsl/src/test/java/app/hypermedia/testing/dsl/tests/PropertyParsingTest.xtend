/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.tests

import app.hypermedia.testing.dsl.core.ClassBlock
import app.hypermedia.testing.dsl.core.CoreScenario
import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import app.hypermedia.testing.dsl.core.PropertyBlock
import app.hypermedia.testing.dsl.core.PropertyStatement
import static org.assertj.core.api.Assertions.*;

@ExtendWith(InjectionExtension)
@InjectWith(CoreInjectorProvider)
class PropertyParsingTest {
    @Inject
    ParseHelper<CoreScenario> parseHelper

    @Test
    def void withProperty_parsesName() {
        // when
        val result = parseHelper.parse('''
            With Class "Person" {
                With Property "name" {
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val propertyBlock = classBlock.classChildren.get(0) as PropertyBlock
        assertThat(propertyBlock.name.value).isEqualTo("name")
    }

    @Test
    def void expectProperty_parsesWithoutChildren() {
        // when
        val result = parseHelper.parse('''
            With Class "Person" {
                Expect Property "name"
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val propertyStmt = classBlock.classChildren.get(0) as PropertyStatement
        assertThat(propertyStmt.name.value).isEqualTo("name")
    }

    @Test
    def void expectProperty_parsesOptionalValueToAssert() {
        // when
        val result = parseHelper.parse('''
            With Class "Person" {
                Expect Property "name" "TOMASZ"
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val propertyStmt = classBlock.classChildren.get(0) as PropertyStatement
        assertThat(propertyStmt.value).isEqualTo("TOMASZ")
    }

    @Test
    def void withProperty_parsedSuccessfullyWithChildren() {
        // when
        val result = parseHelper.parse('''
            With Class "Book" {
                With Property "author" {
                    Expect Property "name"
                }
            }
        ''')

        // then
        TestHelpers.assertModelParsedSuccessfully(result)

        val classBlock = result.steps.get(0) as ClassBlock
        val propertyBlock = classBlock.classChildren.get(0) as PropertyBlock
        assertThat(propertyBlock.children.length).isEqualTo(1)
        assertThat(propertyBlock.children.get(0)).isInstanceOf(PropertyStatement)
    }

    @Test
    def void withProperty_parsingFailsWhenItHasNoChildren() {
        // when
        val result = parseHelper.parse('''
            With Class "Book" {
                With Property "author"
            }
        ''')

        // then
        TestHelpers.assertModelParsingFailed(result)
    }
}

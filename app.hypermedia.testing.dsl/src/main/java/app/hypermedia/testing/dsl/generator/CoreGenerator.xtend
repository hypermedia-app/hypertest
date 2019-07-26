/*
 * generated by Xtext 2.17.0
 */
package app.hypermedia.testing.dsl.generator

import app.hypermedia.testing.dsl.core.ClassBlock
import app.hypermedia.testing.dsl.core.TopLevelStep
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import app.hypermedia.testing.dsl.core.PropertyBlock
import app.hypermedia.testing.dsl.core.PropertyStatement
import org.apache.commons.lang3.NotImplementedException
import org.eclipse.emf.ecore.EObject
import app.hypermedia.testing.dsl.Modifier
import app.hypermedia.testing.dsl.core.StatusStatement
import app.hypermedia.testing.dsl.core.RelaxedLinkBlock
import app.hypermedia.testing.dsl.core.StrictLinkBlock
import app.hypermedia.testing.dsl.core.LinkStatement
import app.hypermedia.testing.dsl.core.HeaderStatement
import org.json.JSONObject
import org.json.JSONArray
import java.util.Map
import java.util.HashMap
import app.hypermedia.testing.dsl.core.FollowStatement
import app.hypermedia.testing.dsl.core.Identifier
import app.hypermedia.testing.dsl.core.CoreScenario
import org.eclipse.emf.common.util.EList

/**
 * Generates code from your model files on save.
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class CoreGenerator extends AbstractGenerator {
    final static int INDENTATION = 2

    override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {

        val Iterable<TopLevelStep> blocks = getSteps(resource.contents).toList

        if ( ! blocks.empty) {
            val String dslFileName = resource.getURI().lastSegment.toString();

            fsa.generateFile(dslFileName + '.json', generateSteps(blocks).toString(INDENTATION));
        }
    }

    def generateSteps(Iterable<TopLevelStep> blocks) {
        val scenario = new JSONObject();
        val steps = new JSONArray()

        for (block : blocks) {
            val stepJson = block.step
            steps.put(new JSONObject(stepJson.toString()))
        }

        scenario.put('steps', steps)
        return scenario
    }

    def buildBlock(String type, Iterable<? extends EObject> children, Map<String, Object> map) {
        map.put('children', children.map([c | c.step]).toList())

        return buildStatement(type, map)
    }

    def buildStatement(String type, Map<String, Object> map) {
        val step = new JSONObject(map)
        step.put('type', type)

        return step
    }

    def dispatch step(ClassBlock cb)  {
        val map = new HashMap<String, Object>
        map.put('classId', cb.name.identifier)

        return buildBlock('Class', cb.classChildren, map)
    }

    def dispatch step(PropertyBlock it) {
        val map = new HashMap<String, Object>
        map.put('propertyId', name.identifier)
        map.put('strict', modifier != Modifier.WITH)

        return buildBlock('Property', children, map)
    }

    def dispatch step(PropertyStatement it) {
        val map = new HashMap<String, Object>
        map.put('propertyId', name.identifier)
        map.put('strict', true)

        if(value !== null) {
            map.put('value', value)
        }

        return buildStatement('Property', map)
    }

    def dispatch step(StatusStatement it) {
        val map = new HashMap<String, Object>
        map.put('code', status)

        return buildStatement('ResponseStatus', map)
    }

    def dispatch step(RelaxedLinkBlock it) {
        val map = new HashMap<String, Object>
        map.put('rel', relation.identifier)
        map.put('strict', false)

        return buildBlock('Link', children, map)
    }

    def dispatch step(StrictLinkBlock it) {
        val map = new HashMap<String, Object>
        map.put('rel', relation.identifier)
        map.put('strict', true)

        return buildBlock('Link', children, map)
    }

    def dispatch step(LinkStatement it) {
        val map = new HashMap<String, Object>
        map.put('rel', relation.identifier)
        map.put('strict', true)

        return buildStatement('Link', map)
    }

    def dispatch step(HeaderStatement it) {
        val map = new HashMap<String, Object>
        map.put('header', fieldName)

        if (regex !== null) {
            map.put('pattern', regex.pattern)
        }

        if (exactValue !== null) {
            map.put('value', exactValue)
        }

        if (variable !== null) {
             map.put('captureAs', variable)
        }

        return buildStatement('ResponseHeader', map)
    }

    def dispatch step(FollowStatement it) {
        val map = new HashMap<String, Object>
        map.put('variable', variable)

        return buildStatement('Follow', map)
    }

    def dispatch step(EObject step) {
        throw new NotImplementedException(String.format("Unrecognized step %s", step.class))
    }

    def dispatch identifier(Identifier it) {
        return value
    }

    protected def getSteps(EList<EObject> s) {
        return s.filter(CoreScenario).flatMap[cs | cs.steps]
    }
}

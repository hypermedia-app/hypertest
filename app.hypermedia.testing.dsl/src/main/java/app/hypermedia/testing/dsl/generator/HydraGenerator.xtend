/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.generator

import app.hypermedia.testing.dsl.hydra.*
import app.hypermedia.testing.dsl.Modifier
import java.util.HashMap
import org.json.JSONObject
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.eclipse.emf.ecore.resource.Resource
import java.util.Map
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject

/**
 * Generates code from your model files on save.
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class HydraGenerator extends CoreGenerator {
final Map<String, String> _namespaces

    new () {
        _namespaces = new HashMap
    }

    override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
        resource.allContents.filter(NamespaceDeclaration).forEach[it | _namespaces.put(prefix.value, namespace)]

        super.doGenerate(resource, fsa, context)
    }

    protected override getScenarioSteps(EList<EObject> s) {
        return s.filter(HydraScenario).flatMap[hs | hs.steps]
    }

    protected override getEntrypointStep(EList<EObject> contents) {
        return contents
           .filter(HydraScenario)
           .map[s | s.entrypoint]
           .head
    }

    protected override getDefaultHeadersBlock(EList<EObject> contents) {
        return contents
           .filter(HydraScenario)
           .map[s | s.defaultHeaders]
           .head
    }

    def dispatch step(OperationBlock it) {
        val map = new HashMap<String, Object>
        map.put('operationId', name.identifier)
        map.put('strict', modifier != Modifier.WITH)

        return buildBlock('Operation', invocations, #[], map)
    }

    def dispatch step(InvocationBlock it) {
        val map = new HashMap<String, Object>

        if(request !== null) {
            if(request.headers.length > 0) {
                val headers = new JSONObject
                request.headers.forEach[header |
                    headers.put(header.fieldName, header.value)
                ]

                map.put('headers', headers)
            }

            if(request.body !== null) {
                if (request.body.reference !== null) {
                    val body = new JSONObject()
                    body.put('path', request.body.reference.path)
                    map.put('body', body)
                } else {
                    map.put('body', request.body.contents)
                }
            }
        }

        return buildBlock('Invocation', response.children, #[], map)
    }

    def dispatch identifier(UriName it) {
        return value
    }

    def dispatch step(RdfTypeStatement it) {
        val map = new HashMap<String, Object>
        map.put('propertyId', 'http://www.w3.org/1999/02/22-rdf-syntax-ns#type')
        map.put('strict', true)
        map.put('value', id.identifier)

        return buildStatement('Property', map)
    }

    def dispatch step(IdentifierStatement it) {
        val map = new HashMap<String, Object>
        map.put('value', id.identifier)

        return buildStatement('Identifier', map)
    }

    def dispatch identifier(PrefixedName it) {
        val pair = value.split(':')
        val prefix = pair.get(0)
        val term = pair.get(1)
        val namespace = _namespaces.get(prefix)

        if (namespace === null) {
            throw new IllegalStateException('''Unmapped prefix "«prefix»"''')
        }

        return '''«namespace»«term»'''
    }
}

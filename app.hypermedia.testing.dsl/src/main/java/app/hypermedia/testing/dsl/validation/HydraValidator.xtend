/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.validation

import app.hypermedia.testing.dsl.hydra.HydraPackage
import org.eclipse.xtext.validation.Check
import java.net.URI
import app.hypermedia.testing.dsl.hydra.NamespaceDeclaration
import app.hypermedia.testing.dsl.core.CorePackage
import java.net.URISyntaxException
import app.hypermedia.testing.dsl.core.ClassBlock
import app.hypermedia.testing.dsl.hydra.OperationBlock
import app.hypermedia.testing.dsl.hydra.RelaxedOperationBlock
import app.hypermedia.testing.dsl.hydra.PrefixedName

/**
 * This class contains custom validation rules. 
 *
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class HydraValidator extends AbstractHydraValidator {
    static final String INVALID_URI = 'Value is not a valid URI'
    
    @Check
    def checkValidUri(NamespaceDeclaration ns) {
        if (tryParseUri(ns.namespace) === false) {
            error(INVALID_URI,
                  HydraPackage.Literals.NAMESPACE_DECLARATION__NAMESPACE)
        }
    }
    
    @Check
    def checkValidUri(ClassBlock clas) {
        if (tryParseUri(clas.name.value) === false) {
            error(INVALID_URI,
                  CorePackage.Literals.CLASS_BLOCK__NAME
            )
        }
    }
    
    @Check
    def checkValidUri(OperationBlock clas) {
        if (tryParseUri(clas.name.value) === false) {
            error(INVALID_URI,
                  HydraPackage.Literals.OPERATION_BLOCK__NAME
            )
        }
    }
    
    @Check
    def checkValidUri(RelaxedOperationBlock clas) {
        if (tryParseUri(clas.name.value) === false) {
            error(INVALID_URI,
                  HydraPackage.Literals.RELAXED_OPERATION_BLOCK__NAME
            )
        }
    }
    
    @Check
    def checkNamespace(NamespaceDeclaration it) {
        if (!namespace.endsWith('#') && !namespace.endsWith('/') && !namespace.endsWith(':')) {
            warning("Namespaces usually end with hash (#), slash (/) or colon (:) characters",
                    HydraPackage.Literals.NAMESPACE_DECLARATION__NAMESPACE
            )
        }
    }
    
    private def tryParseUri(String uri) {
        try {
            val parsed = new URI(uri)
            return parsed.scheme !== null
        } catch(URISyntaxException e) {
            return false
        }
    }
}

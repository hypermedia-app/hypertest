package app.hypermedia.testing.dsl.tests

import org.eclipse.emf.ecore.EObject
import org.junit.jupiter.api.Assertions

public class TestHelpers {    
    static def assertModelParsedSuccessfully(EObject result) {
        Assertions.assertNotNull(result)
        val errors = result.eResource.errors
        Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
    }
    
    static def assertModelParsingFailed(EObject result) {
        Assertions.assertNotNull(result)
        val errors = result.eResource.errors
        Assertions.assertFalse(errors.isEmpty)
    }
}

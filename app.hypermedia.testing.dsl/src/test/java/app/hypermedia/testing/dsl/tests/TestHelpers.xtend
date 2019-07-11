package app.hypermedia.testing.dsl.tests

import app.hypermedia.testing.dsl.core.Model
import org.junit.jupiter.api.Assertions

class TestHelpers {
    static def assertModelParsedSuccessfully(Model result) {
        Assertions.assertNotNull(result)
        val errors = result.eResource.errors
        Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: «errors.join(", ")»''')
    }
    
    static def assertModelParsingFailed(Model result) {
        Assertions.assertNotNull(result)
        val errors = result.eResource.errors
        Assertions.assertFalse(errors.isEmpty)
    }
}

/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl.ide

import app.hypermedia.testing.dsl.HydraRuntimeModule
import app.hypermedia.testing.dsl.HydraStandaloneSetup
import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2

/**
 * Initialization support for running Xtext languages as language servers.
 */
class HydraIdeSetup extends HydraStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new HydraRuntimeModule, new HydraIdeModule))
	}
	
}

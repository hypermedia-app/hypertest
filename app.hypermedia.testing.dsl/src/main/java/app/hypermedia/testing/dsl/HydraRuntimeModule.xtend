/*
 * generated by Xtext 2.18.0
 */
package app.hypermedia.testing.dsl

import app.hypermedia.testing.dsl.conversion.HydraValueConverterService
import org.eclipse.xtext.conversion.IValueConverterService
import com.google.inject.Binder
import org.eclipse.xtext.parser.IEncodingProvider
import org.eclipse.xtext.service.DispatchingProvider

/**
 * Use this class to register components to be used at runtime / without the Equinox extension registry.
 */
class HydraRuntimeModule extends AbstractHydraRuntimeModule {
    override Class<? extends IValueConverterService> bindIValueConverterService() {
        return HydraValueConverterService
    }

    override configureRuntimeEncodingProvider(Binder binder) {
        binder.bind(IEncodingProvider)
              .annotatedWith(DispatchingProvider.Runtime)
              .to(AlwaysUtfEncodingProvider)
    }

}

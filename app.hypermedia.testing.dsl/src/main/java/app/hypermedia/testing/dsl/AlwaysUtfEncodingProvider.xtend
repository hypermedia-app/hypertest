package app.hypermedia.testing.dsl

import org.eclipse.xtext.parser.EclipseProjectPropertiesEncodingProvider

class AlwaysUtfEncodingProvider extends EclipseProjectPropertiesEncodingProvider {

    override getDefaultEncoding() {
        return 'UTF-8'
    }

}
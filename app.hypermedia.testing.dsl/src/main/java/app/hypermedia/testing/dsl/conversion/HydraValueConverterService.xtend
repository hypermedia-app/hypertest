package app.hypermedia.testing.dsl.conversion

import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverter

class HydraValueConverterService extends CoreValueConverterService  {
    @ValueConverter(rule = "URI")
    def IValueConverter<String> getUriConverter() {
        return new UriConverter()
    }
}


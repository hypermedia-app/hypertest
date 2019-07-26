package app.hypermedia.testing.dsl.conversion

import org.eclipse.xtext.conversion.ValueConverter
import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.common.services.DefaultTerminalConverters

class CoreValueConverterService extends DefaultTerminalConverters  {
    @ValueConverter(rule = "VARIABLE")
    def IValueConverter<String> getVariableConverter() {
        return new VariableReferenceConverter()
    }

    @ValueConverter(rule = "PREFIX")
    def IValueConverter<String> getPrefixConverter() {
        return new PrefixConverter()
    }
}


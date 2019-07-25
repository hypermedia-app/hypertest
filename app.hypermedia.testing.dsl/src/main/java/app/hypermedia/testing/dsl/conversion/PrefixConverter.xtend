package app.hypermedia.testing.dsl.conversion

import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.nodemodel.INode

class PrefixConverter implements IValueConverter<String> {
    final String INVALID_VALUE_ERROR = "Prefix must end with a colon character"
    
    override toString(String value) {
        return value
    }
    
    override toValue(String string, INode node) throws ValueConverterException {
        if (string === null) {
            return null
        }
        
        if(string.length < 2 || !string.endsWith(":")) {
            throw new ValueConverterException(INVALID_VALUE_ERROR, node, null)
        }
        
        return string.substring(0, string.length - 1)
    }
}
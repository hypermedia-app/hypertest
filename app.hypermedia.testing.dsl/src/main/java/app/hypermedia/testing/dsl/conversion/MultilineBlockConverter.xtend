package app.hypermedia.testing.dsl.conversion

import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.nodemodel.INode

class MultilineBlockConverter implements IValueConverter<String> {
    final String INVALID_VALUE_ERROR = "Code block must be between triple backticks"
    
    override toString(String value) {
        return value
    }        
    
    override toValue(String string, INode node) throws ValueConverterException {
        if (string === null) {
            return null
        }
        
        if(string.length < 7 || !string.startsWith("```") || !string.endsWith("```")) {
            throw new ValueConverterException(INVALID_VALUE_ERROR, node, null)
        }
        
        return string.substring(3, string.length - 3).trim()
    }
}
package app.hypermedia.testing.dsl.conversion

import org.eclipse.xtext.conversion.IValueConverter
import org.eclipse.xtext.conversion.ValueConverterException
import org.eclipse.xtext.nodemodel.INode

class VariableReferenceConverter implements IValueConverter<String> {
    
    override toString(String value) throws ValueConverterException {
        return value.substring(1, value.length - 1)
    }
    
    override toValue(String string, INode node) throws ValueConverterException {
        return toString(string)
    }
    
}
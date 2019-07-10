package app.hypermedia.testing.dsl.tests.generator;

import org.eclipse.xtext.generator.IGeneratorContext;
import org.eclipse.xtext.util.CancelIndicator;

class GeneratorContext implements IGeneratorContext {

    @Override
    public CancelIndicator getCancelIndicator() {
        return CancelIndicator.NullImpl;
    }
}

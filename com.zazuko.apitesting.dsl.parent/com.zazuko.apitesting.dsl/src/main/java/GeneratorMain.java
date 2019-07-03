import java.util.List;
import java.util.Map.Entry;

import org.eclipse.emf.common.util.URI;
import org.eclipse.emf.ecore.resource.Resource;
import org.eclipse.xtext.generator.GeneratorDelegate;
import org.eclipse.xtext.generator.InMemoryFileSystemAccess;
import org.eclipse.xtext.resource.XtextResourceSet;
import org.eclipse.xtext.resource.XtextResource;
import org.eclipse.xtext.util.CancelIndicator;
import org.eclipse.xtext.validation.CheckMode;
import org.eclipse.xtext.validation.IResourceValidator;
import org.eclipse.xtext.validation.Issue;

import com.google.inject.Injector;

import com.zazuko.apitesting.dsl.CoreStandaloneSetup;

public class GeneratorMain {

	private static Injector injector = new CoreStandaloneSetup().createInjectorAndDoEMFRegistration();

	public static void main(String[] args) {
		XtextResourceSet resourceSet = injector.getInstance(XtextResourceSet.class);
		Resource resource = resourceSet.getResource(URI.createFileURI("/Users/tomaszpluskiewicz/projects/zazuko/api-testing-dsl/api-examples/simple.api"), true);
		
		IResourceValidator validator = ((XtextResource)resource).getResourceServiceProvider().getResourceValidator();
		List<Issue> issues = validator.validate(resource, CheckMode.ALL, CancelIndicator.NullImpl);
		for (Issue issue : issues) {
		  System.out.println(issue.getMessage());
		}
		
		// Code Generator
		GeneratorDelegate generator = injector.getInstance(GeneratorDelegate.class);
		InMemoryFileSystemAccess fsa = new InMemoryFileSystemAccess();
		generator.doGenerate(resource, fsa);
		for (Entry<String, CharSequence> file : fsa.getTextFiles().entrySet()) {
		  System.out.println("Generated file path : "+file.getKey());
		  System.out.println("Generated file contents : "+file.getValue());
		}
	}
}
